import 'package:app_ui/app_ui.dart';
import 'package:authentication/src/presentation/bloc/login_cubit.dart';
import 'package:authentication/src/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

/// (@template email_text_field)
/// A text field for email input.
/// (@endtemplate)
class EmailTextField extends StatefulWidget {
  /// Constructor
  const EmailTextField({super.key});

  @override
  State<StatefulWidget> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    final cubit = context.read<LoginCubit>()..resetState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onEmailUnfocused();
      }
      super.initState();
    });
  }
 @override
  void dispose() {
   _focusNode.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    final emailError = context.select(
        (LoginCubit cubit)=>cubit.state.password.errorMessage,
    );
    final isLoading = context.select(
        (LoginCubit cubit) =>cubit.state.status.isLoading,
    );
    return AppTextField(
      labelText: 'Email',
      key: const ValueKey('loginEmailTextField'),
      filled: true,
      hintText: '',
      enabled: !isLoading,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      onChanged: (value) =>_debouncer.run(
            ()=>context.read<LoginCubit>().onPasswordChanged(value),
      ),
      errorText: emailError,
    );
  }
}
