import 'dart:async';
import 'package:app_mobile/utils/navigationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import 'appCtrl.dart';

class IntroPage extends ConsumerStatefulWidget {
  const IntroPage({super.key});

  @override
  ConsumerState<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  var navigation = getIt<NavigationUtils>();
  double _progressValue = 0.0;
  Timer? _progressTimer;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var ctrl = ref.read(appCtrlProvider.notifier);
      ctrl.getUser();
      
      // Démarrer l'animation de progression
      _startProgressAnimation();
    });
  }

  void _startProgressAnimation() {
    const totalDuration = Duration(seconds: 5);
    const updateInterval = Duration(milliseconds: 30);
    final steps = totalDuration.inMilliseconds / updateInterval.inMilliseconds;
    final increment = 1.0 / steps;
    
    _progressTimer = Timer.periodic(updateInterval, (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += increment;
          if (_progressValue >= 1.0) {
            _progressValue = 1.0;
            timer.cancel();
            
            if (!_isNavigating) {
              _isNavigating = true;
              navigation.replace('/app/home');
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: Column(
          children: [
            // Bandeau tricolore amélioré avec dégradé
            Container(
              height: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0066CC), Color(0xFF2E86DE)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFCC00), Color(0xFFFFD700)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFCC0000), Color(0xFFE63946)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // En-tête gouvernemental stylisé
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                    ).createShader(bounds),
                    child: Text(
                      'RÉPUBLIQUE DÉMOCRATIQUE\nDU CONGO',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    width: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFCC00), Color(0xFFFFD700)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'MINISTÈRE DU NUMÉRIQUE',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Zone principale avec design amélioré
            Expanded(
              child: Stack(
                children: [
                  // Cercles décoratifs en arrière-plan
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0066CC).withOpacity(0.03),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFCC00).withOpacity(0.03),
                      ),
                    ),
                  ),

                  // Contenu central avec icône encadrée
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Cadre circulaire avec dégradé pour l'icône
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFF0066CC).withOpacity(0.1),
                                const Color(0xFF0066CC).withOpacity(0.05),
                                Colors.transparent,
                              ],
                              stops: const [0.2, 0.7, 1.0],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                // Cercle principal avec dégradé
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.white, Color(0xFFF0F5FF)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 25,
                                        offset: const Offset(0, 10),
                                        spreadRadius: -5,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF0066CC).withOpacity(0.15),
                                        blurRadius: 20,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 85,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        gradient: const RadialGradient(
                                          colors: [Color(0xFF0066CC), Color(0xFF2E86DE), Color(0xFF4A9EFF)],
                                          stops: [0.3, 0.7, 1.0],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF0066CC).withOpacity(0.4),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.nfc_rounded,
                                        color: Colors.white,
                                        size: 45,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Petit cercle décoratif (haut gauche)
                                Positioned(
                                  top: 15,
                                  left: 25,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCC00).withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                
                                // Petit cercle décoratif (bas droite)
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCC0000).withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Badge check en dessous de l'icône
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00C853),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'VERIFIÉ',
                                style: TextStyle(
                                  color: Color(0xFF00C853),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Titre avec effet de texte
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF1E3C72), Color(0xFF0066CC)],
                          ).createShader(bounds),
                          child: const Text(
                            'Identité Numérique',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Badge NFC stylisé
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0066CC), Color(0xFF2E86DE)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0066CC).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.wifi_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'NFC READY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Empreinte digitale stylisée
                  Positioned(
                    bottom: 60,
                    right: 20,
                    child: Transform.rotate(
                      angle: 0.1,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.05),
                        ),
                        child: Icon(
                          Icons.fingerprint_rounded,
                          color: const Color(0xFF0066CC).withOpacity(0.15),
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section inférieure avec barre de progression moderne
            Column(
              children: [
                // Barre de progression personnalisée
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Barre de fond
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // Barre de progression animée
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 30),
                            height: 8,
                            width: MediaQuery.of(context).size.width * 0.8 * _progressValue,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0066CC), Color(0xFF2E86DE), Color(0xFF4A9EFF)],
                                stops: [0.0, 0.5, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0066CC).withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Texte de chargement
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chargement...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${(_progressValue * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF0066CC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Texte de sécurité avec icône
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security_rounded,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'SÉCURISÉ PAR LE GOUVERNEMENT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Carrés de couleurs améliorés
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColorSquare(0xFF0066CC),
                    const SizedBox(width: 12),
                    _buildColorSquare(0xFFFFCC00),
                    const SizedBox(width: 12),
                    _buildColorSquare(0xFFCC0000),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSquare(int colorCode) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(colorCode),
            Color(colorCode).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Color(colorCode).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}