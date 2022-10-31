import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  TextItem(
      {Key? key,
      required this.labelText,})
      : super(key: key);

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
