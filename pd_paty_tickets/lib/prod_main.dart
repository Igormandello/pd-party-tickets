import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'app.dart';

void main() async {
  await GlobalConfiguration().loadFromAsset("prod_env");
  runApp(App());
}