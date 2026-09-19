import 'package:flutter_katana_looper/core/platform/native_bridge.dart';
import 'package:flutter_katana_looper/features/midi/data/katana_channel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final midiViewModelProvider = NotifierProvider<MidiViewModel, MidiState>(
  MidiViewModel.new,
);

class MidiState {
  const MidiState({this.selectedChannel, this.isSwitching = false});

  final KatanaChannel? selectedChannel;
  final bool isSwitching;
}

class MidiViewModel extends Notifier<MidiState> {
  @override
  MidiState build() => const MidiState();

  Future<void> selectChannel(KatanaChannel channel) async {
    state = MidiState(selectedChannel: state.selectedChannel, isSwitching: true);
    await ref.read(nativeBridgeProvider).switchChannel(channel.programChangeValue);
    state = MidiState(selectedChannel: channel, isSwitching: false);
  }
}
