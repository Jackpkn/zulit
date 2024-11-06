import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
///{@template ForgotPasswordButton}
/// A Button used for navigating  forgot password screen
/// {@endtemplate}
class ForgotPasswordButton extends StatelessWidget {
  /// {@macro [ForgotPasswordButton]}
  /// [ForgotPasswordButton]
  const ForgotPasswordButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      throttle: true,
      throttleDuration: 650.ms,
      onTap: (){},
      child: Text(
        'Forgot password',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.titleSmall?.copyWith(color: AppColors.blue),
      ),
    );
  }
}
