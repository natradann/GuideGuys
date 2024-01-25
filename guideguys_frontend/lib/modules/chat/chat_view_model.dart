import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/chat/chat_model.dart';
import 'package:guideguys/services/chat_service.dart/chat_service.dart';
import 'package:guideguys/services/chat_service.dart/chat_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatViewModel {
  late IO.Socket socket;
  ChatServiceInterface service = ChatService();
  late ChatModel? waitingForm;
  late String chatRoom;
  List<MessageModel> _messageList = [];
  final ScrollController scrollController = ScrollController();

  List<MessageModel> get messageList => _messageList;

  setMessageListModel(List<MessageModel> allMessageList) {
    _messageList = allMessageList;
    // notifyListeners();
  }

  Future<bool> fetchWaitingStatusForm({required String receiverId}) async {
    String senderId = await SecureStorage().readSecureData('userId');
    try {
      waitingForm = await service.fetchWaitingStatusConfirmForm();
      chatRoom = await service.fetchChatRoom(
          senderId: senderId, receiverId: receiverId);
      List<MessageModel> allMessage =
          await service.fetchChatHistory(chatRoom: chatRoom);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
      socket.emit('joinRoom', {'room': chatRoom});
      setMessageListModel(allMessage);
      
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> refreshChatHistory() async {
    try {
      List<MessageModel> allMessages = await service.fetchChatHistory(chatRoom: chatRoom);
      setMessageListModel(allMessages);
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

    socket.on(
      'newMessage',
      (data) => messageList.add(
        MessageModel.fromJson(data),
      ),
    );
  }

  void sendMessage({required String messageController}) async {
    String message = messageController.trim();
    String senderId = await SecureStorage().readSecureData('userId');
    if (message.isEmpty) return;
    NewMeassageModel newMsg = NewMeassageModel(
      chatRoom: chatRoom,
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
        "comment_date": savedMsg.sentAt.toIso8601String(),
      },
    );
  }

   addNewMessage(MessageModel message) {
    _messageList.add(message);
    // notifyListeners();
  }
}
