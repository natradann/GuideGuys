import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_view.dart';
import 'package:guideguys/modules/home/home_view.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.appBarKey,
    this.isChat = false,
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final Size preferredSize; // default is 56.0
  final GlobalKey<ScaffoldState> appBarKey;
  final bool isChat;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // leading: const Icon(Icons.outlined_flag, color: Colors.white,),
      title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
                (route) => false);
          },
          child: const Text("GuideGuys")),
      actions: (widget.isChat)
          ? []
          : [
              IconButton(
                icon: const Icon(Icons.chat_bubble_rounded),
                color: white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatRoomListView(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                color: white,
                onPressed: () {
                  !widget.appBarKey.currentState!.isEndDrawerOpen
                      ? widget.appBarKey.currentState!.openEndDrawer()
                      : null;
                },
              )
            ],
      backgroundColor: bgPurple,
    );
  }
}
