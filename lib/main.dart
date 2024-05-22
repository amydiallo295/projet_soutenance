import 'package:emergency/ui/sreens/home_page/accueil_screen.dart';
import 'package:emergency/ui/sreens/home_page/profil.dart';
import 'package:emergency/utils/app_colors.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergency',
      color: Colors.blue,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [DashboardScreen(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        selectedIconTheme: const IconThemeData(color: Colors.red),
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(bottomNavigationBarProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: primaryColor,
              size: 28,
            ),
            icon: Icon(
              Icons.home,
              // color: Colors.orangeAccent,
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: primaryColor,
              size: 28,
            ),
            icon: Icon(
              Icons.person,
              // color: Colors.orangeAccent,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

final bottomNavigationBarProvider = StateProvider<int>((ref) => 0);
