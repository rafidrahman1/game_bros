import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/model/chat_user.dart';
import 'package:game_bros/screens/auth/login_screeen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../main.dart';

//profile screen to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.limeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Profile Screen'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          //New Conversation
          child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () async {
                // signout funciton
                Dialogs.showProgressbar(context);
                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    //for hiding progress dialog
                    Navigator.pop(context);
                    //for movig to home screen
                    Navigator.pop(context);
                    //replace home with login screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  });
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout')),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              //for addign some space
              SizedBox(
                width: mq.width,
                height: mq.height * .08,
              ),
              //user profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: mq.height * .15,
                  height: mq.height * .15,
                  fit: BoxFit.fill,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),

              SizedBox(
                height: mq.height * .02,
              ),
              Text(widget.user.email,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 21)),

              SizedBox(height: mq.height * .04),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Firstname',
                  label: Text('Name'),
                ),
              ),

              SizedBox(height: mq.height * .02),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.info, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Ex: Feelign great!',
                  label: Text('About'),
                ),
              ),

              SizedBox(height: mq.height * .03),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(mq.width * .5, mq.height * .066)),
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
