import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Service for providing haptic feedback throughout the app
class HapticService {
  factory HapticService() => _instance;

  HapticService._internal();
  static final HapticService _instance = HapticService._internal();

  /// Light impact haptic feedback
  static Future<void> lightImpact() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Handle the case where haptics aren't available
      debugPrint('Haptic feedback not available: $e');
    }
  }

  /// Medium impact haptic feedback
  static Future<void> mediumImpact() async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }

  /// Heavy impact haptic feedback
  static Future<void> heavyImpact() async {
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }

  /// Selection haptic feedback
  static Future<void> selectionClick() async {
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }

  /// Success haptic feedback
  static Future<void> success() async {
    try {
      await HapticFeedback.mediumImpact();
      await Future.delayed(const Duration(milliseconds: 50));
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }

  /// Error haptic feedback
  static Future<void> error() async {
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 50));
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }
}
