import 'package:flutter/material.dart';

class ShowTabl extends StatelessWidget {
  final String child;
  ShowTabl({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
       
        height: 200,
        color: Colors.black,
        child: Center(
            child: Text(
          child,
          style: const TextStyle(fontSize: 40, color: Colors.purpleAccent),
        )),
      ),
    );
  }
}
