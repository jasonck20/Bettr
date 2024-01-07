import 'package:bettr/home_screen.dart';
import 'package:flutter/material.dart';

class TimeSelect extends StatefulWidget {
  final String stringValue;
  final String intValue;

  TimeSelect({Key? key, required this.stringValue, required this.intValue}) : super(key: key);

  @override
  TimeSelectState createState() => TimeSelectState();
}

class TimeSelectState extends State<TimeSelect> {
  bool _isVisible = true;
  final _textController = TextEditingController();
  String userPost = '';

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Selection'),
        backgroundColor: Colors.blueGrey, // Changed for a better look
        elevation: 4,
      ),
      body: SingleChildScrollView( // Makes the body scrollable
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Time to accomplish goal: "),
                Text(userPost, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "MUST COMPLETE WITHIN 7 DAYS",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (_isVisible)
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Timer Value in hours',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _textController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (_isVisible)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    userPost = _textController.text;
                  });
                  _toggleVisibility();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        stringValue: widget.stringValue,
                        intValue: widget.intValue,
                        passedValue: userPost,
                      ),
                    ),
                  );
                },
                child: const Text('Confirm'),
              ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Opacity(
                opacity: 0.3,
                child: Image(
                  image: AssetImage('images/Orangefox.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}