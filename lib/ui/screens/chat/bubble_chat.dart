import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xff5169a2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(4),
              topLeft: Radius.circular(4),topRight:  Radius.circular(4) ),
        ),
      ),
    );
  }
}
