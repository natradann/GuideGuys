import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/chat/chat_model.dart';
import 'package:guideguys/modules/chat/chat_provider.dart';
import 'package:guideguys/modules/chat/chat_view_model.dart';
import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_view.dart';
import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_view.dart';
import 'package:guideguys/modules/travel_history/components/tour_history_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ChatView extends StatefulWidget {
  const ChatView({
    required this.guideId,
    required this.receiverUsername,
    required this.receiverId,
    required this.role,
    super.key,
  });

  final String guideId;
  final String receiverUsername;
  final String receiverId;
  final String role;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatViewModel _viewModel;
  final TextEditingController _messageInputController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _viewModel = context.watch<ChatViewModel>();
    _viewModel = ChatViewModel();
    _viewModel.initSocket();
  }

  @override
  void dispose() {
    _viewModel.socket.disconnect();
    _viewModel.socket.dispose();
    super.dispose();
    _messageInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    // ChatViewModel _viewModel = context.watch<ChatViewModel>();

    return SafeArea(
      child: FutureBuilder(
        future: _viewModel.fetchWaitingStatusForm(
          receiverId: widget.receiverId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: bgColor,
              resizeToAvoidBottomInset: true,
              appBar: CustomAppBar(
                appBarKey: _scaffoldKey,
                isChat: true,
              ),
              // endDrawer: ProfileMenu(width: width),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.receiverUsername,
                      style: const TextStyle(
                          color: textPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    const SeperateLine(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _viewModel.scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _viewModel.messageList.length,
                        itemBuilder: (context, index) {
                          final message = _viewModel.messageList[index];
                          return Wrap(
                            alignment: message.senderUsername !=
                                    widget.receiverUsername
                                ? WrapAlignment.end
                                : WrapAlignment.start,
                            children: [
                              Card(
                                color: message.senderUsername !=
                                        widget.receiverUsername
                                    ? yellow
                                    : white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        message.senderUsername !=
                                                widget.receiverUsername
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Text(message.messageText),
                                      Text(
                                        DateFormat('hh:mm a')
                                            .format(message.sentAt),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (_viewModel.waitingForm != null)
                        ? TourHistoryCard(
                            tourName: _viewModel.waitingForm!.tourName,
                            guideName: _viewModel.waitingForm!.guideName,
                            startDate: _viewModel.waitingForm!.startDate,
                            endDate: _viewModel.waitingForm!.endDate,
                            price: _viewModel.waitingForm!.price,
                            screenWidth: width,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ConfirmGuideDetailView(
                                          historyId: '2'),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                    Container(
                      height: height * 0.09,
                      width: double.infinity,
                      color: bgPurple,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (widget.role == 'guide')
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.edit_document),
                                    iconSize: width * 0.07,
                                    color: white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CreateConfirmGuideView(
                                            guideId: widget.guideId,
                                            userId:
                                                '2a463610-31f5-44d8-8ed6-30457b27cbd7',
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.image_outlined),
                              iconSize: width * 0.08,
                              color: white,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                controller: _messageInputController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: bgColor,
                                  hintText: "Message...",
                                  hintStyle: const TextStyle(color: textPurple),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (_messageInputController.text
                                          .trim()
                                          .isNotEmpty) {
                                        _viewModel.sendMessage(
                                            messageController:
                                                _messageInputController.text);
                                        setState(() {
                                          _messageInputController.clear();
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send_rounded,
                                      color: bgPurple,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    color: grey500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Loading...',
                    style: GoogleFonts.notoSansThai(
                      color: grey700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
