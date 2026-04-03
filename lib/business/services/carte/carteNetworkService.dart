import 'package:app_mobile/business/models/nfc/carteResponse.dart';
import 'package:app_mobile/business/models/citizen/citizen.dart';

abstract class CarteNetworkService {
  Future<CarteResponse> getCarteInfo(String cardNumber, String token);
  Future<Citizen> getCitizenByNni(String nni, String token);
}
