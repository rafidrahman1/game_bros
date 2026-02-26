import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_bros/model/chat_user.dart';
import 'package:game_bros/screens/auth/login_screeen.dart';
import 'package:game_bros/screens/home_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text('Profile Screen'),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            //New Conversation
            child: FloatingActionButton.extended(
                backgroundColor: Color.fromRGBO(255, 224, 218, 1),
                onPressed: () async {
                  // signout funciton
                  Dialogs.showProgressbar(context);
                  await APIs.auth.signOut().then((value) async {
                    await GoogleSignIn.instance.signOut().then((value) {
                      //for hiding progress dialog
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    });
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(247, 124, 100, 1),
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Color.fromRGBO(247, 124, 100, 1)),
                )),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //for addign some space
                    SizedBox(
                      width: mq.width,
                      height: mq.height * .08,
                    ),
                    //user profile picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        width: mq.height * .15,
                        height: mq.height * .15,
                        fit: BoxFit.fill,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                    //user email
                    SizedBox(
                      height: mq.height * .02,
                    ),
                    Text(widget.user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            fontSize: 25)),
                    //user name
                    SizedBox(height: mq.height * .04),
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromRGBO(157, 165, 176, 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Firstname',
                        label: Text('Name'),
                      ),
                    ),
                    //user about
                    SizedBox(height: mq.height * .02),
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.info,
                            color: Color.fromRGBO(157, 165, 176, 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Ex: Feelign great!',
                        label: Text('About'),
                      ),
                    ),
                    //Save Button
                    SizedBox(height: mq.height * .03),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: Size(mq.width * .5, mq.height * .066),
                          backgroundColor: Color.fromARGB(255, 191, 232, 225)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Fluttertoast.showToast(
                              msg: "Your data has been saved",
                            );
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Color.fromARGB(255, 88, 115, 111),
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 88, 115, 111)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
