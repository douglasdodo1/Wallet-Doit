import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:http/http.dart' as http;

class RegisterWidget extends StatefulWidget {
  final void Function(bool) onInputPressed;
  const RegisterWidget({super.key, required this.onInputPressed});

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final Map<String, TextEditingController> _controllers = {
    'CPF': TextEditingController(),
    'Name': TextEditingController(),
    'E-mail': TextEditingController(),
    'Number': TextEditingController(),
    'Password': TextEditingController(),
    'Confirm your password': TextEditingController(),
  };

  final Map<String, FocusNode> _inputs = {
    'CPF': FocusNode(),
    'Name': FocusNode(),
    'E-mail': FocusNode(),
    'Number': FocusNode(),
    'Password': FocusNode(),
    'Confirm your password': FocusNode(),
  };

  bool _isInputFocused = false;

  Future<void> createUser() async {
    final user = {
      'cpf': _controllers['CPF']!.text,
      'name': _controllers['Name']!.text,
      'email': _controllers['E-mail']!.text,
      'phone': _controllers['Number']!.text,
      'password': _controllers['Password']!.text,
      'sale': 0.0,
      'credit': 0.0,
      'creditUsed': 0.0,
    };

    try {
      final response = await http.post(
        Uri.parse('http://${Globals.localhost}:3000/user'),
        headers: {
          'Authorization': 'Bearer ${Globals.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up realizado')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na requisição: $e')),
      );
    }
  }

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
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
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
                        controller: _controllers[entry.key],
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
                  onPressed: createUser,
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
