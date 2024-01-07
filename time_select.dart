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
  String _selectedUnit = 'hours'; // Default unit is hours
  final List<String> _timeUnits = ['hours', 'minutes', 'seconds'];

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  

  int _convertTimeToSeconds(String time, String unit) {
    int value = int.tryParse(time) ?? 0;
    switch (unit) {
      case 'minutes':
        return value * 60;
      case 'seconds':
        return value;
      default: // hours
        return value * 3600;
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Time Selection'),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "MUST COMPLETE WITHIN 7 DAYS",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          
          const Text(
            "Lying about completion is strictly prohibited!",
            textAlign: TextAlign.center, // This centers the text inside the Text widget
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
         
          const SizedBox(height: 20),
          if (_isVisible)
            TextFormField(
              controller: _textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Timer Value',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _textController.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (_isVisible)
            DropdownButtonFormField<String>(
              value: _selectedUnit,
              decoration: const InputDecoration(
                labelText: 'Select Time Unit',
                border: OutlineInputBorder(),
              ),
              items: _timeUnits.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnit = newValue!;
                });
              },
            ),
          const SizedBox(height: 20),
          if (_isVisible)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userPost = '${_textController.text} $_selectedUnit';
                });
                _toggleVisibility();
                int timeInSeconds = _convertTimeToSeconds(_textController.text, _selectedUnit);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      stringValue: widget.stringValue,
                      timeUnit: widget.intValue,
                      passedValue: timeInSeconds.toString(),
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
           const Padding(
            padding: EdgeInsets.only(),
            child: Opacity(
              opacity: 0.3,
              child: Image(
                image: AssetImage('images/jesus.png'),
             
              ),
              
            ),
          ),
        ],
      ),
    ),
  );
}
}