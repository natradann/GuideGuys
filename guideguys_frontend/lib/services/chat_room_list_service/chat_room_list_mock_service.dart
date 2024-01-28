import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';
import 'package:guideguys/services/chat_room_list_service/chat_room_list_service_interface.dart';

class ChatRoomListMockService implements ChatRoomListServiceInterface {
  @override
  Future<List<ChatRoomListModel>> fetchAllChatRoom() async {
    try {
      return [
        ChatRoomListModel(
          roomId: 1,
          user1Id: "2a463610-31f5-44d8-8ed6-30457b27cbd7",
          user1Username: "natradann",
          user2Id: "c3e3bc61-e366-4554-a457-7b6139ccff5e",
          user2Username: "nina",
          lastMsg: LastMsg(
            id: '16',
            msgText: "hihih",
            commentDate: DateTime.parse("2024-01-23T09:23:30.000Z"),
          ),
        ),
      ];
    } catch (_) {
      rethrow;
    }
  }
}
