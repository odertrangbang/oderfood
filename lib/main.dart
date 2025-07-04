import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/role.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/admin/admin_home_screen.dart';
import 'screens/shipper/shipper_home_screen.dart';
import 'screens/customer/customer_home_screen.dart';

void main() {
  runApp(const ShippingApp());
}

class ShippingApp extends StatelessWidget {
  const ShippingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Shipping App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthProvider>().role;

    switch (role) {
      case UserRole.admin:
        return const AdminHomeScreen();
      case UserRole.shipper:
        return const ShipperHomeScreen();
      case UserRole.customer:
        return const CustomerHomeScreen();
      case null:
      default:
        return const LoginScreen();
    }
  }
}