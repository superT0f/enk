import 'package:flutter/material.dart';

import 'message_reader_widget.dart';

void main() {
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
