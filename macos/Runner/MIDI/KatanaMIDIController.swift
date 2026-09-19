//
//  KatanaMIDIController.swift
//  Runner
//
//  Created by Yarno Van de Weyer on 19/09/2026.
//

import CoreMIDI

final class KatanaMIDIController {
  static let shared = KatanaMIDIController()

  private var client = MIDIClientRef()
  private var outputPort = MIDIPortRef()

  enum MIDIControllerError: Error {
    case katanaNotFound
    case sendFailed(OSStatus)
  }

  private init() {
    MIDIClientCreateWithBlock("SwitchbladeMIDIClient" as CFString, &client) { _ in }
    MIDIOutputPortCreate(client, "SwitchbladeMIDIOutput" as CFString, &outputPort)
  }

  func sendProgramChange(program: UInt8, channel: UInt8 = 1) throws {
    guard let destination = findKatanaDestination() else {
      throw MIDIControllerError.katanaNotFound
    }

    let status: UInt8 = 0xC0 | ((channel - 1) & 0x0F)
    var bytes: [UInt8] = [status, program]

    let packetListPointer = UnsafeMutablePointer<MIDIPacketList>.allocate(capacity: 1)
    defer { packetListPointer.deallocate() }

    let firstPacket = MIDIPacketListInit(packetListPointer)
    _ = MIDIPacketListAdd(packetListPointer, 1024, firstPacket, 0, bytes.count, &bytes)

    let result = MIDISend(outputPort, destination, packetListPointer)
    guard result == noErr else {
      throw MIDIControllerError.sendFailed(result)
    }
  }

  private func findKatanaDestination() -> MIDIEndpointRef? {
    let count = MIDIGetNumberOfDestinations()
    for i in 0..<count {
      let destination = MIDIGetDestination(i)
      if destinationName(destination).lowercased().contains("katana") {
        return destination
      }
    }
    return nil
  }

  private func destinationName(_ destination: MIDIEndpointRef) -> String {
    var name: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(destination, kMIDIPropertyDisplayName, &name)
    return (name?.takeRetainedValue() as String?) ?? ""
  }
}
