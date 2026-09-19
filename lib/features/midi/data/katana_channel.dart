class KatanaChannel {
  const KatanaChannel({required this.label, required this.programChangeValue});

  final String label;
  final int programChangeValue;

  static const values = [
    KatanaChannel(label: 'CH1', programChangeValue: 0),
    KatanaChannel(label: 'CH2', programChangeValue: 1),
    KatanaChannel(label: 'CH3', programChangeValue: 5),
    KatanaChannel(label: 'CH4', programChangeValue: 6),
  ];
}
