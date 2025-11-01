import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/isar_provider.dart';
import '../data/models/settings.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _weekStartDay = 'monday'; // Default: Monday
  String _language = 'en'; // Default: English

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final isar = await ref.read(isarProvider.future);

    // Load all settings by getting each by ID
    final allSettings = <Settings>[];
    final count = await isar.settings.count();
    for (var i = 1; i <= count + 100; i++) {
      final setting = await isar.settings.get(i);
      if (setting != null) {
        allSettings.add(setting);
      }
    }

    final weekStartSetting = allSettings.cast<Settings?>().firstWhere(
      (s) => s?.settingKey == SettingKeys.weekStartDay,
      orElse: () => null,
    );

    final languageSetting = allSettings.cast<Settings?>().firstWhere(
      (s) => s?.settingKey == SettingKeys.language,
      orElse: () => null,
    );

    if (mounted) {
      setState(() {
        _weekStartDay = weekStartSetting?.settingValue ?? 'monday';
        _language = languageSetting?.settingValue ?? 'en';
      });
    }
  }

  Future<void> _saveWeekStartDay(String value) async {
    final isar = await ref.read(isarProvider.future);

    // Load existing settings before transaction
    final allSettings = <Settings>[];
    final count = await isar.settings.count();
    for (var i = 1; i <= count + 100; i++) {
      final setting = await isar.settings.get(i);
      if (setting != null) {
        allSettings.add(setting);
      }
    }

    final existing = allSettings.cast<Settings?>().firstWhere(
      (s) => s?.settingKey == SettingKeys.weekStartDay,
      orElse: () => null,
    );

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.settingValue = value;
        existing.modifiedAt = DateTime.now();
        await isar.settings.put(existing);
      } else {
        final setting = Settings()
          ..settingKey = SettingKeys.weekStartDay
          ..settingValue = value
          ..modifiedAt = DateTime.now();
        await isar.settings.put(setting);
      }
    });

    setState(() {
      _weekStartDay = value;
    });
  }

  Future<void> _saveLanguage(String value) async {
    final isar = await ref.read(isarProvider.future);

    // Load existing settings before transaction
    final allSettings = <Settings>[];
    final count = await isar.settings.count();
    for (var i = 1; i <= count + 100; i++) {
      final setting = await isar.settings.get(i);
      if (setting != null) {
        allSettings.add(setting);
      }
    }

    final existing = allSettings.cast<Settings?>().firstWhere(
      (s) => s?.settingKey == SettingKeys.language,
      orElse: () => null,
    );

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.settingValue = value;
        existing.modifiedAt = DateTime.now();
        await isar.settings.put(existing);
      } else {
        final setting = Settings()
          ..settingKey = SettingKeys.language
          ..settingValue = value
          ..modifiedAt = DateTime.now();
        await isar.settings.put(setting);
      }
    });

    setState(() {
      _language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7), // iOS grouped background
      body: CustomScrollView(
        slivers: [
          // iOS-style navigation bar
          const CupertinoSliverNavigationBar(
            backgroundColor: Color(0xFFF2F2F7),
            largeTitle: Text('Settings'),
            border: null,
          ),
          // Settings list
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // General section
                _buildSettingsSection(
                  children: [
                    _buildWeekStartRow(),
                    _buildDivider(),
                    _buildLanguageRow(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildWeekStartRow() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showWeekStartPicker(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Text(
                'Week starts on',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                _weekStartDay == 'monday' ? 'Monday' : 'Sunday',
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                CupertinoIcons.forward,
                size: 20,
                color: Color(0xFFC7C7CC),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Language',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            _language == 'en' ? 'English' : 'Russian',
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(left: 16),
      color: const Color(0xFFC6C6C8),
    );
  }

  void _showWeekStartPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // Header with Done button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.separator.resolveFrom(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              // Picker
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 44,
                  scrollController: FixedExtentScrollController(
                    initialItem: _weekStartDay == 'monday' ? 0 : 1,
                  ),
                  onSelectedItemChanged: (index) {
                    final value = index == 0 ? 'monday' : 'sunday';
                    _saveWeekStartDay(value);
                  },
                  children: const [
                    Center(child: Text('Monday')),
                    Center(child: Text('Sunday')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
