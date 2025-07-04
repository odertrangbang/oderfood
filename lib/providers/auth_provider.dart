import 'package:flutter/material.dart';

import '../models/role.dart';

/// A lightweight authentication provider that stores the current [UserRole].
/// In a real application, this would integrate with Firebase Auth or another backend.
class AuthProvider extends ChangeNotifier {
  UserRole? _role;

  UserRole? get role => _role;

  void login(UserRole role) {
    _role = role;
    notifyListeners();
  }

  void logout() {
    _role = null;
    notifyListeners();
  }
}