import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviapitask/Provider/connectivity.dart';

import 'package:moviapitask/Ui/home_page.dart';
import 'package:moviapitask/bloc/Movie/movie_bloc.dart';
import 'package:moviapitask/data/repository/movie_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(),
            child: const HomePage()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF17082A),
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: BlocProvider(
          create: (context) => DetailBloc(repository: MovieRepositoryImpl()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
