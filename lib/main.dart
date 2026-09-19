import 'package:flutter/material.dart';
import 'package:flutter_katana_looper/features/midi/view/channel_selector_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: SwitchbladeApp()));
}

class SwitchbladeApp extends StatelessWidget {
  const SwitchbladeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'switchblade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ChannelSelectorScreen(),
    );
  }
}
