import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Color(0xff6cf89),
                checkColor: Color(0xff0e3e26),
                value: false,
                onChanged: (bool? value) {},
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
          ),
          Container(
            height: 55,
          ),
        ],
      ),
    );
  }
}
