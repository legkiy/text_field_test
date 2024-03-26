import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  String _text = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _clearTextField() {
    setState(() {
      _text = '';
      _textController.clear();
    });
  }

  void onSuccess() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _text = _textController.text;
      });
      _showText(context);
    }
  }

  Future<void> _showText(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Вы ввели следующий текст:',
          style: TextStyle(fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Simple text field test'),
        elevation: 10,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _textController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: onSuccess,
                    decoration: InputDecoration(
                      label: const Text('Поле ввода'),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      suffixIcon: IconButton(
                        onPressed: _clearTextField,
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите текст';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: onSuccess,
                    child: const Text('Показать текст'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
