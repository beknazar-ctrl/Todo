import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onClick,
    required this.imagePath,
  }) : super(key: key);

  final String text;
  final String imagePath;
  final Function onClick;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c),
          ]),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
