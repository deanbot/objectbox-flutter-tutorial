import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'object_box/object_box.dart';

// TODO : don't do this
/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectbox;

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
