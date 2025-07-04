import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ShipperHomeScreen extends StatelessWidget {
  const ShipperHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipper Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: auth.logout,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Hi Shipper! Ready to deliver?',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}