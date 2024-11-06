import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template sign_up_account_button}
/// Sign up widget that contains sign up button.
/// {@endtemplate}
class SignUpNewAccountButton extends StatelessWidget{
  ///{@macro [SignUpNewAccountButton]}
  const SignUpNewAccountButton({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit  = context.read<int>();
    return Tappable.faded(
      onTap: () {},
      child: Text.rich(
        overflow: TextOverflow.visible,
        style: context.bodyMedium,
        TextSpan(
          children: [
          const  TextSpan(text: 'No account text'),
            TextSpan(
              text: 'signUp.',
              style: context.bodyMedium?.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}