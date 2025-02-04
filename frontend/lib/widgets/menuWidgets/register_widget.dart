import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  final void Function(bool) onInputPressed;
  const RegisterWidget({super.key, required this.onInputPressed});

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final Map<String, FocusNode> _inputs = {
    'CPF': FocusNode(),
    'Name': FocusNode(),
    'E-mail': FocusNode(),
    'Number': FocusNode(),
    'Password': FocusNode(),
    'Confirm your password': FocusNode(),
  };

  bool _isInputFocused = false;

  @override
  void initState() {
    super.initState();
    _inputs.forEach((key, node) {
      node.addListener(_updateFocusState);
    });
  }

  void _updateFocusState() {
    setState(() {
      _isInputFocused = _inputs.values.any((node) => node.hasFocus);
      widget.onInputPressed(_isInputFocused);
    });
  }

  @override
  void dispose() {
    _inputs.forEach((key, node) {
      node.removeListener(_updateFocusState);
      node.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isInputFocused)
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._inputs.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        focusNode: entry.value,
                        decoration: InputDecoration(
                          labelText: entry.key,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign up realizado')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 221, 221, 221),
                      width: 2,
                    ),
                  ),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
