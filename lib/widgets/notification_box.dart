import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationBox extends StatelessWidget {
  final int number;
  final VoidCallback? onTap;

  const NotificationBox({
    Key? key,
    required this.number,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        child: _buildIcon(),
      ),
    );
  }

  _buildIcon() {
    return Icon(
      FontAwesomeIcons.solidBell,
      size: 20,
    );
  }
}