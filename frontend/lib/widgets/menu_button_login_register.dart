import 'package:flutter/material.dart';

class MenuButtonLoginRegister extends StatefulWidget {
  final Function(bool) onButtonStateChanged;
  // ignore: prefer_const_constructors_in_immutables
  MenuButtonLoginRegister(
      {super.key,
      required this.onButtonStateChanged}); // Uso do super parameter

  @override
  MenuButtonLoginRegisterState createState() => MenuButtonLoginRegisterState();
}

class MenuButtonLoginRegisterState extends State<MenuButtonLoginRegister> {
  bool _isButton1Pressed = true;
  bool _isButton2Pressed = false;

  @override
  void initState() {
    super.initState();
  }

  void _onButton1Pressed() {
    setState(() {
      if (!_isButton1Pressed) {
        _isButton1Pressed = !_isButton1Pressed;
        _isButton2Pressed = !_isButton2Pressed;

        widget.onButtonStateChanged(false);
      }
    });
  }

  void _onButton2Pressed() {
    setState(() {
      if (!_isButton2Pressed) {
        _isButton1Pressed = !_isButton1Pressed;
        _isButton2Pressed = !_isButton2Pressed;
        widget.onButtonStateChanged(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 14;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: circleSize,
            height: circleSize,
            child: ElevatedButton(
              onPressed: () {
                _onButton1Pressed();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_isButton1Pressed
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0))),
              child: SizedBox(),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            width: circleSize,
            height: circleSize,
            child: ElevatedButton(
              onPressed: () {
                _onButton2Pressed();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_isButton2Pressed
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0))),
              child: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
