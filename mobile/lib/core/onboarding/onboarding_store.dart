import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingStoreProvider = Provider<OnboardingStore>((ref) => OnboardingStore());

class OnboardingStore {
  static const _key = 'fixit.onboarding_complete';

  Future<bool> isComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> markComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
