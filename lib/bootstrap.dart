import 'dart:async';
import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
typedef AppBuilder = FutureOr<void> Function();

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger().logError('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger().logError('onError ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    AppLogger().logError(details.exceptionAsString(), stackTrace: details.stack);
  };
  BindingBase.debugZoneErrorsAreFatal = true;

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    );

    SystemUiOverlayTheme.setPortraitOrientation();
    runApp(await builder());
  }, (error, stackTrace) {
    AppLogger().logError(error.toString(), stackTrace: stackTrace);
  });
}
