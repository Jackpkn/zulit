import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zulit/app/view/app_view.dart';
import 'package:zulit/selecter/theme/bloc/theme_mode_bloc.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => ThemeModeBloc(),
        ),
      ],
      child: AppView(),
    );
  }
}
