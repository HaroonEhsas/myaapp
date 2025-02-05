import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate user using biometrics
  Future<bool> authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,  // Only biometric authentication (no PIN/pattern)
        ),
      );
      return authenticated;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error: $e"); // Use debugPrint for development
      }
      return false;
    }
  }
}