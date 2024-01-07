import 'package:bettr/create_bet.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final String passedValue; // This should be a string representation of time in hours
  final String stringValue;
  final String intValue;

  HomeScreen({Key? key, required this.stringValue, required this.intValue, required this.passedValue}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  int _remainingTime = 0;
  bool _isPaused = true;

  @override
  void initState() {
    super.initState();
    int totalHours = int.tryParse(widget.passedValue) ?? 0;
    _remainingTime = totalHours * 3600; // Convert hours to seconds

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0 && !_isPaused) {
        setState(() {
          _remainingTime--;
        });
      } else if (_remainingTime == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _toggleTimer() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    String wagerName = widget.stringValue;
    String moneyPlaced = widget.intValue;
    String time = widget.passedValue;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('HOME', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.blueGrey,
        elevation: 4,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.people_alt_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Ongoing',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Wager Name: $wagerName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'Money Placed: $moneyPlaced',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'Time: $time hours',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 50),
              Opacity(
                opacity: 0.3,
                child: Image.asset('images/money_racoon.png'),
              ),
              Text('Remaining Time: ${formatDuration(_remainingTime)}', style: TextStyle(fontSize: 20, color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleTimer,
                child: Text(_isPaused ? 'Continue' : 'Pause'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBet()));
        },
        icon: const Icon(Icons.add),
        iconSize: 60,
      ),
    );
  }
}