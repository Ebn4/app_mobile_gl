import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({super.key});

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage> with SingleTickerProviderStateMixin {
  final TextEditingController _manualScanController = TextEditingController();
  bool _isScanning = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  // Couleurs principales
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);

  @override
  void initState() {
    super.initState();
    
    // Animation de pulsation pour le scan
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _manualScanController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startScan() {
    setState(() => _isScanning = true);
    
    // Simulation de scan (à remplacer par votre logique NFC)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isScanning = false);
        _showScanResult();
      }
    });
  }

  void _showScanResult() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('Scan réussi ! Carte détectée')),
          ],
        ),
        backgroundColor: successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scanner NFC',
              style: TextStyle(
                color: primaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Approchez la carte du lecteur',
              style: TextStyle(
                color: secondaryText,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.history, color: primaryBlue, size: 20),
            ),
            onPressed: () {
              // Naviguer vers l'historique
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main scanner card avec animation
            _buildScannerCard(),
            
            const SizedBox(height: 20),

            // Instructions card améliorée
            _buildInstructionsCard(),
            
            const SizedBox(height: 20),

            // Manual scan card améliorée
            _buildManualScanCard(),
            
            const SizedBox(height: 24),

            // Section des derniers scans
            _buildRecentScansSection(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ================= SCANNER CARD AVEC ANIMATION =================
  Widget _buildScannerCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isScanning 
              ? [primaryBlue, const Color(0xFF3B82F6)]
              : [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (_isScanning ? primaryBlue : Colors.black).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Scanner icon avec animation
          Stack(
            alignment: Alignment.center,
            children: [
              // Cercle de fond
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _isScanning 
                      ? Colors.white.withOpacity(0.2)
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
              ),
              
              // Animation de pulsation pendant le scan
              if (_isScanning)
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              
              // Cercles concentriques
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      primaryBlue.withOpacity(_isScanning ? 0.2 : 0.1),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              
              // Icône NFC principale
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isScanning
                        ? const Icon(
                            Icons.radar,
                            color: primaryBlue,
                            size: 60,
                            key: Key('scanning'),
                          )
                        : const Icon(
                            Icons.nfc_rounded,
                            color: primaryBlue,
                            size: 60,
                            key: Key('idle'),
                          ),
                  ),
                ),
              ),
              
              // Badge de statut
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _isScanning ? warningOrange : primaryBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    _isScanning ? Icons.radar : Icons.nfc,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Texte de statut
          Text(
            _isScanning ? 'Scan en cours...' : 'Prêt à scanner',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _isScanning ? Colors.white : primaryDark,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            _isScanning 
                ? 'Maintenez la carte immobile'
                : 'Appuyez sur le bouton pour démarrer',
            style: TextStyle(
              fontSize: 14,
              color: _isScanning 
                  ? Colors.white.withOpacity(0.9)
                  : secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Bouton de scan
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isScanning ? null : _startScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isScanning ? Colors.white : primaryBlue,
                foregroundColor: _isScanning ? primaryBlue : Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                disabledForegroundColor: Colors.grey.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: _isScanning ? 0 : 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isScanning ? Icons.stop_circle : Icons.play_arrow,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isScanning ? 'Arrêter le scan' : 'Démarrer le scan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INSTRUCTIONS CARD AMÉLIORÉE =================
  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.info_outline, color: primaryBlue, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInstructionItem(
            icon: Icons.nfc,
            title: 'Activez le NFC',
            subtitle: 'Vérifiez que le NFC est activé dans vos paramètres',
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            icon: Icons.phone_android,
            title: 'Positionnez la carte',
            subtitle: 'À moins de 4 cm du téléphone, zone NFC au dos',
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            icon: Icons.handshake,
            title: 'Maintenez immobile',
            subtitle: 'Ne bougez pas la carte pendant la lecture',
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            icon: Icons.check_circle,
            title: 'Attendez la confirmation',
            subtitle: 'Un signal sonore confirmera la détection',
          ),
        ],
      ),
    );
  }

  /// ================= ITEM D'INSTRUCTION AMÉLIORÉ =================
  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primaryBlue, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ================= MANUAL SCAN CARD AMÉLIORÉE =================
  Widget _buildManualScanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.keyboard, color: primaryDark, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Scan manuel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _manualScanController,
                  decoration: InputDecoration(
                    hintText: 'Entrez le numéro unique',
                    hintStyle: TextStyle(color: secondaryText.withOpacity(0.5)),
                    filled: true,
                    fillColor: backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: primaryBlue, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryDark, Color(0xFF334155)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryDark.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Valider le scan manuel
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Valider',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: secondaryText),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Utilisez cette option si le NFC ne fonctionne pas',
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= SECTION DERNIERS SCANS =================
  Widget _buildRecentScansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.history, color: primaryBlue, size: 16),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Derniers scans',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryDark,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: primaryBlue,
              ),
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildRecentScanItem(
                name: 'MUKENDI Jean',
                id: 'ID: 123456',
                time: 'il y a 5 min',
                status: 'Succès',
              ),
              const Divider(height: 1, indent: 70),
              _buildRecentScanItem(
                name: 'KABILA Joseph',
                id: 'ID: 789012',
                time: 'il y a 15 min',
                status: 'Succès',
              ),
              const Divider(height: 1, indent: 70),
              _buildRecentScanItem(
                name: 'TSHISEKEDI Félix',
                id: 'ID: 345678',
                time: 'il y a 32 min',
                status: 'En attente',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ================= ITEM DE SCAN RÉCENT =================
  Widget _buildRecentScanItem({
    required String name,
    required String id,
    required String time,
    required String status,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryBlue.withOpacity(0.2),
                    primaryBlue.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  name.split(' ').map((e) => e[0]).take(2).join(),
                  style: TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        id,
                        style: TextStyle(
                          color: secondaryText,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: status == 'Succès' 
                              ? successGreen.withOpacity(0.1)
                              : warningOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 9,
                            color: status == 'Succès' ? successGreen : warningOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}