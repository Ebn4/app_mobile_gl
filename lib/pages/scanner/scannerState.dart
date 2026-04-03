import 'package:app_mobile/business/models/citizen/citizen.dart';

enum ScannerStatus { initial, scanning, processing, success, navigating, error }

class ScannerState {
  final ScannerStatus status;
  final String? errorMessage;
  final String? cardNumber;
  final String? nni;
  final Citizen? citizen;

  ScannerState({
    required this.status,
    this.errorMessage,
    this.cardNumber,
    this.nni,
    this.citizen,
  });

  // Constructeurs nommés pour chaque état
  factory ScannerState.initial() {
    return ScannerState(status: ScannerStatus.initial);
  }

  factory ScannerState.scanning() {
    return ScannerState(status: ScannerStatus.scanning);
  }

  factory ScannerState.processing(String cardNumber) {
    return ScannerState(
      status: ScannerStatus.processing,
      cardNumber: cardNumber,
    );
  }

  factory ScannerState.success({
    required String cardNumber,
    required String nni,
    required Citizen citizen,
  }) {
    return ScannerState(
      status: ScannerStatus.success,
      cardNumber: cardNumber,
      nni: nni,
      citizen: citizen,
    );
  }

  factory ScannerState.navigating({
    required String cardNumber,
    required String nni,
    required Citizen citizen,
  }) {
    return ScannerState(
      status: ScannerStatus.navigating,
      cardNumber: cardNumber,
      nni: nni,
      citizen: citizen,
    );
  }

  factory ScannerState.error(String message) {
    return ScannerState(status: ScannerStatus.error, errorMessage: message);
  }

  bool get isScanning => status == ScannerStatus.scanning;
  bool get isProcessing => status == ScannerStatus.processing;
  bool get isSuccess => status == ScannerStatus.success;
  bool get isNavigating => status == ScannerStatus.navigating;
  bool get isError => status == ScannerStatus.error;

  ScannerState copyWith({
    ScannerStatus? status,
    String? errorMessage,
    String? cardNumber,
    String? nni,
    Citizen? citizen,
  }) {
    return ScannerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cardNumber: cardNumber ?? this.cardNumber,
      nni: nni ?? this.nni,
      citizen: citizen ?? this.citizen,
    );
  }
}
