import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:zulit/app/routes/routes.dart';
import 'package:zulit/selecter/theme/bloc/theme_mode_bloc.dart';
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
     final routerConfig = AppRouter().router;
     AppLogger().logError('AppView', time: DateTime.now());
    return BlocBuilder<ThemeModeBloc,ThemeMode>(
      builder: (context, themeMode) => AnimatedSwitcher(
        duration:const  Duration(milliseconds: 300),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Instagram',
            routerConfig: routerConfig,
            builder: (context, child) {
               return Container();
            },
            themeMode: themeMode,
            theme: const AppTheme().theme,
            darkTheme: const AppDarkTheme().theme,
            // locale: locale,

          ),
        ),
      ),
    );
  }
}





// Example home screen with navigation and loading toggle
