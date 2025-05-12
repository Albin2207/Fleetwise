import 'package:fleetwise_app/models/user_model.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/dashboardscreen.dart';
import 'package:fleetwise_app/services/auth_service.dart';
import 'package:fleetwise_app/services/storage_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  String? _token;
  User? _user;
  String? _phoneNumber;
  String? _errorMessage;
  bool _isInitialized = false;
  // Mock auth service for now

  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  AuthStatus get status => _status;
  String? get token => _token;
  User? get user => _user;
  String? get phoneNumber => _phoneNumber;
  String? get errorMessage => _errorMessage;
  bool get isInitialized => _isInitialized; // Getter for initialized state

  AuthProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final token = await _storageService.getToken();
      if (token != null) {
        _token = token;
        _user = await _authService.getUserInfo(token);
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    _isInitialized = true; // Mark as initialized
    notifyListeners();
  }

  Future<bool> sendOtp(String phoneNumber) async {
    _status = AuthStatus.loading;
    _phoneNumber = phoneNumber;
    notifyListeners();

    try {
      // Mocking the OTP send since API doesn't work
      await Future.delayed(const Duration(seconds: 1));
      _status =
          AuthStatus
              .unauthenticated; // Keep as unauthenticated until verification
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Mock verification response
      await Future.delayed(const Duration(seconds: 1));
      // In a real app, we would set the token here after API returns it
      // _token = response.token;
      // await _storageService.saveToken(_token!);

      // For now, just changing the status but not setting as authenticated yet
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> setUserName(String name) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Create or update user object with the name
      if (_user == null) {
        _user = User(
          id: '', // Will be set when user is fully registered
          name: name,
          phoneNumber: _phoneNumber ?? '',
          documents: {},
        );
      } else {
        // Update existing user object
        _user = User(
          id: _user!.id,
          name: name,
          phoneNumber: _user!.phoneNumber,
          documents: _user!.documents,
        );
      }

      // Here we would also update the user information on the server

      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> uploadDocuments({
    required String panCard,
    required String aadharFront,
    required String aadharBack,
    required BuildContext context, // Add this parameter
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _token = 'mock_jwt_token';
      await _storageService.saveToken(_token!);
      _user = User(
        id: '1',
        name: 'Test User',
        phoneNumber: _phoneNumber ?? '',
        documents: {
          'panCard': panCard,
          'aadharFront': aadharFront,
          'aadharBack': aadharBack,
        },
      );
      _status = AuthStatus.authenticated;
      notifyListeners();

      // Now you can safely access context to navigate
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
