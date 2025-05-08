import 'package:fleetwise_app/models/user_model.dart';

class AuthService {
  // Mock service for now
  Future<User> getUserInfo(String token) async {
    // In a real app, this would call the API
    await Future.delayed(const Duration(seconds: 1));
    
    // Return mock user
    return User(
      id: '1',
      name: 'Test User',
      phoneNumber: '+919876543210',
      documents: {
        'panCard': 'path/to/pancard',
        'aadharFront': 'path/to/aadhar_front',
        'aadharBack': 'path/to/aadhar_back',
      },
    );
  }
}