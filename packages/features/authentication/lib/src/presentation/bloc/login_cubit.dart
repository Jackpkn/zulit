import 'dart:io';

import 'package:authentication/src/data/datasource/remote_data_source.dart';
import 'package:bloc/bloc.dart';
import 'package:form_field/form_field.dart';
import 'package:shared/shared.dart';
part 'login_state.dart';
///
class LoginCubit extends Cubit<LoginState> {
  ///
  LoginCubit() : super( const LoginState.initial());

  /// changes password visibility, making it visible or not
  void changePasswordVisibility() {
    state.copyWith(showPassword: !state.showPassword);
  }
  /// emit initial state for login
   void resetState() => emit(const LoginState.initial());
  /// email value was change triggering  new change in state
  void emailChanged(String newValue){
     final previousScreenState = state;
     final previousEmailState = state.email;
     final shouldValidate = previousEmailState.invalid;
     final newEmailState = shouldValidate
         ? Email.dirty(
       newValue,
     )
         : Email.pure(
       newValue,
     );
     final newScreenState = state.copyWith(
       email: newEmailState,
     );

     emit(newScreenState);

  }
  /// Email field was unfocused, here is checking if previous state with email
  /// was valid, in order to indicate it in state after unfocus.
  void onEmailUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.dirty(
      previousEmailValue,
    );
    final newScreenState = previousScreenState.copyWith(
      email: newEmailState,
    );
    emit(newScreenState);
  }
  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emitting new
  /// [Password] validation state.
  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
      newValue,
    )
        : Password.pure(
      newValue,
    );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }
   ///
  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  /// Makes whole login state initial, as [Email] and [Password] becomes invalid
  /// and [LogInSubmissionStatus] becomes idle. Solely used if during login
  /// user switched on sign up, therefore login state does not persists and
  /// becomes initial again.
  void idle() {
    const initialState = LoginState.initial();
    emit(initialState);
  }
  ///
  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LogInSubmissionStatus.googleAuthInProgress));
    try {
      // await _userRepository.logInWithGoogle();
      emit(state.copyWith(status: LogInSubmissionStatus.success));
    } on LogInWithGoogleCanceled {
      emit(state.copyWith(status: LogInSubmissionStatus.idle));
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  /// Formats error, that occurred during login process.
  void _errorFormatter(Object e, StackTrace stackTrace) {
    addError(e, stackTrace);

    final status = switch (e) {
      LogInWithPasswordFailure(:final AuthException error) => switch (
      int.tryParse(error.statusCode ?? '') // Try parsing statusCode to int
      ) {
        HttpStatus.badRequest => LogInSubmissionStatus.invalidCredentials,
        _ => LogInSubmissionStatus.error,
      },
      LogInWithGoogleFailure => LogInSubmissionStatus.googleLogInFailure,
      _ => LogInSubmissionStatus.idle,
    };

    final newState = state.copyWith(
      status: status,
      message: e.toString(),
    );
    emit(newState);
  }
  ///
  Future<void> onSubmit()async{
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final isFormValid = FormzValid([email, password]).isFormValid;
    final newState = state.copyWith(
      email: email,
      password:  password,
      status: isFormValid? LogInSubmissionStatus.loading: null,
    );
    emit(newState);
    if (!isFormValid) return;
    try{
      final newState = state.copyWith(status: LogInSubmissionStatus.success);
      emit(newState);
    }catch(error, stackTrace){
      _errorFormatter(error, stackTrace);
    }
  }
}
