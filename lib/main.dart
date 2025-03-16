import 'package:flutter/material.dart';
import 'package:lady_driver/app.dart';

import 'core/cached/cached_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachedHelper.getInstance();
  runApp(const LadyDriver());
}
