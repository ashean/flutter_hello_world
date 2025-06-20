import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // 1. Create the controller to manage the TextField's text.
  final _textController = TextEditingController();

  // 2. It's a best practice to dispose of controllers when the widget is
  //    removed from the screen to free up resources.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitForm(String text) {
    developer.log(
      'Form submitted with text: "$text"',
      name: 'my.app.form',
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('You submitted: $text')));

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Form')),
      // 3. Add the form UI to the body of the Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController, // Link the controller to the field
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter some text',
              ),
              onSubmitted: _submitForm, // Call _submitForm when submitted
            ),
            const SizedBox(height: 16.0), // Just a spacer
            ElevatedButton(
              onPressed: () {
                _submitForm(_textController.text); // Call _submitForm on press
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
