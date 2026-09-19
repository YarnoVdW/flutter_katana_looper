import 'package:flutter/material.dart';
import 'package:flutter_katana_looper/features/midi/data/katana_channel.dart';

class ChannelButton extends StatelessWidget {
  const ChannelButton({
    super.key,
    required this.channel,
    required this.isSelected,
    required this.onPressed,
  });

  final KatanaChannel channel;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: isSelected
          ? null
          : FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
      onPressed: onPressed,
      child: Text(channel.label),
    );
  }
}
