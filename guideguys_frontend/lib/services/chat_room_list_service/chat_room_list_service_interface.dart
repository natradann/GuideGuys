import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';

abstract class ChatRoomListServiceInterface {
  Future<List<ChatRoomListModel>> fetchAllChatRoom();
}
