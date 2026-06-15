import 'package:flutter/material.dart';

import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/ai_prediction_service.dart';
import '../services/auth_service.dart';
import '../services/shared_preferences_service.dart';
import '../services/tts_service.dart';
import 'auth/sign_in_view.dart';
import 'shared_widgets/view_constraint.dart';
import 'theme/simple_aac_text.dart';
import 'theme/theme_view.dart';
import 'tts_settings_view.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _sharedPreferenceService = getIt.get<SharedPreferencesService>();
  final _authService = getIt.get<AuthService>();
  final _ttsService = getIt.get<TtsService>();
  final _aiService = getIt.get<AiPredictionService>();
  bool _hasAiKey = false;
  bool _hasGeminiKey = false;

  @override
  void initState() {
    super.initState();
    _refreshKeyStatus();
  }

  Future<void> _refreshKeyStatus() async {
    final hasOpenAi = await _ttsService.hasOpenAiKey();
    final hasGemini = await _aiService.hasGeminiKey();
    if (mounted) {
      setState(() {
        _hasAiKey = hasOpenAi;
        _hasGeminiKey = hasGemini;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _sharedPreferenceService,
      builder: (context, _) {
        final hasRelatedWordsEnabled = _sharedPreferenceService.hasRelatedWordsEnabled;
        final aiPredictionsEnabled = _sharedPreferenceService.aiPredictionsEnabled;
        final highlightWordsEnabled = _sharedPreferenceService.highlightWordsEnabled;
        final isDark = context.isDark;
        final currentThemeName = context.themeViewModel.themeName;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Settings',
              style: SimpleAACText.subtitle2Style.copyWith(
                color: context.themeColors.onPrimaryContainer,
              ),
            ),
          ),
          body: ViewConstraint(
            child: ListView(
            children: [
              _sectionHeader('Account'),
              _buildAccountTile(context),
              const Divider(),
              _sectionHeader('Speech'),
              ListTile(
                title: const Text('Speech settings', style: SimpleAACText.body1Style),
                subtitle: const Text('Voice, speed and pitch', style: SimpleAACText.body2Style),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await Navigator.of(context).pushNamed(TtsSettingsView.routeName);
                  _refreshKeyStatus();
                },
              ),
              SwitchListTile(
                value: _hasAiKey ? false : highlightWordsEnabled,
                onChanged: _hasAiKey
                    ? null
                    : _sharedPreferenceService.setHighlightWordsEnabled,
                title: const Text(
                  'Highlight words while speaking',
                  style: SimpleAACText.body1Style,
                ),
                subtitle: _hasAiKey
                    ? const Text(
                        'Not available with AI voice',
                        style: SimpleAACText.body2Style,
                      )
                    : null,
              ),
              const Divider(),
              _sectionHeader('Predictions'),
              SwitchListTile(
                value: hasRelatedWordsEnabled,
                onChanged: _sharedPreferenceService.setRelatedWordsEnabled,
                title: const Text(
                  'Show related words when selecting a word',
                  style: SimpleAACText.body1Style,
                ),
              ),
              SwitchListTile(
                value: aiPredictionsEnabled,
                onChanged: _sharedPreferenceService.setAiPredictionsEnabled,
                title: const Text(
                  'AI next-word predictions',
                  style: SimpleAACText.body1Style,
                ),
              ),
              if (aiPredictionsEnabled) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'gemini', label: Text('Gemini')),
                      ButtonSegment(value: 'openai', label: Text('OpenAI')),
                    ],
                    selected: {_sharedPreferenceService.aiPredictionProvider},
                    onSelectionChanged: (s) =>
                        _sharedPreferenceService.setAiPredictionProvider(s.first),
                  ),
                ),
                if (_sharedPreferenceService.aiPredictionProvider == 'gemini')
                  ListTile(
                    title: const Text('Gemini API key', style: SimpleAACText.body1Style),
                    subtitle: Text(
                      _hasGeminiKey ? 'Key saved' : 'Not set — tap to add',
                      style: SimpleAACText.body2Style,
                    ),
                    trailing: _hasGeminiKey
                        ? const Icon(Icons.check_circle_outline, color: Colors.green)
                        : const Icon(Icons.chevron_right),
                    onTap: _showGeminiKeyDialog,
                  )
                else
                  ListTile(
                    title: const Text('OpenAI API key', style: SimpleAACText.body1Style),
                    subtitle: Text(
                      _hasAiKey ? 'Key saved (shared with TTS)' : 'Not set — configure in Speech settings',
                      style: SimpleAACText.body2Style,
                    ),
                    trailing: _hasAiKey
                        ? const Icon(Icons.check_circle_outline, color: Colors.green)
                        : const Icon(Icons.chevron_right),
                    onTap: _hasAiKey
                        ? null
                        : () => Navigator.of(context).pushNamed(TtsSettingsView.routeName),
                  ),
              ],
              const Divider(),
              _sectionHeader('Theme'),
              ListTile(
                title: Text(
                  'Current theme: $currentThemeName',
                  style: SimpleAACText.body1Style,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).pushNamed(ThemeView.routeName),
              ),
              SwitchListTile(
                value: isDark,
                onChanged: (_) => context.themeViewModel.setThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                ),
                title: Text(
                  'Current theme mode is ${isDark ? 'Dark' : 'Light'}',
                  style: SimpleAACText.body1Style,
                ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  Future<void> _showGeminiKeyDialog() async {
    if (_hasGeminiKey) {
      final clear = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Gemini API key'),
          content: const Text('Remove the saved Gemini API key?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      if (clear == true) {
        await _aiService.clearGeminiKey();
        _refreshKeyStatus();
      }
      return;
    }

    final controller = TextEditingController();
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Gemini API key'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Paste your API key here',
          ),
          obscureText: true,
          autocorrect: false,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved == true && controller.text.trim().isNotEmpty) {
      await _aiService.setGeminiKey(controller.text.trim());
      _refreshKeyStatus();
    }
    controller.dispose();
  }

  Widget _buildAccountTile(BuildContext context) {
    if (_authService.isSignedInWithGoogle) {
      return ListTile(
        leading: _authService.photoUrl != null
            ? CircleAvatar(backgroundImage: NetworkImage(_authService.photoUrl!))
            : const CircleAvatar(child: Icon(Icons.person)),
        title: Text(
          _authService.displayName ?? 'Signed in',
          style: SimpleAACText.body1Style,
        ),
        subtitle: Text(
          _authService.email ?? '',
          style: SimpleAACText.body2Style,
        ),
        trailing: TextButton(
          onPressed: () async {
            await _authService.signOut();
            if (context.mounted) setState(() {});
          },
          child: const Text('Sign out'),
        ),
      );
    }
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person_outline)),
      title: const Text('Not signed in', style: SimpleAACText.body1Style),
      subtitle: const Text(
        'Sign in to sync across devices',
        style: SimpleAACText.body2Style,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        await Navigator.of(context).pushNamed(SignInView.routeName);
        if (context.mounted) setState(() {});
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: SimpleAACText.body1Style),
    );
  }
}
