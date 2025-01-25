import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'message_reader_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MessageReader());
}

class MessageReader extends StatelessWidget {
  const MessageReader({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MessageReader assistant',
      home: MessageReaderWidget(),
    );
  }
}