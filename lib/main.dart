import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'auth/login_page.dart';
import 'services/auth_service.dart';
import 'profile/profile_page.dart';
import 'home/feed_page.dart';
import 'upload/upload_page.dart';
import 'map/map_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// ===============================
/// ROOT APP
/// ===============================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Infra Social',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: FutureBuilder<bool>(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return snapshot.data! ? const MainNavigation() : const LoginPage();
        },
      ),
    );
  }
}

/// ===============================
/// MAIN NAVIGATION (MEDSOS STYLE)
/// ===============================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    FeedPage(),
    MapPage(),
    UploadPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [Permission.location, Permission.camera, Permission.photos].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Upload',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// ===============================
/// FEED PAGE
/// ===============================
// class FeedPage extends StatelessWidget {
//   const FeedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Smart Infra'), centerTitle: true),
//       body: const Center(
//         child: Text(
//           'Feed Page\n(GET /api/posts)',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

// /// ===============================
// /// MAP PAGE
// /// ===============================
// class MapPage extends StatelessWidget {
//   const MapPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Map'), centerTitle: true),
//       body: const Center(
//         child: Text(
//           'Map Page\n(Google Maps / OSM)',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// /// ===============================
// /// UPLOAD PAGE
// /// ===============================
// class UploadPage extends StatelessWidget {
//   const UploadPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload Laporan'), centerTitle: true),
//       body: const Center(
//         child: Text(
//           'Upload Page\n(Camera + GPS + Geocoding)',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// /// ===============================
// /// PROFILE PAGE
// /// ===============================
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile'), centerTitle: true),
//       body: const Center(
//         child: Text(
//           'Profile Page\n(GET /api/users/{id})',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
