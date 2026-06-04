import 'package:flutter/material.dart';

import '../dependency_injection_container.dart';
import '../services/shared_preferences_service.dart';
import '../services/tts_service.dart';
import 'shared_widgets/app_bar.dart';
import 'theme/simple_aac_text.dart';

const _openAiVoices = [
  (name: 'alloy', description: 'Balanced, versatile'),
  (name: 'echo', description: 'Warm, rich'),
  (name: 'fable', description: 'Expressive, British'),
  (name: 'onyx', description: 'Deep, authoritative'),
  (name: 'nova', description: 'Friendly, upbeat'),
  (name: 'shimmer', description: 'Clear, bright'),
];

class TtsSettingsView extends StatefulWidget {
  static const String routeName = '/tts-settings';

  const TtsSettingsView({super.key});

  @override
  State<TtsSettingsView> createState() => _TtsSettingsViewState();
}

class _TtsSettingsViewState extends State<TtsSettingsView> {
  final _prefs = getIt.get<SharedPreferencesService>();
  final _tts = getIt.get<TtsService>();

  late double _pitch;
  late double _rate;
  late Future<List<TtsVoice>> _voicesFuture;
  String? _selectedVoiceName;
  late String _openAiVoice;
  late bool _useAiVoice;

  bool _hasKey = false;
  bool _keyLoading = true;
  final _keyController = TextEditingController();
  bool _keyObscured = true;

  @override
  void initState() {
    super.initState();
    _pitch = _prefs.ttsPitch;
    _rate = _prefs.ttsSpeechRate;
    _selectedVoiceName = _prefs.ttsVoiceName;
    _openAiVoice = _prefs.ttsOpenAiVoice;
    _useAiVoice = _prefs.useAiVoice;
    _voicesFuture = _tts.getVoices();
    _loadKeyStatus();
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _loadKeyStatus() async {
    final key = await _tts.getOpenAiKey();
    if (!mounted) return;
    setState(() {
      _hasKey = key?.isNotEmpty == true;
      if (_hasKey) _keyController.text = key!;
      _keyLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(label: 'Speech Settings'),
      body: _keyLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _sectionHeader('Device Voice'),
                _buildDeviceVoiceSelector(),
                const Divider(),
                _sectionHeader('AI Voice'),
                _buildAiVoiceSection(),
                const Divider(),
                _sectionHeader('Speed'),
                _buildSliderTile(
                  value: _rate,
                  min: 0.1,
                  max: 1.0,
                  divisions: 18,
                  label: _rateLabel(_rate),
                  onChanged: (v) {
                    setState(() => _rate = v);
                    _prefs.setTtsSpeechRate(v);
                    _tts.updateSpeechRate(v);
                  },
                ),
                if (!_useAiVoice) ...[
                  const Divider(),
                  _sectionHeader('Pitch'),
                  _buildSliderTile(
                    value: _pitch,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    label: _pitchLabel(_pitch),
                    onChanged: (v) {
                      setState(() => _pitch = v);
                      _prefs.setTtsPitch(v);
                      _tts.updatePitch(v);
                    },
                  ),
                ],
                const Divider(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton.icon(
                    onPressed: () => _tts.speakWord(
                        'Hello, this is a test of the speech settings.'),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Test voice'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: _resetDefaults,
                    child: const Text('Reset to defaults'),
                  ),
                ),
              ],
            ),
    );
  }

  // ── Device Voice ───────────────────────────────────────────────────────────

  Widget _buildDeviceVoiceSelector() {
    final active = !_useAiVoice;
    return FutureBuilder<List<TtsVoice>>(
      future: _voicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const ListTile(
            title: Text('Loading voices…', style: SimpleAACText.body1Style),
            trailing: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final voices = (snapshot.data ?? [])
            .where((v) => v.locale.toLowerCase().startsWith('en'))
            .toList();
        final selected =
            voices.where((v) => v.name == _selectedVoiceName).firstOrNull;

        return ListTile(
          enabled: active,
          title: Text(
            selected?.displayName ?? 'Default',
            style: SimpleAACText.body1Style,
          ),
          subtitle: active
              ? null
              : const Text(
                  'Inactive while AI voice is on',
                  style: SimpleAACText.body2Style,
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected != null && selected.quality != TtsVoiceQuality.standard)
                _qualityChip(selected.quality),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: active && voices.isNotEmpty
              ? () => _showVoicePicker(voices, selected)
              : null,
        );
      },
    );
  }

