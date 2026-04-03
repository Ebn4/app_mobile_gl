// lib/framework/nfc/nfcServiceImpl.dart
import 'dart:async';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:app_mobile/business/services/nfc/nfcService.dart';
import 'package:app_mobile/business/models/nfc/nfcCard.dart';

class NfcServiceImpl implements NfcService {
  bool _isNfcAvailable = false;
  bool _isInitialized = false;
  bool _isScanning = false;
  final StreamController<NfcCard> _nfcStreamController =
      StreamController<NfcCard>.broadcast();

  @override
  Stream<NfcCard> get nfcStream => _nfcStreamController.stream;

  @override
  bool get isNfcAvailable => _isNfcAvailable;

  NfcServiceImpl() {
    _initializeNfc();
  }

  Future<void> _initializeNfc() async {
    try {
      print('🔵 Initialisation NFC...');

      // Pause pour laisser le temps au système NFC de s'initialiser
      await Future.delayed(const Duration(milliseconds: 500));

      final availability = await FlutterNfcKit.nfcAvailability;
      print('📱 NFC Availability: $availability');

      if (availability.toString() == 'NFCAvailability.available') {
        print('✅ NFC est disponible');
        _isNfcAvailable = true;
      } else {
        print('⚠️ NFC non disponible: $availability');
        _isNfcAvailable = false;
      }

      _isInitialized = true;
      print('✅ Initialisation NFC terminée');
    } catch (e) {
      print('❌ Erreur initialisation NFC: $e');
      _isNfcAvailable = false;
      _isInitialized = true;
    }
  }

