import 'package:flutter/material.dart';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/chat/chat_model.dart';
import 'package:guideguys/services/chat_service.dart/chat_service.dart';
import 'package:guideguys/services/chat_service.dart/chat_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatViewModel {
  ChatServiceInterface service = ChatService();
  late IO.Socket socket;
  // late Future<WaitingConfirmCardModel?> waitingFormData;
  // late Future<ChatModel> chatRoomDetailData;
  // late Future<List<MessageModel>> messageListData;
  late WaitingConfirmCardModel? waitingForm;
  late ChatModel chatRoomDetail;
  late List<MessageModel> messageList;
  final ScrollController scrollController = ScrollController();
  late Future<ChatViewData> chatViewData;
  late String roleUser;

  // setMessageListModel(List<MessageModel> allMessageList) {
  //   _messageList = allMessageList;
  //   // notifyListeners();
  // }

  Future<bool> fetchChatAllData({required String receiverId}) async {
    String senderId = await SecureStorage().readSecureData('myUserId');
    roleUser = await SecureStorage().readSecureData('myGuideId');
    try {
      waitingForm =
          await service.fetchWaitingStatusConfirmForm(userIdGuide: receiverId);
      chatRoomDetail = await service.fetchChatRoom(
          senderId: senderId, receiverId: receiverId);
      messageList =
          await service.fetchChatHistory(chatRoom: chatRoomDetail.roomId);

      socket.emit('joinRoom', {'room': chatRoomDetail.roomId});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
      return true;
    } catch (_) {
      rethrow;
    }
  }

  // Future<ChatViewData> fetchChatAllData({required String receiverId}) async {
  //   String senderId = await SecureStorage().readSecureData('userId');
  //   try {
  //     await Future.wait([
  //       service.fetchWaitingStatusConfirmForm(userIdGuide: receiverId),
  //       service.fetchChatRoom(senderId: senderId, receiverId: receiverId),
  //     ]).then((List res) async {
  //       waitingForm = res[0];
  //       chatRoomDetail = res[1];
  //       messageList =
  //           await service.fetchChatHistory(chatRoom: chatRoomDetail.roomId);

  //       // Call initSocket here after the completion of Future.wait
  //       initSocket();
  //     });

  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (scrollController.hasClients) {
  //         scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //       }
  //     });

  //     return ChatViewData(
  //       waitingForm: waitingForm,
  //       chatRoomDetail: chatRoomDetail,
  //       messageList: messageList,
  //     );
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  Future<void> refreshChatHistory() async {
    try {
      messageList =
          await service.fetchChatHistory(chatRoom: chatRoomDetail.roomId);
      // setMessageListModel(allMessages);
    } catch (_) {
      rethrow;
    }
  }

  void initSocket() {
    socket = IO.io(
      ngrokLink,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => throw err);
    socket.onError((err) => throw err);

    // socket.emit('joinRoom', {'room': chatRoomDetail.roomId});

    socket.on(
        'newMessage',
        (data) => {
              messageList.add(MessageModel.fromJson(data)),
            });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (scrollController.hasClients) {
    //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //   }
    // });
  }

  void sendMessage({required String messageController}) async {
    String message = messageController.trim();
    String senderId = await SecureStorage().readSecureData('myUserId');
    if (message.isEmpty) return;
    NewMeassageModel newMsg = NewMeassageModel(
      chatRoom: chatRoomDetail.roomId,
      msgText: message,
      createAt: DateTime.now(),
      senderId: senderId,
    );
    MessageModel savedMsg = await service.saveNewMessage(newMessage: newMsg);

    socket.emit(
      'message',
      {
        "chatRoom": newMsg.chatRoom,
        "message_text": savedMsg.messageText,
        "sender_username": savedMsg.senderUsername,
        "comment_date": savedMsg.sentAt.toString(),
      },
    );
  }

  void disconnectSocket() {
    socket.disconnect();
  }

  // addNewMessage(MessageModel message) {
  //   _messageList.add(message);
  //   // notifyListeners();
  // }
}

class ChatViewData {
  WaitingConfirmCardModel? waitingForm;
  ChatModel chatRoomDetail;
  List<MessageModel> messageList;

  ChatViewData({
    required this.waitingForm,
    required this.chatRoomDetail,
    required this.messageList,
  });
}
