import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final void Function(bool) onInputPressed;

  const LoginWidget({super.key, required this.onInputPressed});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(_updateFocusState);
    _passwordFocusNode.addListener(_updateFocusState);
  }

  void _updateFocusState() {
    final hasFocus = _usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    widget.onInputPressed(hasFocus);
  }

  @override
  void dispose() {
    _usernameFocusNode.removeListener(_updateFocusState);
    _passwordFocusNode.removeListener(_updateFocusState);
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
                    focusNode: _usernameFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Cor da borda
                          width: 4, // Largura da borda
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Cor da borda quando em foco
                          width: 5, // Largura da borda em foco
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Cor da borda
                          width: 5, // Largura da borda
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Cor da borda quando em foco
                          width: 6, // Largura da borda em foco
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Esqueceu a senha?',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Container(
                        width: 150,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Ação ao clicar no botão Login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login realizado')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Define bordas quadradas
                        ),
                        side: const BorderSide(
                          color: Color.fromARGB(
                              255, 221, 221, 221), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                      child: const Text(
                          'Log in'), // Corrigido o posicionamento de `child`
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
