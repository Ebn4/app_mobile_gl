class NfcCard {
  final String cardNumber;
  final DateTime scanTime;
  final String cardType;

  NfcCard({
    required this.cardNumber, 
    required this.scanTime, 
    this.cardType = 'ONIP'
  });

  factory NfcCard.fromJson(Map<String, dynamic> json) {
    return NfcCard(
      cardNumber: json['cardNumber'],
      scanTime: DateTime.parse(json['scanTime']),
      cardType: json['cardType'] ?? 'ONIP',
    );
  }

  Map<String, dynamic> toJson() => {
    'cardNumber': cardNumber,
    'scanTime': scanTime.toIso8601String(),
    'cardType': cardType,
  };

  @override
  String toString() => 'NfcCard(cardNumber: $cardNumber, cardType: $cardType)';
}
