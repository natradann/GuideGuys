import 'dart:convert';

ChatModel chatFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int historyId;
  String status;
  String tourName;
  String guideId;
  String guideName;
  DateTime startDate;
  DateTime endDate;
  int price;

  ChatModel({
    required this.historyId,
    required this.status,
    required this.tourName,
    required this.guideId,
    required this.guideName,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        historyId: json["historyId"],
        status: json["status"],
        tourName: json["tourName"],
        guideId: json["guideId"],
        guideName: json["guideName"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "historyId": historyId,
        "status": status,
        "tourName": tourName,
        "guideId": guideId,
        "guideName": guideName,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "price": price,
      };
}

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  final String messageText;
  final String senderUsername;
  final DateTime sentAt;

  MessageModel({
    required this.messageText,
    required this.senderUsername,
    required this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> message) {
    // print(message);
    return MessageModel(
      messageText: message['message_text'],
      senderUsername: message['sender_username'],
      sentAt: DateTime.parse((message['comment_date'])),
    );
  }

  Map<String, dynamic> toJson() => {
        "sender_username": senderUsername,
        "message_text": messageText,
        "comment_date": sentAt.toIso8601String(),
      };
}

NewMeassageModel newMeassageModelFromJson(String str) =>
    NewMeassageModel.fromJson(json.decode(str));

String newMeassageModelToJson(NewMeassageModel data) =>
    json.encode(data.toJson());

class NewMeassageModel {
  String chatRoom;
  String msgText;
  DateTime createAt;
  String senderId;

  NewMeassageModel({
    required this.chatRoom,
    required this.msgText,
    required this.createAt,
    required this.senderId,
  });

  factory NewMeassageModel.fromJson(Map<String, dynamic> json) =>
      NewMeassageModel(
        chatRoom: json["chatRoom"],
        msgText: json["msgText"],
        createAt: DateTime.parse(json["createAt"]),
        senderId: json["senderId"],
      );

  Map<String, dynamic> toJson() => {
        "chatRoom": chatRoom,
        "msgText": msgText,
        "createAt": createAt.toIso8601String(),
        "senderId": senderId,
      };
}
