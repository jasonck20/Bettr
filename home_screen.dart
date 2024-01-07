import 'package:bettr/details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bettr/create_bet.dart';


class FakeFriendListPage extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {'name': 'Alice', 'points': '120'},
    {'name': 'Bob', 'points': '150'},
    {'name': 'Charlie', 'points': '200'},
    // Add more fake friends as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends Points List'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(friends[index]['name']!),
            subtitle: Text('Points: ${friends[index]['points']}'),
          );
        },
      ),
    );
  }
}

// AnimatedBackground Widget
class AnimatedBackground extends StatefulWidget {
  final List<String> images;
  final Duration switchDuration;

  const AnimatedBackground({
    Key? key,
    required this.images,
    this.switchDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.switchDuration, (Timer t) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Opacity(
        opacity: 0.3, // Adjust this value for desired opacity (0.0 to 1.0)
        child: Image.asset(
          widget.images[_currentIndex],
          key: ValueKey<int>(_currentIndex),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      )
    );
  }
}



// HomeScreen Widget
class HomeScreen extends StatefulWidget {
  final String passedValue; // This should be a string representation of time in hours
  final String stringValue;
  final String timeUnit; 
  

  HomeScreen({Key? key, required this.stringValue, required this.timeUnit, required this.passedValue}) : super(key: key);

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
    _remainingTime = int.tryParse(widget.passedValue) ?? 0; // Assuming passedValue is in seconds
    _startTimer();
  }

  String formatDuration(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    switch (widget.timeUnit) {
      case 'hours':
        return '${hours.toString().padLeft(2, '0')} hours';
      case 'minutes':
        return '${minutes + hours * 60} minutes';
      case 'seconds':
      default:
        return '$totalSeconds seconds';
    }
  }
  void _startTimer() {
    if (_remainingTime > 0 && !_isPaused) {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          timer.cancel();
          _navigateToTimerFinishedScreen();
        }
      });
    }
}

void _navigateToTimerFinishedScreen() {
  if (mounted) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DetailPage()),
  );
  }
}
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      _isPaused = !_isPaused;
    });
    if (_isPaused) {
      _timer?.cancel();
    } else {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    String wagerName = widget.stringValue;
    String moneyPlaced = widget.timeUnit;
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
        actions: [IconButton(onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FakeFriendListPage()),
              );
        }, icon: const Icon(Icons.people_alt_rounded))],
      ),
      body: Stack(
        children: [
          const AnimatedBackground(
            images: [
              'images/1.png',
              'images/2.png',
              'images/3.png',
              'images/4.png',
              'images/5.png',
              'images/6.png',
              'images/7.png',
              'images/8.png',
              'images/9.png',
              'images/10.png',
              // Add more images as needed
            ],
            switchDuration: Duration(milliseconds: 1000),
          ),
          SingleChildScrollView(
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
                    'Time: $time ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 50),
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
        ],
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
