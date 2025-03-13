import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/views/home_page_view.dart';
import 'package:http/http.dart' as http;

class LoginWidget extends StatefulWidget {
  final void Function(bool) onInputPressed;

  const LoginWidget({super.key, required this.onInputPressed});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _cpfFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cpfFocusNode.addListener(_updateFocusState);
    _passwordFocusNode.addListener(_updateFocusState);
  }

  void _updateFocusState() {
    final hasFocus = _cpfFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    widget.onInputPressed(hasFocus);
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    _cpfFocusNode.removeListener(_updateFocusState);
    _passwordFocusNode.removeListener(_updateFocusState);
    _cpfFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() => _isLoading = true);

    final user = {
      'cpf': _cpfController.text.trim(),
      'password': _passwordController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse('http://${Globals.localhost}:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePageView()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na requisição: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _cpfController,
                    focusNode: _cpfFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: login,
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
                        child: const Text('Log in'),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
