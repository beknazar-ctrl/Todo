import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button("Upload"),
                  IconButton(
                      onPressed: () async {
                        image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          image = image;
                        });
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.teal,
                        size: 30,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return AssetImage("assets/flutter.jpg");
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width / 2,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad3f9),
            ])),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
