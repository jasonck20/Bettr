import 'package:flutter/material.dart';

class TimerFinishedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer Finished")),
      body: Center(child: Text("The timer has finished!")),
    );
  }
}
