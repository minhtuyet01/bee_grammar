import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'data/service_locator.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/email_verification_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/student/main_navigation_screen.dart';
import 'services/deep_link_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize all services with mock data
  await ServiceLocator().initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const BeeGrammarApp(),
    ),
  );
}

class BeeGrammarApp extends StatefulWidget {
  const BeeGrammarApp({super.key});
  
  // Global key to preserve navigation state
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<BeeGrammarApp> createState() => _BeeGrammarAppState();
}

class _BeeGrammarAppState extends State<BeeGrammarApp> {
  final _deepLinkService = DeepLinkService();

  @override
  void initState() {
    super.initState();
    // Initialize deep link service after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && BeeGrammarApp.navigatorKey.currentContext != null) {
        _deepLinkService.initialize(BeeGrammarApp.navigatorKey.currentContext!);
      }
    });
  }

  @override
  void dispose() {
    _deepLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp(
          navigatorKey: BeeGrammarApp.navigatorKey, // Preserve navigation state
          title: 'BeeGrammar',
          debugShowCheckedModeBanner: false,
          
          // Routes
          routes: {
            '/reset-password': (context) {
              final oobCode = ModalRoute.of(context)!.settings.arguments as String;
              return ResetPasswordScreen(oobCode: oobCode);
            },
          },
          
          // Localization
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi'),
            Locale('en'),
          ],
          locale: localeProvider.locale,
          
          // Theme
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color(0xFF2C2C2C),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              color: const Color(0xFF2C2C2C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white70),
              bodySmall: TextStyle(color: Colors.white60),
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              titleMedium: TextStyle(color: Colors.white),
              titleSmall: TextStyle(color: Colors.white70),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white70,
            ),
            dividerColor: Colors.white12,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2C2C2C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.white38),
            ),
          ),
          home: const AuthGate(),
        );
      },
    );
  }
}

// Separate widget to handle auth state without rebuilding on theme changes
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // Use userChanges() instead of authStateChanges() to detect emailVerified changes
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        print('🔄 Auth State - Connection: ${snapshot.connectionState}, HasData: ${snapshot.hasData}, Email: ${snapshot.data?.email}, Verified: ${snapshot.data?.emailVerified}');
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('⏳ Waiting for auth state...');
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          print('✅ User logged in: ${user.email}, Verified: ${user.emailVerified}');
          
          // Check if email is verified
          if (!user.emailVerified) {
            print('⚠️ Email not verified, showing verification screen');
            return const EmailVerificationScreen();
          }
          
          return const MainNavigationScreen();
        } else {
          print('❌ No user, showing login');
          return const LoginScreen();
        }
      },
    );
  }
}
