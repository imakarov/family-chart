import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'core/providers/isar_provider.dart';
import 'core/providers/router_provider.dart';
import 'core/utils/localization_helper.dart';
import 'core/services/tasks_seeding_service.dart';
import 'data/models/checklists.dart';

// DEBUG: Set to true to reset database on app start
const bool DEBUG_RESET_DATABASE = false;

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
  static bool _hasInitializedDatabase = false; // Prevent multiple initializations

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Wait for Isar to initialize
      final isar = await ref.read(isarProvider.future);

      // Only run database initialization ONCE per app lifecycle
      if (!_hasInitializedDatabase) {
        _hasInitializedDatabase = true;

        // DEBUG: Clear database if flag is set
        if (DEBUG_RESET_DATABASE) {
          print('🔴 DEBUG: Clearing database...');
          await isar.writeTxn(() async {
            await isar.clear();
          });
          print('🔴 DEBUG: Database cleared!');
        }

        // Seed Tasks from TaskLibrary on first launch
        print('📦 [Main] Starting tasks seeding...');
        final tasksSeedingService = TasksSeedingService(isar);
        await tasksSeedingService.seedTasksIfNeeded();
        print('📦 [Main] Tasks seeding completed');

        // Check if onboarding is completed
        print('📦 [Main] Checking onboarding status...');
        final checklists = await isar.checklists.where().findAll();
        final hasCompletedOnboarding = checklists.isNotEmpty;
        print('📦 [Main] Onboarding completed: $hasCompletedOnboarding (${checklists.length} checklists)');
      } else {
        print('⏭️  [Main] Database already initialized, skipping...');
      }

      setState(() {
        _isInitialized = true;
      });
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

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: LocaleKeys.app.name.tr(),
      debugShowCheckedModeBanner: false,

      // Router
      routerConfig: router,

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
    );
  }
}
