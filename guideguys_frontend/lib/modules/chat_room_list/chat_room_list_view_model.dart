import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';
import 'package:guideguys/services/chat_room_list_service/chat_room_list_mock_service.dart';
import 'package:guideguys/services/chat_room_list_service/chat_room_list_service.dart';
import 'package:guideguys/services/chat_room_list_service/chat_room_list_service_interface.dart';

class ChatRoomListViewModel {
  ChatRoomListServiceInterface service = ChatRoomListService();
  late String userId;
  late List<ChatRoomListModel> chatRoomList;
  late Future<ChatRoomListData> roomListData;

  Future<ChatRoomListData> readAllChatRoomInfo() async {
    try {
      userId = await SecureStorage().readSecureData('myUserId');
      chatRoomList = await service.fetchAllChatRoom();
      return ChatRoomListData(roomListData: chatRoomList);
    } catch (_) {
      rethrow;
    }
  }
}

class ChatRoomListData {
  List<ChatRoomListModel> roomListData;

  ChatRoomListData({required this.roomListData});
}
