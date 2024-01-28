import 'package:flutter/material.dart';
import 'package:guideguys/modules/chat/chat_view.dart';
import 'package:guideguys/modules/chat_room_list/chat_room_list_model.dart';
import 'package:intl/intl.dart';

class ChatRoomCard extends StatelessWidget {
  const ChatRoomCard({
    required this.userId,
    required this.model,
    super.key,
  });

  final String userId;
  final ChatRoomListModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(
              guideId: (userId == model.user1Id) ? model.user2Id : model.user1Id,
              receiverId:
                  (userId == model.user1Id) ? model.user2Id : model.user1Id,
              role: 'guide',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),

        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/blank-profile-picture.png'),
                  radius: 25,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (userId == model.user1Id)
                    ? Text(
                        model.user2Username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        model.user1Username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                Text((model.lastMsg.msgText != null) ? model.lastMsg.msgText! : ''),
              ],
            ),
            const Spacer(),
            (model.lastMsg.commentDate != null) ?
            Text(
              DateFormat('hh:mm a').format(model.lastMsg.commentDate!),
            ) : const Spacer(),
          ],
        ),
      ),
    );
  }
}
