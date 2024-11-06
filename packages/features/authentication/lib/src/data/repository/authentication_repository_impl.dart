import 'package:authentication/src/data/datasource/remote_data_source.dart';
import 'package:authentication/src/domain/repository/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

/// {@template authentication_repository_impl}
/// Repository for authentication.
/// {@endtemplate}
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// {@macro authentication_repository_impl}
  AuthenticationRepositoryImpl(this._client);
  final AuthenticationClientImpl _client;
  @override
  Future<Either<String, void>> logInWithGithub() {
    // TODO(Pawan): implement logInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> logInWithGoogle() {
    // TODO(Pawan): implement logInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> logInWithPassword({
    required String password,
    String? email,
    String? phone,
  }) {
    // TODO(Pawan): implement logInWithPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> logOut() {
    // TODO(Pawan): implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> resetPassword({
    required String token,
    required String email,
    required String newPassword,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> sendPasswordResetEmail(
      {required String email, String? redirectTo}) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> signUpWithPassword({
    required String password,
    required String fullName,
    required String username,
    String? avatarUrl,
    String? email,
    String? phone,
    String? pushToken,
  }) {
    return _attemptOperation<String, void>(
      () => _client.signUpWithPassword(
        password: password,
        fullName: fullName,
        username: username,
        avatarUrl: avatarUrl,
        email: email,
        phone: phone,
        pushToken: pushToken,
      ),
    );
  }
  /// Attempts to execute the provided [function] and returns the result as an
  /// [Either]. If the function throws an exception, it is caught and returned
  /// as a [Left]. Otherwise, the result is returned as a [Right].
  Future<Either<T1, T>> _attemptOperation<T1, T>(
    Future<T> Function() function,
  ) async {
    try {
      return right(await function());
    } catch (e) {
      return left(e as T1);
    }
  }
}
