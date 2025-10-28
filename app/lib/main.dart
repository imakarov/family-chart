import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'core/providers/isar_provider.dart';
import 'core/utils/localization_helper.dart';
import 'core/services/seed_data_service.dart';
import 'data/models/checklists.dart';
import 'screens/weekly_board_screen.dart';
import 'screens/onboarding/onboarding_flow_screen.dart';

// DEBUG: Set to true to reset database on app start
const bool DEBUG_RESET_DATABASE = true;

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

      // DEBUG: Clear database if flag is set
      if (DEBUG_RESET_DATABASE) {
        print('🔴 DEBUG: Clearing database...');
        await isar.writeTxn(() async {
          await isar.clear();
        });
        print('🔴 DEBUG: Database cleared!');
      }

      // Check if onboarding is completed
      final checklists = await isar.checklists.where().findAll();
      final hasCompletedOnboarding = checklists.isNotEmpty;

      if (hasCompletedOnboarding) {
        // Initialize seed data (for demo purposes)
        final seedService = SeedDataService(isar);
        await seedService.seedDemoData();

        setState(() {
          _firstChecklistId = checklists.first.checklistId;
          _isInitialized = true;
        });
      } else {
        // No checklist - show onboarding
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

      // Show Onboarding or Weekly Board based on checklist existence
      home: _firstChecklistId == null
          ? const OnboardingFlowScreen()
          : WeeklyBoardScreen(checklistId: _firstChecklistId!),
    );
  }
}
