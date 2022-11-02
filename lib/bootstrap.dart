import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:object_box/object_box.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  // create object box store
  final objectBox = await ObjectBoxProvider.create();

  await runZonedGuarded(
    // provide object box store to app
    () async => runApp(Provider<ObjectBoxProvider>(
      child: await builder(),
      create: (_) => objectBox,
      dispose: (_, object) => object.dispose(),
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
