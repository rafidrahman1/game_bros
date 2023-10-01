import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/api/apis.dart'; // Import the APIs class
import 'package:game_bros/screens/chat_screen.dart'; // Import the ChatScreenState
import 'package:game_bros/screens/profile_screen.dart';
import 'package:game_bros/screens/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(246, 247, 249, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
          leading: Icon(CupertinoIcons.home),
          title: Text('Home'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: APIs.me)));
              },
              icon: Icon(Icons.person),
            ),
            SizedBox(width: 5)
          ],
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 2, // 2 buttons per row
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            padding: EdgeInsets.all(20.0),
            children: [
              // First button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          groupId:
                              'YOUR_GROUP_ID', // Replace with your group ID
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.message,
                      size: 50, color: Color.fromRGBO(120, 153, 123, 1)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 191, 232, 225),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),

              // Second button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UserScreen()),
                    );
                  },
                  child: Icon(Icons.group,
                      size: 50, color: Color.fromRGBO(152, 146, 147, 1)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(223, 225, 249, 1),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),

              // Third button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for the third button
                  },
                  child: Icon(Icons.search,
                      size: 50, color: Color.fromRGBO(184, 147, 140, 1)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 224, 218, 1),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),

              // Fourth button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for the fourth button
                  },
                  child: Icon(Icons.settings,
                      size: 50, color: Color.fromRGBO(173, 155, 105, 1)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(244, 234, 207, 1),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
