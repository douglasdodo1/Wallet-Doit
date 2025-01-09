import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
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
      _isInputFocused =
          _usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus;
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
          Container(
            color: Colors.black.withOpacity(0.5), // Camada escura
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    focusNode: _inputs['CPF'],
                    decoration: const InputDecoration(
                      labelText: 'CPF',
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
                    focusNode: _inputs['Username'],
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
                    focusNode: _inputs['E-mail'],
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
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
                    focusNode: _inputs['Number'],
                    decoration: const InputDecoration(
                      labelText: 'Number',
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
                    focusNode: _inputs['Password'],
                    decoration: const InputDecoration(
                      labelText: 'Password',
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
