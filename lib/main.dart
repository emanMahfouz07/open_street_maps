import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maps/Features/Favorites/fav_service.dart';
import 'package:maps/utils/theme_service.dart';
import 'package:maps/utils/app_theme.dart';
import 'package:maps/geo_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final favoritesService = await FavoritesService.initialize();
  final themeService = await ThemeService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: favoritesService),
        ChangeNotifierProvider.value(value: themeService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, _) {
        return MaterialApp(
          title: 'Maps App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          home: const GeoMap(),
        );
      },
    );
  }
}
