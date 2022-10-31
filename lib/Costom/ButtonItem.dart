import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem(
      {Key? key,
      required this.imagePath,
      required this.onClick,
      required this.text,
      required this.size,
      required this.iconData})
      : super(key: key);

  final String text;
  final String imagePath;
  final Function onClick;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
