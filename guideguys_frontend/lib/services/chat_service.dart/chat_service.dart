import 'dart:convert';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/chat/chat_model.dart';
import 'package:guideguys/services/chat_service.dart/chat_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class ChatService implements ChatServiceInterface {
  String ip = localhostIp;

  @override
  Future<ChatModel?> fetchWaitingStatusConfirmForm() async {
    String token = await SecureStorage().readSecureData('token');
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/history/get/waiting/confirm'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return chatFromJson(response.body);
      } else if (response.statusCode == 404) {
        return null;
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> fetchChatRoom(
      {required String senderId, required String receiverId}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$ngrokLink/chats/create/chat/room'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "senderId": senderId,
          "receiverId": receiverId,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body).toString();
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> fetchChatHistory(
      {required String chatRoom}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/chats/get/chat/history/$chatRoom'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)
            .map<MessageModel>((msg) => MessageModel.fromJson(msg))
            .toList();
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> saveNewMessage(
      {required NewMeassageModel newMessage}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$ngrokLink/messages/send/newMessage'),
          headers: {'Content-Type': 'application/json'},
          body: newMeassageModelToJson(newMessage));

      if (response.statusCode == 200) {
        return MessageModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }
}
