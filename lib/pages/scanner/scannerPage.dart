// lib/pages/scanner/scannerPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'scannerCtrl.dart';
import 'scannerState.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({super.key});

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage> {
  @override
  void initState() {
    super.initState();
    // Ne plus démarrer le scan automatiquement
    // L'utilisateur devra cliquer sur le bouton "Scanner la carte"
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerCtrlProvider);
    final controller = ref.read(scannerCtrlProvider.notifier);

    // Écouter les changements d'état pour la navigation fluide
    if (state.isNavigating && state.citizen != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.navigateToCitizenInfo(context);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Scanner NFC',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: null,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimation(state),
                  const SizedBox(height: 40),
                  _buildStatusMessage(state),
                  const SizedBox(height: 40),
                  _buildInstructions(),
                  if (state.isError) ...[
                    const SizedBox(height: 20),
                    _buildErrorWidget(state.errorMessage!, controller),
                  ],
                  const SizedBox(height: 30),
                  _buildActionButtons(state, controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation(ScannerState state) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: state.isScanning || state.isNavigating
            ? const Color(0xFF2563EB).withOpacity(0.1)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: state.isScanning || state.isNavigating
                ? const Color(0xFF2563EB).withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (state.isScanning || state.isNavigating)
            const CircularProgressIndicator(
              color: Color(0xFF2563EB),
              strokeWidth: 3,
            ),
          Icon(
            state.isNavigating
                ? Icons.check_circle_rounded
                : (state.isScanning ? Icons.nfc_rounded : Icons.nfc),
            size: 80,
            color: state.isScanning || state.isNavigating
                ? const Color(0xFF2563EB)
                : Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMessage(ScannerState state) {
    String title;
    String subtitle;
    Color color;

    switch (state.status) {
      case ScannerStatus.scanning:
        final controller = ref.read(scannerCtrlProvider.notifier);
        if (controller.isNfcInitialized) {
          title = 'Scan en cours...';
          subtitle = 'Approchez votre carte NFC du téléphone';
          color = const Color(0xFF2563EB);
        } else {
          title = 'Initialisation NFC...';
          subtitle = 'Veuillez patienter, préparation du scan';
          color = const Color(0xFF2563EB);
        }
        break;
      case ScannerStatus.processing:
        title = 'Carte détectée !';
        subtitle = 'Traitement des informations...';
        color = const Color(
          0xFF10B981,
        ); // Vert pour montrer que la carte est détectée
        break;
      case ScannerStatus.navigating:
        title = 'Succès !';
        subtitle = 'Navigation en cours...';
        color = const Color(0xFF10B981);
        break;
      case ScannerStatus.success:
        title = 'Carte détectée !';
        subtitle = 'Redirection en cours...';
        color = const Color(0xFF10B981);
        break;
      case ScannerStatus.error:
        title = 'Erreur';
        subtitle = state.errorMessage ?? 'Une erreur est survenue';
        color = const Color(0xFFEF4444);
        break;
      default:
        title = 'Prêt';
        subtitle = 'Appuyez sur "Scanner" pour commencer';
        color = const Color(0xFF64748B);
    }

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
          textAlign: TextAlign.center,
        ),
        if (state.cardNumber != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Carte: ${state.cardNumber}',
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF2563EB), size: 18),
              SizedBox(width: 8),
              Text(
                'Instructions',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            Icons.nfc,
            'Activez le NFC dans les paramètres',
          ),
          const SizedBox(height: 8),
          _buildInstructionItem(
            Icons.phone_android,
            'Positionnez la carte au dos du téléphone',
          ),
          const SizedBox(height: 8),
          _buildInstructionItem(
            Icons.handshake,
            'Maintenez jusqu\'à détection',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2563EB), size: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String message, ScannerCtrl controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ScannerState state, ScannerCtrl controller) {
    if (state.isError) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retour'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => controller.retry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Réessayer'),
            ),
          ),
        ],
      );
    }

    if (!state.isScanning && !state.isProcessing) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () => controller.startNfcScan(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.nfc, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Text(
                  'Scanner la carte',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Appuyez sur le bouton pour commencer le scan NFC',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFF59E0B).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFFF59E0B), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'L\'initialisation NFC peut prendre quelques secondes',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF92400E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
