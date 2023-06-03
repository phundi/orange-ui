import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> userList;
  final Function(Map<String, dynamic> data) onUserTap;

  const UserList({
    Key? key,
    required this.userList,
    required this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: userList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                onUserTap(userList[index]);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorRes.lightGrey2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        userList[index]['image'],
                        height: 49,
                        width: 49,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userList[index]['name'],
                              style: const TextStyle(
                                color: ColorRes.darkGrey4,
                                fontSize: 18,
                                fontFamily: 'gilroy_bold',
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              userList[index]['age'].toString(),
                              style: const TextStyle(
                                color: ColorRes.darkGrey4,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 3),
                            userList[index]['tickMark']
                                ? Image.asset(AssetRes.tickMark,
                                    height: 18, width: 18)
                                : const SizedBox(),
                          ],
                        ),
                        Text(
                          userList[index]['address'],
                          style: const TextStyle(
                            color: ColorRes.grey6,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
