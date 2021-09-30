import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviapitask/Provider/connectivity.dart';
import 'package:moviapitask/Ui/data_connectiviy_service.dart';

import 'package:moviapitask/Ui/inputDecoration.dart';

import 'package:moviapitask/bloc/Movie/movie_bloc.dart';
import 'package:moviapitask/bloc/Movie/movie_event.dart';

import 'package:moviapitask/bloc/Movie/movie_state.dart';
import 'package:moviapitask/data/Model/movieapi.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DetailBloc? detailBloc;
  int? hour;
  int? min;
  var movieController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();

    detailBloc = BlocProvider.of<DetailBloc>(context, listen: false);
  }

  @override
  void dispose() {
    movieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? BlocBuilder<DetailBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieInitialState) {
                    return initialwidget();
                  } else if (state is MovieLoadingState) {
                    return buildLoading();
                  } else if (state is MovieLoadedState) {
                    return nitialwidget(state.movieapi);
                  } else if (state is MovieErrorState) {
                    return buildErrorUi(state.toString());
                  }
                  return const Text('error');
                },
              )
            : NoInternet();
      }
      return buildLoading();
    }));
  }

  SafeArea nitialwidget(MovieApi movapi) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: ListView(
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          searchwidget(),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            movapi: movapi,
                          )));
            },
            child: Container(
              width: double.infinity,
              height: 230,
              padding: const EdgeInsets.all(5),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) => Image(
                            image: const AssetImage("Assets/placeholder.jpg"),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                      fit: BoxFit.cover,
                      imageUrl: movapi.Poster),
                ),
                Positioned(
                    top: 8,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 22,
                          color: Colors.black54,
                          child: Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                child: Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  '${movapi.Rating.first.Value}',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4),
            child: Text(
              movapi.Title,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.5,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'Assets/clock.png',
                    ),
                  ),
                ),
                Text(
                  movapi.Runtime,
                  style: GoogleFonts.montserrat(color: const Color(0xFFF79E44)),
                )
              ],
            ),
          )
        ],
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('Assets/backgroundimage.png'),
        fit: BoxFit.cover,
      )),
    ));
  }

  SafeArea initialwidget() {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          searchwidget(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('Assets/backgroundimage.png'),
        fit: BoxFit.cover,
      )),
    ));
  }

  Container searchwidget() {
    return Container(
      child: TextField(
        style: GoogleFonts.montserrat(
            fontSize: 18.0, color: const Color(0xFF9287A1)),
        onSubmitted: (value) {
          detailBloc!.add(FetchMovieEvent(movieController.text));
        },
        controller: movieController,
        decoration: Inputdecorationwidget(movieController, 'Search Movie', ''),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: GoogleFonts.montserrat(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
