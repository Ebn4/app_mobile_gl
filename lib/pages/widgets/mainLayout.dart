import 'package:app_mobile/pages/history/historyPage.dart';
import 'package:app_mobile/pages/home/homePage.dart';
import 'package:app_mobile/pages/scanner/scannerPage.dart';
import 'package:app_mobile/pages/settings/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Provider pour gérer l'index de navigation
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    void _onItemTapped(int index) {
      ref.read(bottomNavIndexProvider.notifier).state = index;
    }

    // Liste des pages
    final List<Widget> _pages = [
      HomePage(), 
      ScannerPage(), 
      HistoryPage(), 
      SettingsPage(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  currentIndex: currentIndex,
                  icon: Icons.home,
                  label: 'Accueil',
                  onTap: _onItemTapped,
                ),
                _buildNavItem(
                  index: 1,
                  currentIndex: currentIndex,
                  icon: Icons.qr_code_scanner,
                  label: 'Scanner',
                  onTap: _onItemTapped,
                ),
                _buildNavItem(
                  index: 2,
                  currentIndex: currentIndex,
                  icon: Icons.history,
                  label: 'Historique',
                  onTap: _onItemTapped,
                ),
                _buildNavItem(
                  index: 3,
                  currentIndex: currentIndex,
                  icon: Icons.settings,
                  label: 'Parametres',
                  onTap: _onItemTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
    required Function(int) onTap,
  }) {
    final isSelected = currentIndex == index;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Colors.blue[800]?.withOpacity(0.1) : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.blue[800] : Colors.grey[600],
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.blue[800] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}