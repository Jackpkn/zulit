import 'package:app_ui/app_ui.dart';
import 'package:authentication/src/presentation/bloc/login_cubit.dart';
import 'package:authentication/src/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

/// {@template login_form}
/// A form used to log in a user.
/// {@endtemplate}
class LoginForm extends StatefulWidget {
  /// {@macro login_form}
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if(state.status.isError){

        }
      },
      listenWhen: (p, c) =>p.status != c.status,
      child: Column(
        children: [
          const EmailTextField(),
          const PasswordTextField(),
        ].spacerBetween(height: AppSpacing.md),
      ),
    );
  }
}
