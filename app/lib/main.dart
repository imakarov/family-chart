import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'core/providers/isar_provider.dart';
import 'core/utils/localization_helper.dart';
import 'core/services/seed_data_service.dart';
import 'data/models/checklists.dart';
import 'features/weekly_board/screens/weekly_board_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocales.supported,
      path: 'assets/translations',
      fallbackLocale: AppLocales.fallback,
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _isInitialized = false;
  int? _firstChecklistId;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Wait for Isar to initialize
      final isar = await ref.read(isarProvider.future);

      // Initialize seed data
      final seedService = SeedDataService(isar);
      await seedService.seedDemoData();

      // Get first checklist ID
      final checklists = await isar.checklists.where().findAll();
      if (checklists.isNotEmpty) {
        setState(() {
          _firstChecklistId = checklists.first.checklistId;
          _isInitialized = true;
        });
      } else {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing app: $e');
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_firstChecklistId == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('No checklist found. Please restart the app.'),
          ),
        ),
      );
    }

    return MaterialApp(
      title: LocaleKeys.app.name.tr(),
      debugShowCheckedModeBanner: false,

      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF), // iOS Blue
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,

      // Show Weekly Board as home screen
      home: WeeklyBoardScreen(checklistId: _firstChecklistId!),
    );
  }
}
