import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'services/firebase_service.dart';
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseService.initializeFirebase();
  
  runApp(const ShipprFoodDeliveryApp());
}

class ShipprFoodDeliveryApp extends StatelessWidget {
  const ShipprFoodDeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<CartService>(
          create: (_) => CartService(),
        ),
      ],
      child: GetMaterialApp(
        title: 'ShippFR - Food Delivery',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        getPages: [
          GetPage(
            name: '/splash',
            page: () => const SplashScreen(),
          ),
          GetPage(
            name: '/login',
            page: () => const LoginScreen(),
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
          ),
        ],
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}