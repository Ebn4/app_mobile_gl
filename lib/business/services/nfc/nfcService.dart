import 'package:app_mobile/business/models/nfc/nfcCard.dart';

abstract class NfcService {
  Future<String?> scanNfcCard();
  Stream<NfcCard> get nfcStream;
  bool get isNfcAvailable;
  Future<bool> requestNfcPermission();
}
