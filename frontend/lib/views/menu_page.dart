import 'package:flutter/material.dart';
import 'package:frontend/widgets/menuWidgets/login_widget.dart';
import 'package:frontend/widgets/menuWidgets/register_widget.dart';
import '../widgets/menuWidgets/menu_button_login_register.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  bool _stateButton = false;
  bool _isFocused = false;

  void _receiveButtonState(bool buttonIsPressed) {
    setState(() {
      _stateButton = buttonIsPressed;
    });
    _isFocused = false;
    print(_stateButton);
  }

  void _receiveStateInput(bool isFocusedInput) {
    setState(() {
      _isFocused = isFocusedInput;
    });
  }

  void _unfocus() {
    setState(() {
      _isFocused = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
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
            if (_isFocused)
              Container(
                color: Colors.black.withOpacity(0.9),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: !_stateButton
                        ? LoginWidget(
                            onInputPressed: _receiveStateInput,
                          )
                        : RegisterWidget(
                            onInputPressed: _receiveStateInput,
                          ),
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
      ),
    );
  }
}
