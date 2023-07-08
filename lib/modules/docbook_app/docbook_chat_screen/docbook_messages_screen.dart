import 'package:flutter/material.dart';
import 'package:ramdan_proj/shared/components/components.dart';

import '../../../layout/docbook_app/cubit/cubit.dart';
import 'docbook_chat_screen.dart';

class DocBookMessagesScreen extends StatelessWidget {
  DocBookMessagesScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Chats',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Colors.lightBlue.shade900,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 180,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recent Chats",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 11,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    minVerticalPadding: 22,
                    onTap: () {
                      navigateTo(
                          context,
                          const ChatScreen(),
                      );
                    },
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/man.png'),
                    ),
                    title: const Text(
                      "Dr.Zahraa Magdy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      'Hello,Doctor are you there?',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    trailing: const Text(
                      "12:30",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
