//
//  NativeBridgePlugin.swift
//  Runner
//
//  Created by Yarno Van de Weyer on 19/09/2026.
//

import FlutterMacOS

final class NativeBridgePlugin: NSObject {
  static let channelName = "switchblade/native"

  static func register(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    let instance = NativeBridgePlugin()
    channel.setMethodCallHandler(instance.handle)
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "switchChannel":
      handleSwitchChannel(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func handleSwitchChannel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard
      let args = call.arguments as? [String: Any],
      let program = args["program"] as? Int
    else {
      result(FlutterError(code: "bad_args", message: "Expected {program: Int}", details: nil))
      return
    }

    do {
      try KatanaMIDIController.shared.sendProgramChange(program: UInt8(program))
      result(nil)
    } catch {
      result(FlutterError(code: "midi_send_failed", message: "\(error)", details: nil))
    }
  }
}
