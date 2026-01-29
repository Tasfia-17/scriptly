import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool _loaded = false;
  bool _onboardingDone = false;
  bool _guideEnabled = true;

  String? _openAIApiKeyOverride;
  String? _geminiApiKey;
  String? _elevenLabsApiKey;

  bool get isLoaded => _loaded;
  bool get onboardingDone => _onboardingDone;
  bool get guideEnabled => _guideEnabled;

  String? get openAIApiKeyOverride => _openAIApiKeyOverride;
  String? get geminiApiKey => _geminiApiKey;
  String? get elevenLabsApiKey => _elevenLabsApiKey;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _onboardingDone = prefs.getBool('onboarding_done') ?? false;
      _guideEnabled = prefs.getBool('guide_enabled') ?? true;
      _openAIApiKeyOverride = prefs.getString('openai_key');
      _geminiApiKey = prefs.getString('gemini_key');
      _elevenLabsApiKey = prefs.getString('elevenlabs_key');
    } catch (e) {
      debugPrint('AppState init failed: $e');
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);
    } catch (e) {
      debugPrint('Failed to persist onboarding: $e');
    }
  }

  Future<void> resetOnboarding() async {
    _onboardingDone = false;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', false);
    } catch (e) {
      debugPrint('Failed to reset onboarding: $e');
    }
  }

  Future<void> setGuideEnabled(bool enabled) async {
    _guideEnabled = enabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('guide_enabled', enabled);
    } catch (e) {
      debugPrint('Failed to persist guide setting: $e');
    }
  }

  Future<void> setApiKeys({String? openai, String? gemini, String? eleven}) async {
    if (openai != null) _openAIApiKeyOverride = openai.trim();
    if (gemini != null) _geminiApiKey = gemini.trim();
    if (eleven != null) _elevenLabsApiKey = eleven.trim();
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      if (openai != null) await prefs.setString('openai_key', _openAIApiKeyOverride ?? '');
      if (gemini != null) await prefs.setString('gemini_key', _geminiApiKey ?? '');
      if (eleven != null) await prefs.setString('elevenlabs_key', _elevenLabsApiKey ?? '');
    } catch (e) {
      debugPrint('Failed to persist API keys: $e');
    }
  }
}
