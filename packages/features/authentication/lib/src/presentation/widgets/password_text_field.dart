import 'package:app_ui/app_ui.dart';
import 'package:authentication/src/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
/// {@template password_text_field}
/// A text field for password input.
/// {@endtemplate}
class PasswordTextField extends StatefulWidget {
  /// ({@macro password_text_field})
  const PasswordTextField({
    super.key,
  });
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<LoginCubit>()..resetState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordError = context.select(
      (LoginCubit cubit) => cubit.state.password.errorMessage,
    );
    final showPassword = context.select(
      (LoginCubit cubit) => cubit.state.showPassword,
    );
    final isLoading = context.select(
      (LoginCubit cubit) => cubit.state.status.isLoading,
    );
    return AppTextField(
      key: const ValueKey('loginPasswordTextField'),
      filled: true,
      focusNode: _focusNode,
      hintText: 'Password',
      enabled: !isLoading,
      obscureText: !showPassword,
      textInputType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => context.read<LoginCubit>().onSubmit(),
      onChanged: (v) => _debouncer.run(
        () => context.read<LoginCubit>().onPasswordChanged(v),
      ),
      errorText: passwordError,
      suffixIcon: Tappable.faded(
        backgroundColor: AppColors.transparent,
        onTap: context.read<LoginCubit>().changePasswordVisibility,
        child: Icon(
          !showPassword ? Icons.visibility : Icons.visibility_off,
          color: context.customAdaptiveColor(light: AppColors.grey),
        ),
      ),
    );
  }
}