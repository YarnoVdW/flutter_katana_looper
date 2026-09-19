import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nativeBridgeProvider = Provider<NativeBridge>((ref) => NativeBridge());

class NativeBridge {
  static const _channel = MethodChannel('switchblade/native');

  Future<void> switchChannel(int programChangeValue) {
    return _channel.invokeMethod('switchChannel', {
      'program': programChangeValue,
    });
  }
}
