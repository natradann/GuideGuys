import 'package:guideguys/modules/chat/chat_model.dart';

abstract class ChatServiceInterface {
  Future<ChatModel?> fetchWaitingStatusConfirmForm();
  Future<String> fetchChatRoom(
      {required String senderId, required String receiverId});
  Future<List<MessageModel>> fetchChatHistory({required String chatRoom});
  Future<MessageModel> saveNewMessage({required NewMeassageModel newMessage});
}
