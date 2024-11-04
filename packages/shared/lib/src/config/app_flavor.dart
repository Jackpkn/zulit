import 'package:env/env.dart';

/// Enum representing the different app flavors.
enum Flavor {
  /// Development environment
  development,
  /// Production environment
  production,
  /// Staging environment for testing
  staging,
}

/// Abstract class defining the structure for app environment configurations.
sealed class AppEnv {
  const AppEnv();

  /// Retrieves the specified environment variable.
  String getEnv(Env env);
}

/// Configuration class for managing app flavors and their environment-specific variables.
class AppFlavor extends AppEnv {

  /// Constructor for the development environment.
  factory AppFlavor.development() => const AppFlavor._(flavor: Flavor.development);

  /// Constructor for the production environment.
  factory AppFlavor.production() => const AppFlavor._(flavor: Flavor.production);

  /// Constructor for the staging environment.
  factory AppFlavor.staging() => const AppFlavor._(flavor: Flavor.staging);

  /// Private named constructor for initializing the app flavor.
  const AppFlavor._({required this.flavor});

  /// The current app flavor (development, production, or staging).
  final Flavor flavor;

  @override
  String getEnv(Env env) => switch (env) {
  // Matches environment-specific URLs for Supabase, PowerSync, iOS, Web, FCM, and Supabase Anon Key.
    Env.supabaseUrl => switch (flavor) {
      Flavor.development => EnvDev.supabaseUrl,
      Flavor.production => EnvDev.supabaseUrl,
      Flavor.staging => EnvDev.supabaseUrl,
    },
    Env.powerSyncUrl => switch (flavor) {
      Flavor.development => EnvDev.powersyncUrl,
      Flavor.production => EnvDev.powersyncUrl,
      Flavor.staging => EnvDev.powersyncUrl,
    },
    Env.iOSClientId => switch (flavor) {
      Flavor.development => EnvDev.iOSClientId,
      Flavor.production =>  EnvDev.iOSClientId,
      Flavor.staging =>  EnvDev.iOSClientId,
    },
    Env.webClientId => switch (flavor) {
      Flavor.development =>  EnvDev.webClientId,
      Flavor.production =>  EnvDev.webClientId,
      Flavor.staging =>  EnvDev.webClientId,
    },
    Env.fcmServerKey => switch (flavor) {
      Flavor.development =>  EnvDev.fcmServerKey,
      Flavor.production => EnvDev.fcmServerKey,
      Flavor.staging =>  EnvDev.fcmServerKey,
    },
    Env.supabaseAnonKey => switch (flavor) {
      Flavor.development =>  EnvDev.supabaseAnonKey,
      Flavor.production => EnvDev.supabaseAnonKey,
      Flavor.staging => EnvDev.supabaseAnonKey,
    }
  };
}
