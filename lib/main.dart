import 'package:app_mobile/business/services/carte/carteNetworkService.dart';
import 'package:app_mobile/business/services/institution/institutionService.dart';
import 'package:app_mobile/business/services/nfc/nfcService.dart';
import 'package:app_mobile/business/services/user/userLocalService.dart';
import 'package:app_mobile/business/services/user/userNetworkService.dart';
import 'package:app_mobile/framework/carte/carteNetworkServiceImpl.dart';
import 'package:app_mobile/framework/nfc/nfcServiceImpl.dart';
import 'package:app_mobile/framework/institution/institutionServiceImpl.dart';
import 'package:app_mobile/framework/user/userLocalServiceImpl.dart';
import 'package:app_mobile/framework/user/userNetworkServiceImpl.dart';
import 'package:app_mobile/framework/utils/http/remoteHttpUtils.dart';
import 'package:app_mobile/framework/utils/localStorage/getStorageImpl.dart';
import 'package:app_mobile/myApplication.dart';
import 'package:app_mobile/utils/navigationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

GetIt getIt = GetIt.instance;

void configureImplementations() {
  var localManager = GetStorageImpl();
  var httpUtils = RemoteHttpUtils();
  var baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  getIt.registerLazySingleton<NavigationUtils>(() => NavigationUtils());
  getIt.registerLazySingleton<UserLocalService>(
    () => UserLocalServiceImpl(box: localManager),
  );
  getIt.registerLazySingleton<UserNetworkService>(
    () => UserNetworkServiceImpl(baseUrl: baseUrl, httpUtils: httpUtils),
  );
  getIt.registerLazySingleton<CarteNetworkService>(
    () => CarteNetworkServiceImpl(baseUrl: baseUrl, httpUtils: httpUtils),
  );
  getIt.registerLazySingleton<InstitutionService>(
    () => InstitutionServiceImpl(baseUrl: baseUrl, httpUtils: httpUtils),
  );
  getIt.registerLazySingleton<NfcService>(() => NfcServiceImpl());
}

void main() async {
  //Initialisation de dotenv pour charger les variables d'environnement
  await dotenv.load(fileName: ".env");

  //initialisation du GetStorage pour stocker les donnees en local
  await GetStorage.init();

  configureImplementations();

  runApp(ProviderScope(child: MyApplication()));
}
