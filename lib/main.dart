import 'package:flutter/material.dart';
import 'package:mycricketline/screen/Mysplash.dart';

import 'package:mycricketline/utils/Color.dart';
import 'package:provider/provider.dart';

import 'AipProvider/FinishApi.dart';
import 'AipProvider/LiveMatch.dart';
import 'AipProvider/ThemeProvider.dart';
import 'AipProvider/commentaryApi.dart';
import 'AipProvider/oddsApi.dart';
import 'AipProvider/pointTableApi.dart';
import 'AipProvider/upcomingapi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<LiveMatchProvider>(
                create: (_) => LiveMatchProvider(),
              ),
              ChangeNotifierProvider<InfoProvider>(
                create: (_) => InfoProvider(),
              ),
              ChangeNotifierProvider<SeriesProvider>(
                create: (_) => SeriesProvider(),
              ),
              // Add more providers as needed
              ChangeNotifierProvider<BlogProvider>(
                create: (_) => BlogProvider(),
              ),
              ChangeNotifierProvider<UpcomingMatchesProvider>(
                create: (_) => UpcomingMatchesProvider(),
              ),
              ChangeNotifierProvider<PlayerProvider>(
                create: (_) => PlayerProvider(),
              ),
              ChangeNotifierProvider<FinishMatchesProvider>(
                create: (_) => FinishMatchesProvider(),
              ),
              ChangeNotifierProvider<ScorerProvider>(
                create: (_) => ScorerProvider(),
              ),
              ChangeNotifierProvider<CommentaryApiProvider>(
                create: (_) => CommentaryApiProvider(),
              ),
              ChangeNotifierProvider<OddsApiProvider>(
                create: (_) => OddsApiProvider(),
              ),
              ChangeNotifierProvider<YourDataProvider>(
                create: (_) => YourDataProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Mycriketline',
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
              theme: themeProvider.isDarkTheme
                  ? buildDarkTheme()
                  : buildLightTheme(),
            ),
          );
        },
      ),
    );
  }
}