  void _showVoicePicker(List<TtsVoice> voices, TtsVoice? current) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Choose a voice', style: SimpleAACText.subtitle2Style),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: voices.length,
                itemBuilder: (context, i) {
                  final voice = voices[i];
                  final isSelected = voice.name == _selectedVoiceName;
                  return ListTile(
                    title: Text(voice.displayName,
                        style: SimpleAACText.body1Style),
                    subtitle: Text(voice.locale,
                        style: SimpleAACText.body2Style),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (voice.quality != TtsVoiceQuality.standard)
                          _qualityChip(voice.quality),
                        const SizedBox(width: 8),
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() => _selectedVoiceName = voice.name);
                      _tts.setVoice(voice);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── AI Voice ───────────────────────────────────────────────────────────────

  Widget _buildAiVoiceSection() {
    if (!_hasKey) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Enter an OpenAI API key to use high-quality AI voices.',
              style: SimpleAACText.body2Style,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _keyController,
                    obscureText: _keyObscured,
                    decoration: InputDecoration(
                      hintText: 'sk-...',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_keyObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => _keyObscured = !_keyObscured),
                      ),
                    ),
                    style: SimpleAACText.body1Style,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _saveKey,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SwitchListTile(
          value: _useAiVoice,
          onChanged: (v) {
            setState(() => _useAiVoice = v);
            _prefs.setUseAiVoice(v);
          },
          title: const Text('Use AI voice', style: SimpleAACText.body1Style),
          subtitle: const Text('OpenAI key active', style: SimpleAACText.body2Style),
        ),
        if (_useAiVoice) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          ),
          ..._openAiVoices.map(_buildOpenAiVoiceTile),
        ],
        ListTile(
          dense: true,
          title: const Text('Remove AI key', style: SimpleAACText.body2Style),
          textColor: Theme.of(context).colorScheme.error,
          onTap: _removeKey,
        ),
      ],
    );
  }

  Widget _buildOpenAiVoiceTile(({String name, String description}) voice) {
    final isSelected = _openAiVoice == voice.name;
    return ListTile(
      title: Text(
        voice.name[0].toUpperCase() + voice.name.substring(1),
        style: SimpleAACText.body1Style,
      ),
      subtitle: Text(voice.description, style: SimpleAACText.body2Style),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outlineVariant,
      ),
      onTap: () {
        setState(() => _openAiVoice = voice.name);
        _prefs.setTtsOpenAiVoice(voice.name);
      },
    );
  }

  Future<void> _saveKey() async {
    final key = _keyController.text.trim();
    if (key.isEmpty) return;
    await _tts.setOpenAiKey(key);
    setState(() {
      _hasKey = true;
      _useAiVoice = true;
    });
  }

  Future<void> _removeKey() async {
    await _tts.clearOpenAiKey();
    _keyController.clear();
    setState(() {
      _hasKey = false;
      _useAiVoice = false;
    });
  }

  // ── Shared ─────────────────────────────────────────────────────────────────

  Widget _qualityChip(TtsVoiceQuality quality) {
    final (label, color) = switch (quality) {
      TtsVoiceQuality.premium => ('Premium', Colors.purple),
      TtsVoiceQuality.enhanced => ('Enhanced', Colors.blue),
      TtsVoiceQuality.standard => ('Standard', Colors.grey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        border: Border.all(color: color.withAlpha(100)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: SimpleAACText.body2Style.copyWith(color: color, fontSize: 11),
      ),
    );
  }

  Widget _buildSliderTile({
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String label,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(label, style: SimpleAACText.body2Style),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  String _rateLabel(double v) {
    if (v < 0.3) return 'Slow';
    if (v < 0.55) return 'Normal';
    if (v < 0.75) return 'Fast';
    return 'Very fast';
  }

  String _pitchLabel(double v) {
    if (v < 0.8) return 'Low';
    if (v < 1.2) return 'Normal';
    if (v < 1.6) return 'High';
    return 'Very high';
  }

  Future<void> _resetDefaults() async {
    const defaultRate = 0.44;
    const defaultPitch = 1.05;
    _prefs.setTtsSpeechRate(defaultRate);
    _prefs.setTtsPitch(defaultPitch);
    _tts.updateSpeechRate(defaultRate);
    _tts.updatePitch(defaultPitch);
    final autoVoice = await _tts.resetVoice();
    setState(() {
      _rate = defaultRate;
      _pitch = defaultPitch;
      _selectedVoiceName = autoVoice?.name;
    });
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(title, style: SimpleAACText.body1Style),
    );
  }
}
