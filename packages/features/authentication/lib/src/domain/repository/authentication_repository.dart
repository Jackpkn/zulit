import 'package:authentication/src/data/datasource/remote_data_source.dart';
import 'package:fpdart/fpdart.dart';
/// {@template authentication_repository}
/// Repository for authentication.
/// {@endtemplate}
abstract interface class AuthenticationRepository {
  /// Signs up with the provided [email] and [password].
  /// Throws a [SignUpWithPasswordFailure] if an exception occurs.
  Future<Either<String, void>> signUpWithPassword({
    required String password,
    required String fullName,
    required String username,
    String? avatarUrl,
    String? email,
    String? phone,
    String? pushToken,
  });

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithPasswordFailure] if an exception occurs.
  Future<Either<String, void>> logInWithPassword(
      {required String password, String? email, String? phone});

  /// Starts the Sign In with Google Flow.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<Either<String, void>> logInWithGoogle();

  /// Starts the Sign In with Github Flow.
  /// Throws a [LogInWithGithubFailure] if an exception occurs.
  Future<Either<String, void>> logInWithGithub();

  /// Signs out the current user.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<Either<String, void>> logOut();

  /// Sends a password reset email to the provided [email] address.
  /// Optionally, a [redirectTo] URL can be specified.
  Future<Either<String, void>> sendPasswordResetEmail({
    required String email,
    String? redirectTo,
  });

  /// Resets the password for a user using the provided [token], [email],
  /// and [newPassword].
  Future<Either<String, void>> resetPassword({
    required String token,
    required String email,
    required String newPassword,
  });
}
