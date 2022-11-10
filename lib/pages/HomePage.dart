import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Costom/TodoCard.dart';
import 'package:to_do/Service/Auth_Service.dart';
import 'package:to_do/pages/AddTodo.dart';
import 'package:to_do/pages/Profile.dart';
import 'package:to_do/pages/SignUpPage.dart';
import 'package:to_do/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _streem =
        FirebaseFirestore.instance.collection("Todo").snapshots();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Friday 7",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                         var instance =
                            FirebaseFirestore.instance.collection("Todo");
                        // for (int i = 0; i < selected.length; i++);

                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 28,
                      )),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),
      ),
      body: StreamBuilder(
          stream: _streem,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;
                switch (document["Category"]) {
                  case "Work":
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.red;
                    break;
                  case "WorkOut":
                    iconData = Icons.alarm;
                    iconColor = Colors.teal;
                    break;
                  case "Food":
                    iconData = Icons.local_grocery_store;
                    iconColor = Colors.blue;
                    break;
                  case "Desing":
                    iconData = Icons.audiotrack;
                    iconColor = Colors.red;
                    break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.green;
                }
                selected.add(Select(
                    id: snapshot.data!.docs[index].id, checkValue: false));
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ViewData(
                                document: document,
                                id: snapshot.data!.docs[index].id)));
                  },
                  child: TodoCard(
                    check: selected[index].checkValue,
                    iconBGColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                    time: "10 AM",
                    title: document["title"] == null
                        ? "Hey there"
                        : document["title"],
                    index: index,
                    onChange: onChange,
                  ),
                );
              },
            );
          }),
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
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const AddTodoPage()));
                },
                child: Container(
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
              ),
              label: "Add"),
          BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Profile()));
                },
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              label: "Settings"),
        ],
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;

  Select({required this.id, required this.checkValue});
}
