import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled14/screen/home/provider/home_provider.dart';
import 'package:untitled14/screen/home/view/home_Screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Webprovider(),
        )
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
        '/': (context) => HomeSCreen(),
      }),
    ),
  );
}
