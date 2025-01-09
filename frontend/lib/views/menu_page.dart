import 'package:flutter/material.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'package:frontend/widgets/register_widget.dart';
import '../widgets/menu_button_login_register.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  bool _stateButton = false;

  void _receiveButtonState(bool buttonIsPressed) {
    setState(() {
      _stateButton = buttonIsPressed;
    });
    debugPrint('Button state: $_stateButton');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Positioned(
            top: 25,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Image.asset(
              'assets/LOGOAPLICATIVO.png',
              width: 200,
              height: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: !_stateButton
                      ? const LoginWidget()
                      : const RegisterWidget(),
                ),
                const SizedBox(height: 20),
                MenuButtonLoginRegister(
                  onButtonStateChanged: _receiveButtonState,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
