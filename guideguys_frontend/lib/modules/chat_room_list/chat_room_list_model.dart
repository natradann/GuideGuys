import 'dart:convert';

List<ChatRoomListModel> chatRoomListModelFromJson(String str) => List<ChatRoomListModel>.from(json.decode(str).map((x) => ChatRoomListModel.fromJson(x)));

String chatRoomListModelToJson(List<ChatRoomListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatRoomListModel {
    int roomId;
    String user1Id;
    String user1Username;
    String user2Id;
    String user2Username;
    LastMsg lastMsg;

    ChatRoomListModel({
        required this.roomId,
        required this.user1Id,
        required this.user1Username,
        required this.user2Id,
        required this.user2Username,
        required this.lastMsg,
    });

    factory ChatRoomListModel.fromJson(Map<String, dynamic> json) => ChatRoomListModel(
        roomId: json["room_id"],
        user1Id: json["user1_id"],
        user1Username: json["user1_username"],
        user2Id: json["user2_id"],
        user2Username: json["user2_username"],
        lastMsg: LastMsg.fromJson(json["last_msg"]),
    );

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "user1_id": user1Id,
        "user1_username": user1Username,
        "user2_id": user2Id,
        "user2_username": user2Username,
        "last_msg": lastMsg.toJson(),
    };
}

class LastMsg {
    int id;
    String msgText;
    DateTime commentDate;

    LastMsg({
        required this.id,
        required this.msgText,
        required this.commentDate,
    });

    factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
        id: json["id"],
        msgText: json["msg_text"],
        commentDate: DateTime.parse(json["comment_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "msg_text": msgText,
        "comment_date": commentDate.toIso8601String(),
    };
}
