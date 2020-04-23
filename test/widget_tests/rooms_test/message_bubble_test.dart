import 'package:cineandgo/components/rooms/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Message bubble',
    () {
      testWidgets(
        '- sent by me',
        (WidgetTester tester) async {
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: MessageBubble(
                isMe: true,
                sender: 'Me',
                text: 'Heyy, it\'s mee!',
              ))));

          final textFinder = find.text('Heyy, it\'s mee!');
          final senderFinder = find.text('Me');

          expect(textFinder, findsOneWidget);
          expect(senderFinder, findsOneWidget);
        },
      );

      testWidgets(
        '- sent by (not) me',
        (WidgetTester tester) async {
          await tester.pumpWidget(MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home: MessageBubble(
                isMe: false,
                sender: 'Not me',
                text: 'Heyy, it\'s not mee!',
              ))));

          final textFinder = find.text('Heyy, it\'s not mee!');
          final senderFinder = find.text('Not me');

          expect(textFinder, findsOneWidget);
          expect(senderFinder, findsOneWidget);
        },
      );
    },
  );
}
