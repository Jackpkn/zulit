import 'package:app_ui/app_ui.dart';
import 'package:authentication/src/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template login_page}
/// A login page.
/// {@endtemplate}
class LoginPage extends StatelessWidget {
  /// {@macro login_page}
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        // authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  /// Constructor
  const _LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body: AppConstrainedScrollView(child: Column()),
    );
  }
}
