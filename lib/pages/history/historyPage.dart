import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Couleurs principales
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color scanBlue = Color(0xFF2563EB);
  static const Color infractionOrange = Color(0xFFF59E0B);
  static const Color successGreen = Color(0xFF10B981);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              'Historique',
              style: TextStyle(
                color: primaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '6 enregistrements',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: primaryDark, size: 20),
              onPressed: () {
                // Ouvrir le filtre
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.download, color: primaryDark, size: 20),
              onPressed: () {
                // Exporter l'historique
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche améliorée
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Rechercher par nom ou numéro...',
                  hintStyle: TextStyle(color: secondaryText.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: secondaryText, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: secondaryText, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Liste d'historique
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildHistoryItem(
                  icon: Icons.qr_code_scanner,
                  iconColor: scanBlue,
                  title: 'Scan carte NFC',
                  name: 'MUKENDI Jean-Pierre',
                  id: 'CD-KIN-1990-123456',
                  info: 'Consultation permis de conduire',
                  date: '14/03/2026',
                  time: '14:30',
                  type: 'scan',
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  icon: Icons.description,
                  iconColor: infractionOrange,
                  title: 'Infraction ajoutée',
                  name: 'KABONGO Marie',
                  id: 'CD-KIN-1985-789012',
                  info: 'Excès de vitesse - 50 000 FC',
                  date: '14/03/2026',
                  time: '13:45',
                  type: 'infraction',
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  icon: Icons.qr_code_scanner,
                  iconColor: scanBlue,
                  title: 'Consultation casier',
                  name: 'TSHIMANGA Paul',
                  id: 'CD-KIN-1992-345678',
                  info: 'Vérification casier judiciaire',
                  date: '14/03/2026',
                  time: '12:20',
                  type: 'scan',
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  icon: Icons.description,
                  iconColor: infractionOrange,
                  title: 'Mise à jour permis',
                  name: 'NGOY Joseph',
                  id: 'CD-KIN-1988-901234',
                  info: 'Renouvellement catégorie B',
                  date: '13/03/2026',
                  time: '16:15',
                  type: 'update',
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  icon: Icons.qr_code_scanner,
                  iconColor: scanBlue,
                  title: 'Scan carte NFC',
                  name: 'MBUYI Sarah',
                  id: 'CD-KIN-1995-567890',
                  info: '',
                  date: '13/03/2026',
                  time: '15:30',
                  type: 'scan',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= ITEM D'HISTORIQUE AMÉLIORÉ =================
  Widget _buildHistoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String name,
    required String id,
    required String info,
    required String date,
    required String time,
    required String type,
  }) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            // Voir les détails
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icône
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                    
                    const SizedBox(width: 14),
                    
                    // Informations principales
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: primaryDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 13,
                              color: secondaryText,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            id,
                            style: TextStyle(
                              fontSize: 11,
                              color: secondaryText.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Date et heure
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            date,
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 11,
                            color: secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                // Informations supplémentaires
                if (info.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: iconColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 14,
                          color: iconColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            info,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryDark,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}