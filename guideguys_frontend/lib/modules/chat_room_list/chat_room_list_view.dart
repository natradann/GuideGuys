import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_view_model.dart';
import 'package:guideguys/modules/chat_room_list/components/chat_room_card.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({super.key});

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ChatRoomListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ChatRoomListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey, isChat: true),
        body: FutureBuilder(
            future: _viewModel.readAllChatRoomInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _viewModel.chatRoomList.length,
                      itemBuilder: (context, index) {
                        ChatRoomListModel chatRoom =
                            _viewModel.chatRoomList[index];
                        return ChatRoomCard(
                          userId: _viewModel.userId,
                          model: chatRoom,
                        );
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: grey500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
