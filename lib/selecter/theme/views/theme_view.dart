import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zulit/l10n/l10n.dart';
import 'package:zulit/selecter/theme/bloc/theme_mode_bloc.dart';

/// A drop down menu to select a new [ThemeMode]
///
/// Requires a [ThemeModeBloc] to be provided in the widget tree
/// (usually above [MaterialApp])
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {

    final themeMode = context.watch<ThemeModeBloc>().state;
    return Material(child:
      DropdownButton(
      key: const Key('themeSelector_dropdown'),
      onChanged: (ThemeMode? selectedThemeMode) => context
          .read<ThemeModeBloc>()
          .add(ThemeModeChanged(selectedThemeMode)),
      value: themeMode,
      items:const[
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text(
            'l10n.systemOption',
            key:   Key('themeSelector_system_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text(
            'light',
            key:   Key('themeSelector_light_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text(
            'dark',
            key:   Key('themeSelector_dark_dropdownMenuItem'),
          ),
        ),
      ],
      )
    );
  }
}

class ThemeSelectorModalOption extends StatelessWidget {
  const ThemeSelectorModalOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ThemeSelector(),
      title: Text('Theme'),
    );
  }
}
