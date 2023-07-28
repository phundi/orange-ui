import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:orange_ui/screen/chat_screen/widgets/image_video_msg_sheet.dart';
import 'package:orange_ui/screen/chat_screen/widgets/image_view_page.dart';
import 'package:orange_ui/screen/chat_screen/widgets/item_selection_dialog_android.dart';
import 'package:orange_ui/screen/chat_screen/widgets/item_selection_dialog_ios.dart';
import 'package:orange_ui/screen/chat_screen/widgets/unblock_user_dialog.dart';
import 'package:orange_ui/screen/explore_screen/widgets/reverse_swipe_dialog.dart';
import 'package:orange_ui/screen/live_stream_application_screen/widgets/video_upload_dialog.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet.dart';
import 'package:orange_ui/screen/video_preview_screen/video_preview_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/firebase_res.dart';
import 'package:orange_ui/utils/pref_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatScreenViewModel extends BaseViewModel {
  var db = FirebaseFirestore.instance;
  late DocumentReference documentSender;
  late DocumentReference documentReceiver;
  late CollectionReference drChatMessages;
  ImagePicker picker = ImagePicker();
  final _transformationController = TransformationController();
  static bool isScreen = false;

  TextEditingController textMsgController = TextEditingController();
  FocusNode msgFocusNode = FocusNode();
  TapDownDetails _doubleTapDetails = TapDownDetails();
  ScrollController scrollController = ScrollController();

  File? chatImage;
  File? cameraImage;
  XFile? _pickedFile;
  String? imagePath = '';
  String selectedItem = S.current.image;
  String blockUnblock = S.current.block;
  List<ChatMessage> chatData = [];
  String deletedId = '';

  StreamSubscription<QuerySnapshot<ChatMessage>>? chatStream;
  StreamSubscription<DocumentSnapshot<Conversation>>? conUserStream;

  Conversation? conversation;
  ChatUser? receiverUser;
  RegistrationUserData? registrationUserData;
  RegistrationUserData? conversationUserData;

  Map<String, List<ChatMessage>>? grouped;
  int startingNumber = 30;

  List<String> notDeletedIdentity = [];
  List<String> timeStamp = [];
  bool isLongPress = false;
  int? walletCoin = 0;
  bool isSelected = false;
  bool isBlock = false;
  bool isBlockOther = false;

  void init() {
    isScreen = true;
    conversation = Get.arguments;
    const MethodChannel(Urls.aBubblyCamera)
        .setMethodCallHandler((payload) async {
      if (payload.method == AppRes.isSuccessPurchase &&
          (payload.arguments as bool)) {
      } else {}
      return;
    });
    getValueFromPrefs();
    scrollToGetChat();
  }

  Future<void> getValueFromPrefs() async {
    PrefService.getUserData().then((value) {
      registrationUserData = value;
      blockUnblock =
          conversation?.block == true ? S.current.unBlock : S.current.block;
      isBlock = conversation?.block == true ? true : false;
      isBlockOther = conversation?.blockFromOther == true ? true : false;
      getProfileAPi();
      initFireBaseData();
    });
    ApiProvider().getProfile(userID: conversation?.user?.userid).then((value) {
      conversationUserData = value?.data;
      notifyListeners();
    });
  }

  Future<void> getProfileAPi() async {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) async {
      registrationUserData = value?.data;
      walletCoin = value?.data?.wallet;
      isSelected =
          await PrefService.getDialog(PrefConst.isMessageDialog) ?? false;
      blockUnblock = value?.data?.blockedUsers
                  ?.contains('${conversation?.user?.userid}') ==
              true
          ? S.current.unBlock
          : S.current.block;
      await PrefService.saveUser(value?.data);
    });
  }

  /// initialise firebase value
  void initFireBaseData() {
    documentReceiver = db
        .collection(FirebaseRes.userChatList)
        .doc(conversation?.user?.userIdentity)
        .collection(FirebaseRes.userList)
        .doc(registrationUserData?.identity);
    documentSender = db
        .collection(FirebaseRes.userChatList)
        .doc(registrationUserData?.identity)
        .collection(FirebaseRes.userList)
        .doc(conversation?.user?.userIdentity);

    documentSender
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then(
      (value) async {
        if (value.data() != null && value.data()?.conversationId != null) {
          conversation?.setConversationId(value.data()?.conversationId);
        }
        drChatMessages = db
            .collection(FirebaseRes.chat)
            .doc(conversation?.conversationId)
            .collection(FirebaseRes.chat);
        getChat();
      },
    );
  }

  Future<void> minusCoinApi() async {
    await ApiProvider().minusCoinFromWallet(PrefService.messagePrice);
  }

  void scrollToGetChat() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        getChat();
      }
    });
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onUserTap() {
    Get.to(() => const UserDetailScreen(),
        arguments: conversation?.user?.userid);
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }

  void onCancelBtnClick() {
    timeStamp = [];
    notifyListeners();
  }

  /// chat item delete method
  void chatDeleteDialog() {
    Get.dialog(
      ConfirmationDialog(
        aspectRatio: 1 / 0.7,
        clickText1: S.current.delete,
        clickText2: S.current.cancel,
        heading: S.current.deleteMessage,
        subDescription: S.current.areYouSureYouEtc,
        onNoBtnClick: onBackBtnTap,
        onYesBtnClick: onDeleteBtnClick,
        horizontalPadding: 65,
      ),
    );
  }

  void onDeleteBtnClick() {
    for (int i = 0; i < timeStamp.length; i++) {
      drChatMessages.doc(timeStamp[i]).update(
        {
          FirebaseRes.noDeleteIdentity: FieldValue.arrayRemove(
            ['${registrationUserData?.identity}'],
          )
        },
      );
      chatData.removeWhere(
        (element) => element.time.toString() == timeStamp[i],
      );
    }
    timeStamp = [];
    Get.back();
    notifyListeners();
  }

  /// long press to select chat method
  void onLongPress(ChatMessage? data) {
    if (!timeStamp.contains('${data?.time?.round()}')) {
      timeStamp.add('${data?.time?.round()}');
    } else {
      timeStamp.remove('${data?.time?.round()}');
    }
    isLongPress = true;
    notifyListeners();
  }

  void unblockDialog() {
    Get.dialog(UnblockUserDialog(
      onCancelBtnClick: onBackBtnTap,
      unblockUser: unBlockUser,
      name: conversation?.user?.username,
    ));
  }

  /// more btn event
  Future<void> onMoreBtnTap(String value) async {
    if (value == S.current.block) {
      blockUser();
    }
    if (value == S.current.unBlock) {
      unBlockUser();
    }

    if (value == AppRes.report) {
      Get.bottomSheet(
        UserReportSheet(reportId: conversation?.user?.userid),
        isScrollControlled: true,
        settings: RouteSettings(
          arguments: {
            AppRes.reportName: conversation?.user?.username,
            AppRes.reportImage: conversation?.user?.image,
            AppRes.reportAge: conversation?.user?.age,
            AppRes.reportAddress: conversation?.user?.city
          },
        ),
      );
    }
  }

  Future<void> blockUser() async {
    ApiProvider().userBlockList(conversation?.user?.userid);
    await db
        .collection(FirebaseRes.userChatList)
        .doc(registrationUserData?.identity)
        .collection(FirebaseRes.userList)
        .doc(conversation?.user?.userIdentity)
        .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (Conversation value, options) {
              return value.toFirestore();
            })
        .update({
      FirebaseRes.block: true,
    });
    await db
        .collection(FirebaseRes.userChatList)
        .doc(conversation?.user?.userIdentity)
        .collection(FirebaseRes.userList)
        .doc(registrationUserData?.identity)
        .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (Conversation value, options) {
              return value.toFirestore();
            })
        .update({
      FirebaseRes.blockFromOther: true,
    });
    blockUnblock = S.current.unBlock;
    isBlock = true;
    isBlockOther = true;
    notifyListeners();
  }

  Future<void> unBlockUser() async {
    ApiProvider().userBlockList(conversation?.user?.userid);
    await db
        .collection(FirebaseRes.userChatList)
        .doc(registrationUserData?.identity)
        .collection(FirebaseRes.userList)
        .doc(conversation?.user?.userIdentity)
        .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (Conversation value, options) {
              return value.toFirestore();
            })
        .update({
      FirebaseRes.block: false,
    });
    await db
        .collection(FirebaseRes.userChatList)
        .doc(conversation?.user?.userIdentity)
        .collection(FirebaseRes.userList)
        .doc(registrationUserData?.identity)
        .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (Conversation value, options) {
              return value.toFirestore();
            })
        .update({
      FirebaseRes.blockFromOther: false,
    });
    blockUnblock = S.current.block;
    isBlock = false;
    isBlockOther = false;
    notifyListeners();
  }

  /// navigate to imageviewScreen
  void onImageTap(ChatMessage? imageData) {
    Get.to(
      () => ImageViewPage(
        userData: imageData,
        onBack: onBackBtnTap,
        transformationController: _transformationController,
        handleDoubleTap: _handleDoubleTap,
        handleDoubleTapDown: _handleDoubleTapDown,
      ),
    )?.then((value) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: ColorRes.transparent,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ));
      _transformationController.value = Matrix4.identity();
    });
  }

  /// send a text message
  void onSendBtnTap() {
    if (conversation?.blockFromOther == true) {
      SnackBarWidget().snackBarWidget(S.current.thisUserBlockYou);
      textMsgController.clear();
      return;
    }
    if (registrationUserData?.isFake != 1) {
      if (textMsgController.text.trim() != '') {
        if (PrefService.reverseSwipePrice <= walletCoin! && walletCoin != 0) {
          !isSelected
              ? getChatMsgDialog(onContinueTap: onTextMsgContinueClick)
              : onMessageSent();
        } else {
          emptyDialog();
        }
      }
    } else {
      firebaseMsgUpdate(
              msgType: FirebaseRes.msg,
              textMessage: textMsgController.text.trim())
          .then((value) {
        textMsgController.clear();
      });
    }
  }

  void onTextMsgContinueClick(bool isSelected) {
    PrefService.setDialog(PrefConst.isMessageDialog, isSelected);
    minusCoinApi().then(
      (value) {
        onBackBtnTap();
        firebaseMsgUpdate(
          msgType: FirebaseRes.msg,
          textMessage: textMsgController.text.trim(),
        );
        textMsgController.clear();
      },
    );
  }

  void onMessageSent() {
    String text = textMsgController.text;
    textMsgController.clear();
    minusCoinApi().then(
      (value) async {
        getProfileAPi();
        firebaseMsgUpdate(msgType: FirebaseRes.msg, textMessage: text.trim());
      },
    );
  }

  void onPlusTap() {
    minusCoinApi().then(
      (value) {
        getProfileAPi();
        onAddBtnTap();
      },
    );
  }

  /// send a image method
  void onSendBtnClick(String msg, String? image) {
    firebaseMsgUpdate(
        image: image, msgType: FirebaseRes.image, textMessage: msg);
    Get.back();
  }

  void onPlusBtnClick() {
    if (registrationUserData?.isFake != 1) {
      if (PrefService.reverseSwipePrice <= walletCoin! && walletCoin != 0) {
        !isSelected
            ? getChatMsgDialog(onContinueTap: onPlusContinueClick)
            : onPlusTap();
      } else {
        emptyDialog();
      }
    } else {
      onAddBtnTap();
    }
  }

  void onPlusContinueClick(bool isSelected) {
    PrefService.setDialog(PrefConst.isMessageDialog, isSelected);
    minusCoinApi().then(
      (value) {
        onBackBtnTap();
        onAddBtnTap();
      },
    );
  }

  /// Add btn to choose photo or video method
  void onAddBtnTap() async {
    msgFocusNode.unfocus();
    if (conversation?.blockFromOther == true) {
      SnackBarWidget().snackBarWidget(S.current.thisUserBlockYou);
      return;
    }
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      late final Map<Permission, PermissionStatus> statusess;

      if (androidInfo.version.sdkInt <= 32) {
        statusess = await [
          Permission.storage,
        ].request();
      } else {
        statusess = await [
          Permission.photos,
          Permission.videos,
        ].request();
      }

      var allAccepted = true;
      statusess.forEach((permission, status) {
        if (status != PermissionStatus.granted) {
          allAccepted = false;
        }
      });
      if (!allAccepted) {
        openAppSettings();
        return;
      }
    }
    Platform.isIOS
        ? Get.bottomSheet(
            ItemSelectionDialogIos(
              onCloseBtnClickIos: onBackBtnTap,
              onImageBtnClickIos: () {
                itemSelectImage();
              },
              onVideoBtnClickIos: itemSelectVideo,
            ),
          )
        : showModalBottomSheet(
            context: Get.context!,
            backgroundColor: ColorRes.transparent,
            builder: (BuildContext context) {
              return ItemSelectionDialogAndroid(
                onCloseBtnClick: onBackBtnTap,
                onImageBtnClick: itemSelectImage,
                onVideoBtnClick: itemSelectVideo,
              );
            },
          );
  }

  /// selected video or image method
  void itemSelectImage() async {
    selectedItem = S.current.image;
    final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: quality,
        maxHeight: maxHeight,
        maxWidth: maxWidth);
    if (photo == null || photo.path.isEmpty) return;
    cameraImage = File(photo.path);
    ApiProvider().getStoreFileGivePath(image: cameraImage).then(
      (value) {
        if (value.status == true) {
          Get.back();
          Get.bottomSheet(
              ImageVideoMsgSheet(
                  image: value.path,
                  onSendBtnClick: onSendBtnClick,
                  selectedItem: selectedItem),
              isScrollControlled: true);
        }
        notifyListeners();
      },
    );
  }

  void itemSelectVideo() async {
    selectedItem = S.current.videoCap;
    _pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );

    if (_pickedFile == null || _pickedFile!.path.isEmpty) return;

    /// calculating file size
    final videoFile = File(_pickedFile?.path ?? '');
    int sizeInBytes = videoFile.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    if (sizeInMb <= 15) {
      VideoThumbnail.thumbnailFile(
        video: _pickedFile!.path,
      ).then(
        (value) {
          Get.back();
          Get.bottomSheet(
            ImageVideoMsgSheet(
              image: value,
              selectedItem: selectedItem,
              onSendBtnClick: (msg, image) {
                showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return Loader().lottieWidget();
                  },
                );
                ApiProvider()
                    .getStoreFileGivePath(
                  image: File(image ?? ''),
                )
                    .then(
                  (value) {
                    imagePath = value.path;
                    ApiProvider().getStoreFileGivePath(image: videoFile).then(
                      (value) {
                        firebaseMsgUpdate(
                            video: value.path,
                            msgType: FirebaseRes.video,
                            textMessage: msg,
                            image: imagePath);
                        Get.back();
                        Get.back();
                      },
                    );
                  },
                );
              },
            ),
            isScrollControlled: true,
          );
        },
      );
    } else {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return VideoUploadDialog(
            cancelBtnTap: onBackBtnTap,
            selectAnother: () {
              Get.back();
              itemSelectVideo();
            },
          );
        },
      );
    }
  }

  ///  video preview screen navigate
  void onVideoItemClick(ChatMessage? data) {
    Get.to(() => const VideoPreviewScreen(), arguments: data?.video)
        ?.then((value) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ColorRes.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      );
    });
  }

  void prefCameraTap() {
    minusCoinApi().then(
      (value) {
        getProfileAPi();
        onCameraTap();
      },
    );
  }

  void cameraClick() {
    if (registrationUserData?.isFake != 1) {
      if (PrefService.reverseSwipePrice <= walletCoin! && walletCoin != 0) {
        !isSelected
            ? getChatMsgDialog(onContinueTap: onCameraContinueClick)
            : prefCameraTap();
      } else {
        emptyDialog();
      }
    } else {
      onCameraTap();
    }
  }

  void onCameraContinueClick(bool isSelected) {
    PrefService.setDialog(PrefConst.isMessageDialog, isSelected);
    minusCoinApi().then(
      (value) {
        onBackBtnTap();
        onCameraTap();
      },
    );
  }

  /// camera button tap
  Future<void> onCameraTap() async {
    if (conversation?.blockFromOther == true) {
      SnackBarWidget().snackBarWidget(S.current.thisUserBlockYou);
      textMsgController.clear();
      return;
    }
    PermissionStatus status = await Permission.camera.request();

    var allAccepted = true;
    if (status != PermissionStatus.granted) {
      allAccepted = false;
    }
    if (!allAccepted) {
      openAppSettings();
      return;
    }

    try {
      final XFile? photo = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: quality,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          preferredCameraDevice: CameraDevice.front);

      if (photo == null || photo.path.isEmpty) return;
      chatImage = File(photo.path);
      ApiProvider().getStoreFileGivePath(image: chatImage).then(
        (value) {
          if (value.status == true) {
            firebaseMsgUpdate(image: value.path, msgType: FirebaseRes.image);
          }
          notifyListeners();
        },
      );
    } on PlatformException catch (e) {
      SnackBarWidget().snackBarWidget('${e.message}');
    }
  }

  ///User chat method
  void getChat() async {
    await documentReceiver
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then(
      (value) {
        receiverUser = value.data()?.user;
      },
    );

    await documentSender
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then((value) {
      deletedId = value.data()?.deletedId.toString() ?? '';
      notifyListeners();
    });

    chatStream = drChatMessages
        .where(FirebaseRes.noDeleteIdentity,
            arrayContains: registrationUserData?.identity)
        .where(FirebaseRes.time,
            isGreaterThan: deletedId.isEmpty ? 0.0 : double.parse(deletedId))
        .orderBy(FirebaseRes.time, descending: true)
        .limit(startingNumber)
        .withConverter(
          fromFirestore: ChatMessage.fromFirestore,
          toFirestore: (ChatMessage value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .listen(
      (element) async {
        chatData = [];
        for (int i = 0; i < element.docs.length; i++) {
          chatData.add(element.docs[i].data());
        }
        grouped = groupBy<ChatMessage, String>(
          chatData,
          (message) {
            final now = DateTime.now();
            DateTime time =
                DateTime.fromMillisecondsSinceEpoch(message.time!.toInt());
            if (DateFormat(AppRes.dMY).format(DateTime.now()) ==
                DateFormat(AppRes.dMY).format(time)) {
              return S.current.today;
            }
            if (DateFormat(AppRes.dMY)
                    .format(DateTime(now.year, now.month, now.day - 1)) ==
                DateFormat(AppRes.dMY).format(time)) {
              return S.current.yesterday;
            } else {
              return DateFormat(AppRes.dMY).format(time);
            }
          },
        );
        startingNumber += 45;
        notifyListeners();
      },
    );
  }

  ///Firebase message update method
  Future<void> firebaseMsgUpdate(
      {required String msgType,
      String? textMessage,
      String? image,
      String? video}) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    notDeletedIdentity = [];
    notDeletedIdentity.addAll(
      [
        '${registrationUserData?.identity}',
        '${conversation?.user?.userIdentity}'
      ],
    );

    drChatMessages
        .doc(
          time.toString(),
        )
        .set(
          ChatMessage(
            notDeletedIdentities: notDeletedIdentity,
            senderUser: ChatUser(
              username: registrationUserData?.fullname,
              date: time.toDouble(),
              isHost: false,
              isNewMsg: true,
              userid: registrationUserData?.id,
              userIdentity: registrationUserData?.identity,
              image: registrationUserData?.images?[0].image,
              city: registrationUserData?.live,
              age: registrationUserData?.age.toString(),
            ),
            msgType: msgType,
            msg: textMessage,
            image: image,
            video: video,
            id: conversation?.user?.userid?.toString(),
            time: time.toDouble(),
          ).toJson(),
        );

    if (chatData.isEmpty && deletedId.isEmpty) {
      Map con = conversation?.toJson() ?? {};
      con[FirebaseRes.lastMsg] = msgType == FirebaseRes.image
          ? '🖼️ ${FirebaseRes.image}'
          : msgType == FirebaseRes.video
              ? '🎥 ${FirebaseRes.video}'
              : textMessage;
      documentSender.set(con);
      documentReceiver.set(
        Conversation(
          block: false,
          blockFromOther: false,
          conversationId: conversation?.conversationId,
          deletedId: '',
          isDeleted: false,
          isMute: false,
          lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : textMessage,
          newMsg: textMessage,
          time: DateTime.now().millisecondsSinceEpoch.toDouble(),
          user: ChatUser(
            username: registrationUserData?.fullname,
            date: DateTime.now().millisecondsSinceEpoch.toDouble(),
            isHost: registrationUserData?.isVerified == 2 ? true : false,
            isNewMsg: true,
            userid: registrationUserData?.id,
            userIdentity: registrationUserData?.identity,
            image: registrationUserData?.images?[0].image,
            city: registrationUserData?.live,
            age: registrationUserData?.age.toString(),
          ),
        ).toJson(),
      );
    } else {
      receiverUser?.isNewMsg = true;
      documentReceiver.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: DateTime.now().millisecondsSinceEpoch.toDouble(),
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : textMessage,
          FirebaseRes.user: receiverUser?.toJson(),
        },
      );
      documentSender.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: DateTime.now().millisecondsSinceEpoch.toDouble(),
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : textMessage
        },
      );
    }

    conversationUserData?.isNotification == 1
        ? ApiProvider().pushNotification(
            title: registrationUserData?.fullname ?? '',
            body: msgType == FirebaseRes.image
                ? '🖼️ ${FirebaseRes.image}'
                : msgType == FirebaseRes.video
                    ? '🎥 ${FirebaseRes.video}'
                    : '$textMessage',
            token: '${conversationUserData?.deviceToken}')
        : null;
  }

  void emptyDialog() {
    Get.dialog(
      EmptyWalletDialog(
        onCancelTap: onBackBtnTap,
        onContinueTap: () {
          Get.back();
          Get.bottomSheet(
            const BottomDiamondShop(),
          );
        },
        walletCoin: walletCoin,
      ),
    );
  }

  void getChatMsgDialog({required Function(bool isSelected) onContinueTap}) {
    Get.dialog(
      ReverseSwipeDialog(
          onCancelTap: onBackBtnTap,
          onContinueTap: onContinueTap,
          isCheckBoxVisible: true,
          walletCoin: walletCoin,
          title1: S.current.message.toUpperCase(),
          title2: S.current.priceCap,
          dialogDisc: AppRes.messageDisc,
          coinPrice: '${PrefService.messagePrice}'),
    ).then((value) {
      getProfileAPi();
    });
  }

  /// Dispose Method
  @override
  void dispose() {
    documentSender
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then(
      (value) {
        var senderUser = value.data()?.user;
        senderUser?.isNewMsg = false;
        documentSender.update(
          {
            FirebaseRes.user: senderUser?.toJson(),
          },
        );
      },
    );
    isScreen = false;
    chatStream?.cancel();
    conUserStream?.cancel();
    scrollController.dispose();
    textMsgController.dispose();
    _transformationController.dispose();

    super.dispose();
  }
}
