import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import 'chat_sample.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                  Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 25,
              ),
          ),
          backgroundColor: defColor,
          leadingWidth: 30,
          title: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Expanded(
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/doc2.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Dr Zahraa Magdi',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top:8,right: 20),
              child: Icon(
                Ionicons.call,
                color: Colors.white,
                size: 26,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:8,right: 15),
              child: Icon(
                Ionicons.videocam,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20,left:15,right: 15,bottom: 80),
        itemBuilder: (context,index)=>const ChatSample(),
        itemCount: 10,
      ),
      bottomSheet: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children:  [
             Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundColor: defColor,
                  radius: 20,
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10),
              child: Container(
                alignment: FractionalOffset.centerRight,
                width: MediaQuery.of(context).size.width/1.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Type Something',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
             Padding(padding: EdgeInsets.only(
              right: 10,
            ),
            child:CircleAvatar(
              radius:20,
              backgroundColor: defColor,
              child: Icon(
                Ionicons.send,
                size: 20,
                color: Colors.white,
              ),
            ) ,
            ),
          ],
        ),
      ),
    );
  }
}
