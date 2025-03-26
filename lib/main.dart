import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_example/main.reflectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
