import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:innerpalette/main_app.dart';
import 'package:provider/provider.dart';

import 'provider/color_provider.dart';
import 'provider/img_provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => ImgProvider()),
      ],
      child: const MainApp(),
    ),
  );
}
