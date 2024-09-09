import 'package:flutter/material.dart';

class DismissBackground extends StatelessWidget {
  const DismissBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