  Future<void> _waitForInitialization() async {
    while (!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  Future<bool> requestNfcPermission() async {
    await _waitForInitialization();

    try {
      print('🔵 Vérification permission NFC...');

      final availability = await FlutterNfcKit.nfcAvailability;
      print('📱 État NFC (request): $availability');

      if (availability.toString() == 'NFCAvailability.available') {
        print('✅ NFC disponible et prêt');
        return true;
      } else {
        print('❌ NFC non disponible: $availability');
        return false;
      }
    } catch (e) {
      print('❌ Erreur permission NFC: $e');
      return false;
    }
  }

  @override
  Future<String?> scanNfcCard() async {
    await _waitForInitialization();

    if (_isScanning) {
      print('⚠️ Scan déjà en cours');
      return null;
    }

    _isScanning = true;

    try {
      print('🔵 Début scan NFC...');
      print('📱 Timestamp: ${DateTime.now().millisecondsSinceEpoch}');

      // Vérification avant scan
      final availability = await FlutterNfcKit.nfcAvailability;
      print('📱 État NFC (scan): $availability');
      if (availability.toString() != 'NFCAvailability.available') {
        print('❌ NFC non disponible au moment du scan');
        throw Exception('NFC non disponible ou désactivé');
      }

      print('⏳ En attente de carte NFC...');
      print('💡 Approchez la carte NFC du dos du téléphone');
      print('💡 Maintenez la carte immobile');
      print('🔥 DÉBUT DU POLLING - ${DateTime.now()}');

      // Approche optimisée: polling très court avec plusieurs tentatives
      for (int attempt = 1; attempt <= 5; attempt++) {
        print('🔄 Tentative $attempt/5...');

        // Vérifier si l'activité est toujours attachée
        try {
          final availability = await FlutterNfcKit.nfcAvailability;
          if (availability.toString() != 'NFCAvailability.available') {
            print('⚠️ NFC plus disponible à la tentative $attempt');
            break;
          }
        } catch (e) {
          print('⚠️ Erreur vérification disponibilité tentative $attempt: $e');
          if (e.toString().contains('not attached to activity')) {
            print('❌ Activité détachée, arrêt du scan');
            break;
          }
          continue;
        }

        try {
          // Polling ultra-court (5 secondes seulement)
          final tag = await FlutterNfcKit.poll(
            timeout: const Duration(seconds: 5),
            iosAlertMessage: attempt == 1 ? "Approchez votre carte NFC" : "",
          );

          if (tag != null) {
            print('✅ Tag détecté à la tentative $attempt!');
            return _processTag(tag);
          } else {
            print('⚠️ Aucun tag détecté à la tentative $attempt');
          }
        } catch (e) {
          print('⚠️ Erreur tentative $attempt: $e');

          // Si l'activité est détachée, arrêter le scan
          if (e.toString().contains('not attached to activity')) {
            print('❌ Activité détachée, arrêt du scan');
            break;
          }
        }

        // Pause entre les tentatives pour laisser Android respirer
        if (attempt < 5) {
          print('⏸️ Pause de 1 seconde avant la tentative suivante...');
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      print('❌ Aucun tag NFC détecté après 5 tentatives');
      await FlutterNfcKit.finish(iosAlertMessage: "Aucune carte détectée");
      return null;
    } catch (e) {
      print('❌ Erreur scan NFC: $e');
      print('📱 Timestamp erreur: ${DateTime.now().millisecondsSinceEpoch}');
      try {
        await FlutterNfcKit.finish(iosAlertMessage: "Erreur de scan");
      } catch (_) {}
      rethrow;
    } finally {
      _isScanning = false;
    }
  }

  Future<String?> _processTag(dynamic tag) async {
    print('✅ Tag NFC détecté!');
    print('📝 Tag ID: ${tag.id}');
    print('📝 Tag type: ${tag.type}');
    print('📝 Tag standard: ${tag.standard}');

    // Debug complet du tag pour voir toutes les propriétés
    print('🔍 Tag complet: ${tag.toString()}');
    print('🔍 Propriétés disponibles:');

    // Afficher les propriétés du tag sans utiliser toMap()
    try {
      print('  📦 id: ${tag.id}');
      print('  📦 type: ${tag.type}');
      print('  📦 standard: ${tag.standard}');
    } catch (e) {
      print('  ⚠️ Erreur accès propriétés: $e');
    }

    final cardNumber = await _extractCardNumber(tag);

    if (cardNumber != null && cardNumber.isNotEmpty) {
      print('🔢 Numéro extrait: $cardNumber');

      // Vérifier si le format est valide (CD-XXXXXXXXXX-XXXXXXXXXX)
      if (!cardNumber.startsWith('CD-')) {
        print(
          '⚠️ Numéro non valide: $cardNumber (attend format CD-XXXXXXXXXX-XXXXXXXXXX)',
        );
        print('📦 Utilisation du numéro de série: $cardNumber');
        // Retourner quand même pour debug mais ne pas faire d'appels API
        final nfcCard = NfcCard(
          cardNumber: cardNumber,
          scanTime: DateTime.now(),
        );
        _nfcStreamController.add(nfcCard);
        await FlutterNfcKit.finish(iosAlertMessage: "Scan terminé (debug)");
        return cardNumber;
      }

      final nfcCard = NfcCard(cardNumber: cardNumber, scanTime: DateTime.now());

      _nfcStreamController.add(nfcCard);
      print('✅ Carte NFC lue avec succès: $cardNumber');

      await FlutterNfcKit.finish(iosAlertMessage: "Scan terminé");
      return cardNumber;
    } else {
      print('⚠️ Aucun numéro de carte trouvé dans le tag');
      await FlutterNfcKit.finish(iosAlertMessage: "Aucune donnée valide");
      return null;
    }
  }

  Future<String?> _extractCardNumber(dynamic tag) async {
    try {
      print('🔍 Extraction du numéro de carte...');

      // Debug complet du tag
      print('🔍 Tag complet: ${tag.toString()}');
      print('🔍 Type du tag: ${tag.runtimeType}');

      // Afficher les propriétés du tag sans conversion Map
      print('🔍 Propriétés du tag:');
      try {
        print('  📦 id: ${tag.id} (${tag.id?.runtimeType})');
        // Ne pas essayer d'accéder à ndef directement car ça cause une erreur
        print('  📦 type: ${tag.type} (${tag.type?.runtimeType})');
        print('  📦 standard: ${tag.standard} (${tag.standard?.runtimeType})');
      } catch (e) {
        print('  ⚠️ Erreur accès propriétés: $e');
      }

      String? cardNumber;

      // Méthode 1: Utiliser l'identifiant du tag (id)
      if (tag.id != null) {
        var id = tag.id;
        print('🔑 ID trouvé: $id (type: ${id.runtimeType})');

        if (id is List<int> && id.isNotEmpty) {
          cardNumber = id
              .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
              .join('');
          print('🔑 ID hex: $cardNumber');
        } else if (id is String && id.isNotEmpty) {
          cardNumber = id.replaceAll(RegExp(r'[:\s]'), '');
          print('🔑 ID string: $cardNumber');
        }
      }

      // Méthode 2: Chercher dans les données NDEF (plus important pour les cartes avec données)
      print('🔍 Recherche NDEF...');

      // Essayer différentes façons d'accéder aux NDEF
      dynamic ndefData;

      // Utiliser reflection pour accéder aux propriétés dynamiquement
      try {
        // Essayer d'accéder à la propriété 'ndef' via reflection
        final ndefGetter = tag.runtimeType.toString().contains('ndef')
            ? null
            : null;

        // Essayer différentes approches pour les données NDEF
        if (tag.toString().contains('ndef') ||
            tag.toString().contains('NDEF')) {
          print('📦 Le tag semble contenir des données NDEF (dans la string)');

          // Utiliser la méthode standard pour lire les données NDEF
          try {
            final ndefRecords = await FlutterNfcKit.readNDEFRecords();
            if (ndefRecords != null && ndefRecords.isNotEmpty) {
              ndefData = ndefRecords;
              print(
                '📦 Données NDEF trouvées via readNDEFRecords: ${ndefRecords.length} records',
              );
            }
          } catch (e) {
            print('⚠️ Erreur readNDEFRecords: $e');
          }
        }
      } catch (e) {
        print('⚠️ Erreur recherche NDEF: $e');
      }

      if (ndefData != null) {
        print('📦 NDEF Data: $ndefData (type: ${ndefData.runtimeType})');

        // Si c'est une liste de records
        if (ndefData is List && ndefData.isNotEmpty) {
          print('📦 NDEF Records: ${ndefData.length}');

          for (int i = 0; i < ndefData.length; i++) {
            final record = ndefData[i];
            print('📝 Record $i: ${record.toString()} (${record.runtimeType})');

            // Vérifier le payload avec plusieurs approches
            try {
              dynamic payload;

              // Approche 1: record.payload
              if (record.payload != null) {
                payload = record.payload;
                print('  📦 Payload trouvé via record.payload');
              }
              // Approche 2: record['payload']
              else if (record is Map && record['payload'] != null) {
                payload = record['payload'];
                print('  📦 Payload trouvé via record[\'payload\']');
              }
              // Approche 3: chercher dans toutes les propriétés
              else if (record is Map) {
                record.forEach((key, value) {
                  if (key.toString().toLowerCase().contains('payload') ||
                      key.toString().toLowerCase().contains('data')) {
                    payload = value;
                    print('  📦 Payload trouvé via clé $key');
                  }
                });
              }

              if (payload != null) {
                print('  📦 Payload brut: $payload (${payload.runtimeType})');

                String payloadString;

                // Conversion du payload en string avec différentes méthodes
                if (payload is List<int>) {
                  // Essayer UTF-8 d'abord
                  try {
                    payloadString = String.fromCharCodes(payload);
                    print('  📝 Payload UTF-8: $payloadString');
                  } catch (e) {
                    // Si UTF-8 échoue, essayer Latin-1
                    try {
                      payloadString = String.fromCharCodes(
                        payload.map((b) => b & 0xFF).toList(),
                      );
                      print('  📝 Payload Latin-1: $payloadString');
                    } catch (e2) {
                      payloadString = payload
                          .map((b) => b.toRadixString(16).padLeft(2, '0'))
                          .join('');
                      print('  📝 Payload hex: $payloadString');
                    }
                  }
                } else if (payload is String) {
                  payloadString = payload;
                  print('  📝 Payload string: $payloadString');
                } else {
                  payloadString = payload.toString();
                  print('  📝 Payload toString: $payloadString');
                }

                // Vérifier si le payload contient le format CD-
                if (payloadString.contains('CD-')) {
                  print('🎯 Format CD trouvé dans payload $i!');
                  print('📝 Payload complet: "$payloadString"');

                  final extracted = _extractNumberFromString(payloadString);
                  if (extracted != null) {
                    print('🔑 Numéro extrait du payload: $extracted');
                    return extracted;
                  }
                }
              }
            } catch (e) {
              print('⚠️ Erreur lecture payload record $i: $e');
            }

            // Vérifier si le record lui-même contient CD-
            final recordString = record.toString();
            if (recordString.contains('CD-')) {
              print('🎯 Format CD trouvé dans record $i!');
              print('📝 Record complet: "$recordString"');

              final extracted = _extractNumberFromString(recordString);
              if (extracted != null) {
                print('🔑 Numéro extrait du record: $extracted');
                return extracted;
              }
            }
          }
        } else {
          print('📦 NDEF n\'est pas une liste ou est vide');
        }
      } else {
        print('⚠️ Aucune donnée NDEF trouvée');
      }

      // Méthode 3: Essayer de lire les données NDEF directement avec FlutterNfcKit
      try {
        print('� Tentative lecture NDEF directe...');
        final ndefRecords = await FlutterNfcKit.readNDEFRecords();
        if (ndefRecords != null && ndefRecords.isNotEmpty) {
          print('📦 NDEF Records trouvés: ${ndefRecords.length}');

          for (int i = 0; i < ndefRecords.length; i++) {
            final record = ndefRecords[i];
            print('📝 Record $i: $record');

            // Vérifier si le record lui-même contient CD-
            if (record.toString().contains('CD-')) {
              print('🎯 Format CD trouvé dans le record $i!');
              final extracted = _extractNumberFromString(record.toString());
              if (extracted != null) {
                print('🔑 Numéro extrait du record: $extracted');
                return extracted;
              }
            }

            // Essayer d'extraire le texte du payload pour les TextRecord
            try {
              if (record.toString().contains('TextRecord')) {
                // Accéder au texte du TextRecord
                final recordString = record.toString();
                print('📝 Record string: $recordString');

                // Extraire le texte entre "text=" et ")"
                final textMatch = RegExp(
                  r'text=([^)]+)',
                ).firstMatch(recordString);
                if (textMatch != null) {
                  final extracted = _extractNumberFromString(
                    textMatch.group(1)!,
                  );
                  if (extracted != null) {
                    print('🔑 Numéro extrait du TextRecord: $extracted');
                    return extracted;
                  }
                }
              }
            } catch (e) {
              print('⚠️ Erreur extraction TextRecord: $e');
            }
          }
        }
      } catch (e) {
        print('⚠️ Erreur lecture NDEF directe: $e');
      }

      // Si aucun numéro CD- trouvé, utiliser l'ID comme fallback
      if (cardNumber != null && cardNumber.isNotEmpty) {
        print('🔑 Utilisation de l\'ID comme numéro: $cardNumber');
        return cardNumber;
      }

      print('⚠️ Aucun numéro trouvé dans le tag NFC');
      return null;
    } catch (e) {
      print('❌ Erreur extraction: $e');
      return null;
    }
  }

  String? _extractNumberFromString(String text) {
    print('🔍 Extraction du numéro depuis: "$text"');

    // Nettoyer le texte (enlever les espaces, tabulations, newlines)
    final cleanText = text.replaceAll(RegExp(r'\s+'), '').trim();
    print('🔍 Texte nettoyé: "$cleanText"');

    // Chercher spécifiquement le format CD-XXXXXXXXXX-XXXXXXXXXX
    final cdPattern = RegExp(r'CD-(\d{10})-(\d{10})');
    final cdMatch = cdPattern.firstMatch(cleanText);
    if (cdMatch != null) {
      final fullNumber = 'CD-${cdMatch.group(1)}-${cdMatch.group(2)}';
      print('🎯 Numéro CD extrait: $fullNumber');
      return fullNumber;
    }

    // Chercher aussi les variantes possibles du format CD-
    final cdPattern2 = RegExp(r'CD-(\d+)-(\d+)');
    final cdMatch2 = cdPattern2.firstMatch(cleanText);
    if (cdMatch2 != null) {
      final fullNumber = 'CD-${cdMatch2.group(1)}-${cdMatch2.group(2)}';
      print('🎯 Numéro CD variante extraite: $fullNumber');
      return fullNumber;
    }

    // Rechercher différents formats de numéros
    final patterns = [
      RegExp(r'\d{16}'), // 16 chiffres
      RegExp(r'\d{14}'), // 14 chiffres
      RegExp(r'\d{12}'), // 12 chiffres
      RegExp(r'\d{10}'), // 10 chiffres
      RegExp(r'\d{8,}'), // 8+ chiffres
      RegExp(r'[A-Z0-9]{10,}'), // Alphanumérique 10+
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(cleanText);
      if (match != null) {
        final number = match.group(0);
        print('🎯 Numéro format standard extrait: $number');
        return number;
      }
    }

    print('⚠️ Aucun numéro trouvé dans le texte');
    return null;
  }

  @override
  Future<void> dispose() async {
    _isScanning = false;
    await _nfcStreamController.close();
  }
}
