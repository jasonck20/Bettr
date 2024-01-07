import 'package:bettr/time_select.dart';
import 'package:flutter/material.dart';


class CreateBet extends StatefulWidget {
  @override
  _CreateBetState createState() => _CreateBetState();
}

class _CreateBetState extends State<CreateBet> {
  bool _isVisible = true;
  bool _isVisible1 = false;
  final _textController = TextEditingController();
  String userPost = '';
  final _textController1 = TextEditingController();
  String userPost1 = '';

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _toggleVisibility1() {
    setState(() {
      _isVisible1 = !_isVisible1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(userPost.isEmpty ? 'Create Bet' : userPost),
        backgroundColor: Colors.white, // Changed for a better look
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_isVisible)
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Goal Name',
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
                  _toggleVisibility1();
                },
                child: const Text('Confirm'),
              ),
            if (_isVisible1)
              Column(
                children: [
                  TextFormField(
                    controller: _textController1,
                    decoration: InputDecoration(
                      labelText: 'Bet Amount',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: _textController1.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        userPost1 = _textController1.text;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeSelect(
                            stringValue: userPost,
                            intValue: userPost1,
                          ),
                        ),
                      );
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Opacity(
                opacity: 0.3,
                child: Image(
                  image: AssetImage('images/multiplefox.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}