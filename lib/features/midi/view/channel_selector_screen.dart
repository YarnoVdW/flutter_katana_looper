import 'package:flutter/material.dart';
import 'package:flutter_katana_looper/features/midi/data/katana_channel.dart';
import 'package:flutter_katana_looper/features/midi/view_model/midi_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'channel_button.dart';

class ChannelSelectorScreen extends ConsumerWidget {
  const ChannelSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final midiState = ref.watch(midiViewModelProvider);
    final viewModel = ref.read(midiViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('switchblade')),
      body: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final channel in KatanaChannel.values)
              ChannelButton(
                channel: channel,
                isSelected: midiState.selectedChannel == channel,
                onPressed: midiState.isSwitching
                    ? null
                    : () => viewModel.selectChannel(channel),
              ),
          ],
        ),
      ),
    );
  }
}
