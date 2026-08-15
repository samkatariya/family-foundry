import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'core/routing.dart';

class FamilyFoundryApp extends StatelessWidget {
  const FamilyFoundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Family Foundry Hub',
      theme: appTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
