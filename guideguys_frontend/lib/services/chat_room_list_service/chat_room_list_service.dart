import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';
import 'package:guideguys/services/chat_room_list_service/chat_room_list_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class ChatRoomListService implements ChatRoomListServiceInterface {
  String ip = localhostIp;
  @override
  Future<List<ChatRoomListModel>> fetchAllChatRoom() async {
    String userId = await SecureStorage().readSecureData('myUserId');
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/chats/get/all/chatRoom/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return chatRoomListModelFromJson(response.body);
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
