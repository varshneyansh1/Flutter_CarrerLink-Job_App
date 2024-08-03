import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobhub/models/response/chat/get_chat.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  List<String> _online = [];
  bool _typing = false;

  bool get typing => _typing;

  set typingStatus(bool newState) {
    _typing = newState;
    notifyListeners();
  }

  List<String> get online => _online;

  set onlineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now().toUtc();
    DateTime messageTimeUtc = DateTime.parse(timestamp).toUtc();

    // Adjusting for IST (UTC+5:30)
    DateTime messageTimeIST =
        messageTimeUtc.add(const Duration(hours: 5, minutes: 30));

    if (now.year == messageTimeIST.year &&
        now.month == messageTimeIST.month &&
        now.day == messageTimeIST.day) {
      return DateFormat.jm().format(messageTimeIST);
    } else if (now.year == messageTimeIST.year &&
        now.month == messageTimeIST.month &&
        now.day - messageTimeIST.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMEd().format(messageTimeIST);
    }
  }
}
