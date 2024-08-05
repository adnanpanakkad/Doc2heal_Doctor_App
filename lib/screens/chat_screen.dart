import 'package:doc2heal_doctor/services/firebase/firebase_chat.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/widgets/chat/appbar.dart';
import 'package:doc2heal_doctor/widgets/chat/chat_message.dart';
import 'package:doc2heal_doctor/widgets/chat/user_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String reciverEmail;
  final String reciverID;

  const ChatScreen({
    super.key,
    required this.reciverEmail,
    required this.reciverID,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatRepository chatrepo = ChatRepository();
  final DoctorRepository doctorrepo = DoctorRepository();
  late Future<String> senderID;
  FocusNode myfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    senderID = doctorrepo.getCurrentUser();
    myfocusNode.addListener(() {
      if (myfocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myfocusNode.dispose();
    messageController.dispose();

    super.dispose();
  }

  ScrollController _scrollcontroller = ScrollController();

  void scrollDown() {
    _scrollcontroller.animateTo(
      _scrollcontroller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatrepo.sendMessage(widget.reciverID, messageController.text);
      messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.lightbackground,
        appBar: DeatialAppbar(
          text: widget.reciverEmail,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatMessages(
                reciverID: widget.reciverID,
                senderID: senderID,
                chatrepo: chatrepo,
                scrollcontroller: _scrollcontroller,
              ),
            ),
            UserInput(
              messageController: messageController,
              sendMessage: sendMessage,
              myfocusNode: myfocusNode,
            ),
          ],
        ),
      ),
    );
  }
}
