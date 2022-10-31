import 'package:flutter/material.dart';
import 'package:to_do/Costom/TodoCard.dart';
import 'package:to_do/Service/Auth_Service.dart';
import 'package:to_do/pages/SignUpPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/flutter.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                "Friday 7",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ])),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              label: "Settings"),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.yellow,
                Colors.red,
                Colors.indigo,
                Colors.teal,
              ],
            )
    ),
            child: Column(
              children: [
                TodoCard(),
              ],
            ),
          ),
      ),
    );
  }
}
