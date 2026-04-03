import 'package:app_mobile/main.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mobile/business/services/nfc/nfcService.dart';
import 'package:app_mobile/business/services/carte/carteNetworkService.dart';
import 'package:app_mobile/business/models/citizen/citizen.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'scannerState.dart';

class ScannerCtrl extends StateNotifier<ScannerState> {
  bool _isProcessing = false;
  final Ref ref;
  late final NfcService nfcService;
  late final CarteNetworkService carteNetworkService;

  String? get token => ref.read(appCtrlProvider).user?.token;

  ScannerCtrl({required this.ref}) : super(ScannerState.initial()) {
    // Initialiser les services
    try {
      nfcService = getIt.get<NfcService>();
      carteNetworkService = getIt.get<CarteNetworkService>();
      print('✅ Services NFC initialisés avec succès');
    } catch (e) {
      print('❌ Erreur initialisation services: $e');
    }
    _waitForNfcInitialization();
  }

  Future<void> _waitForNfcInitialization() async {
    print('⏳ Attente initialisation NFC...');
    int attempts = 0;
    while (nfcService != null && !nfcService.isNfcAvailable && attempts < 20) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }
    if (nfcService != null && nfcService.isNfcAvailable) {
      print('✅ NFC initialisé avec succès');
    } else {
      print('⚠️ NFC non disponible après attente');
    }
  }

  Future<void> startNfcScan() async {
    if (_isProcessing) {
      print('⚠️ Un scan est déjà en cours');
      return;
    }

    if (state.isScanning || state.isProcessing) {
      print('⚠️ Scan déjà en cours');
      return;
    }

    _isProcessing = true;
    print('🔍 Démarrage scan NFC');
    state = ScannerState.scanning();

    try {
      await _waitForNfcInitialization();
      await Future.delayed(const Duration(milliseconds: 200));

      if (nfcService == null) {
        throw Exception('Service NFC non initialisé');
      }

      if (!nfcService.isNfcAvailable) {
        throw Exception('NFC non disponible. Vérifiez que le NFC est activé.');
      }

      print('🔑 Vérification permission NFC...');
      final hasPermission = await nfcService.requestNfcPermission();
      if (!hasPermission) {
        throw Exception('NFC désactivé. Veuillez activer le NFC.');
      }

      print('✅ NFC prêt, attente carte...');
      print('💡 Approchez la carte NFC du dos du téléphone');

      final cardNumber = await nfcService.scanNfcCard();

      print('📱 Résultat scan brut: "$cardNumber"');

      if (cardNumber != null && cardNumber.isNotEmpty) {
        print('🎯 Carte détectée: $cardNumber');

        if (!cardNumber.startsWith('CD-')) {
          print('⚠️ Format invalide: $cardNumber');
          state = ScannerState.error(
            'Format de carte invalide: $cardNumber\nFormat attendu: CD-XXXXXXXXXX-XXXXXXXXXX',
          );
          return;
        }

        if (token == null) {
          throw Exception('Token non disponible. Veuillez vous reconnecter.');
        }

        print('✅ Token disponible, longueur: ${token!.length}');
        print('🚀 Appel de processCardNumber...');
        print('🔍 _isProcessing avant appel: $_isProcessing');

        // Réinitialiser _isProcessing pour permettre le traitement
        _isProcessing = false;

        try {
          await processCardNumber(cardNumber, token!);
          print('✅ processCardNumber terminé avec succès');
        } catch (processError) {
          print('❌ Erreur dans processCardNumber: $processError');
          print('❌ Stack trace processCardNumber: ${StackTrace.current}');
          rethrow;
        }
      } else {
        throw Exception('Aucun numéro de carte détecté.');
      }
    } catch (e) {
      print('❌ Erreur scan: $e');
      print('❌ Stack trace: ${StackTrace.current}');
      state = ScannerState.error(e.toString());
    } finally {
      _isProcessing = false;
    }
  }

  Future<String?> _scanWithFallback() async {
    try {
      print('🔄 Appel nfcService.scanNfcCard()...');
      final result = await nfcService.scanNfcCard();
      print('📱 Résultat: $result');
      return result;
    } catch (e) {
      print('❌ Erreur scan: $e');
      return null;
    }
  }

  Future<void> processCardNumber(String cardNumber, String token) async {
    print('🔍 processCardNumber appelé avec: $cardNumber');
    print('🔍 _isProcessing au début de processCardNumber: $_isProcessing');

    if (_isProcessing) {
      print('⚠️ processCardNumber: déjà en cours, retour');
      return;
    }
    _isProcessing = true;

    try {
      print('🚀 TRAITEMENT CARTE: $cardNumber');
      state = ScannerState.processing(cardNumber);

      if (carteNetworkService == null) {
        throw Exception('Service CarteNetworkService non initialisé');
      }

      // 1. Récupérer info carte
      print('📡 [1/2] Appel API getCarteInfo pour: $cardNumber');
      final carteResponse = await carteNetworkService.getCarteInfo(
        cardNumber,
        token,
      );
      print('✅ [1/2] Carte info reçue - NNI: ${carteResponse.nni}');

      // 2. Récupérer info citoyen
      print('📡 [2/2] Appel API getCitizenByNni pour: ${carteResponse.nni}');
      final citizen = await carteNetworkService.getCitizenByNni(
        carteResponse.nni,
        token,
      );
      print('✅ [2/2] Citoyen trouvé - Nom: ${citizen.prenom} ${citizen.nom}');

      // 3. Succès
      state = ScannerState.success(
        cardNumber: cardNumber,
        nni: carteResponse.nni,
        citizen: citizen,
      );

      print('🎉 SCAN ET TRAITEMENT RÉUSSIS !');
    } catch (e) {
      print('❌ ERREUR TRAITEMENT: $e');
      print('❌ Type erreur: ${e.runtimeType}');
      state = ScannerState.error('Erreur lors du traitement: ${e.toString()}');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> processManualCardNumber(String cardNumber) async {
    if (cardNumber.isEmpty) {
      state = ScannerState.error('Veuillez entrer un numéro de carte valide');
      return;
    }

    if (token == null) {
      state = ScannerState.error(
        'Token non disponible. Veuillez vous reconnecter.',
      );
      return;
    }

    print('📝 Saisie manuelle: $cardNumber');
    await processCardNumber(cardNumber, token!);
  }

  void reset() {
    print('🔄 Reset scanner');
    _isProcessing = false;
    state = ScannerState.initial();
  }

  void retry() {
    print('🔄 Retry scan');
    reset();
    Future.delayed(const Duration(milliseconds: 500), () {
      startNfcScan();
    });
  }

  void cancelScan() {
    if (state.isScanning) {
      print('❌ Annulation du scan');
      _isProcessing = false;
      state = ScannerState.initial();
    }
  }

  @override
  void dispose() {
    _isProcessing = false;
    super.dispose();
  }
}

final scannerCtrlProvider = StateNotifierProvider<ScannerCtrl, ScannerState>((
  ref,
) {
  return ScannerCtrl(ref: ref);
});
