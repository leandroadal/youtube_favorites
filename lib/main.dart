import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/bloc/favorite_bloc.dart';
import 'package:fav_youtube_with_bloc/bloc/videos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/video_description.dart';
import 'bloc/volume_bloc.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        // Brilho dos ícones na barra de status
        systemNavigationBarDividerColor: Color(0xFF1c1c1c),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    const SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFF1c1c1c));
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
        Bloc((i) => DescriptionBloc()),
        Bloc((i) => VolumeBloc()),
      ],
      dependencies: const [],
      child: MaterialApp(
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
          iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
            ),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
