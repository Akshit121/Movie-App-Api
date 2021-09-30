import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviapitask/Provider/connectivity.dart';

import 'package:moviapitask/data/Model/movieapi.dart';
import 'package:provider/provider.dart';

import 'data_connectiviy_service.dart';

class DetailScreen extends StatefulWidget {
  final MovieApi movapi;
  const DetailScreen({Key? key, required this.movapi}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double? ra;
  int? indexwriter;
  int? indexdirector;
  int? indexactors;

  @override
  void initState() {
    ra = double.tryParse(widget.movapi.imdbRating);
    indexwriter = widget.movapi.Writer.split(',').length;
    indexdirector = widget.movapi.Director.split(',').length;
    indexactors = widget.movapi.Actors.split(',').length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var api = widget.movapi;
    return Scaffold(body: SafeArea(child: Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Stack(children: [
                    BackgroundImageWidget(context),
                    arrorwidgettopscreen(context),
                    TitleWidget(),
                    GenereWidget(),
                    ColorshadeGradient(context),
                    Padding(
                      padding: const EdgeInsets.only(top: 403),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          downloadsharefavWidget('Assets/Vector 27.png'),
                          downloadsharefavWidget('Assets/Path-1.png'),
                          downloadsharefavWidget('Assets/Path.png'),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 489, left: 15, right: 15),
                      child: Container(
                        decoration: ContainerDecoration(),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 16),
                                  child: Column(
                                    children: [
                                      Transform.scale(
                                        scale: 0.6,
                                        alignment: Alignment.topLeft,
                                        child: RatingBar.builder(
                                          initialRating: ra! / 2,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Color(0xFFF79E44),
                                          ),
                                          onRatingUpdate: (ra) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 95,
                                ),
                                Text(
                                  widget.movapi.imdbRating,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: const Color(0xFFF79E44),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 105,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: widget.movapi.Rating.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              widget.movapi.Rating[i].Source,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: const Color(0xFFE9E9F1)
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            widget.movapi.Rating[i].Value,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: const Color(0xFFFFFFFF)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Containderfirst(api),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 895, left: 15, right: 15, bottom: 10),
                        child: Container(
                          decoration: ContainerDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  ContainerThirdForTitle('Plot'),
                                  SizedBox(
                                      width: 400,
                                      child: Text(
                                        api.Plot,
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: 1.0,
                                          height: 1.4,
                                          fontSize: 16,
                                          color: const Color(0xFFE9E9F1)
                                              .withOpacity(0.6),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 5),
                                    child: ContainerThirdForTitle('Director'),
                                  ),
                                  SizedBox(
                                    height: 90,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: indexdirector,
                                        itemBuilder: (context, i) {
                                          return i == indexdirector
                                              ? const SizedBox(
                                                  height: 1,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 9),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 32,
                                                        width: 160,
                                                        decoration:
                                                            boxdecorationfornames(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Text(
                                                              api.Director
                                                                      .toString()
                                                                  .split(
                                                                      ',')[i],
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 16,
                                                                color: const Color(
                                                                        0xFFE7CCCC)
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ContainerThirdForTitle('Actors'),
                                  ),
                                  SizedBox(
                                    height: 130,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: indexwriter,
                                        itemBuilder: (context, i) {
                                          return i == indexactors
                                              ? const SizedBox(
                                                  height: 1,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 32,
                                                        width:
                                                            i == 0 ? 190 : 160,
                                                        decoration:
                                                            boxdecorationfornames(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Text(
                                                              api.Actors
                                                                      .toString()
                                                                  .split(
                                                                      ',')[i],
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 16,
                                                                color: const Color(
                                                                        0xFFE7CCCC)
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ContainerThirdForTitle("Writer"),
                                  ),
                                  SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: indexwriter,
                                        itemBuilder: (context, i) {
                                          return i == indexwriter
                                              ? const SizedBox(
                                                  height: 1,
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: Container(
                                                        height: 32,
                                                        width:
                                                            i == 0 ? 120 : 180,
                                                        decoration:
                                                            boxdecorationfornames(),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              api.Writer
                                                                      .toString()
                                                                  .split(
                                                                      ',')[i],
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 16,
                                                                color: const Color(
                                                                        0xFFE7CCCC)
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                  ]);
                })
            : const NoInternet();
      }
      return buildLoading();
    })));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  BoxDecoration boxdecorationfornames() {
    return BoxDecoration(
        color: const Color(0xFF4C3766).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10));
  }

  BoxDecoration ContainerDecoration() => BoxDecoration(
      color: const Color(0xFF210F37), borderRadius: BorderRadius.circular(15));

  Container downloadsharefavWidget(String image) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF210F37),
          borderRadius: BorderRadius.circular(25)),
      width: 70,
      height: 70,
      child: Transform.scale(
        scale: 0.4,
        child: IconButton(
          onPressed: () {},
          icon: Image.asset(
            image,
          ),
        ),
      ),
    );
  }

  Positioned ColorshadeGradient(BuildContext context) => Positioned(
        top: 260,
        child: ClipRRect(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                0.0,
                0.0,
                0.9,
              ],
              colors: [
                Colors.black,
                Colors.red.withOpacity(0.0),
                const Color(0xFF16042E).withOpacity(0.0),
                const Color(0xFF17082A),
              ],
            )),
          ),
        ),
      );

  Positioned GenereWidget() {
    return Positioned(
        top: 265,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: 250,
            child: Text(
              widget.movapi.Genre,
              style: GoogleFonts.montserrat(fontSize: 15, color: Colors.white),
            ),
          ),
        ));
  }

  Positioned TitleWidget() {
    return Positioned(
        top: 180,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: 250,
            child: Text(
              widget.movapi.Title,
              style: GoogleFonts.montserrat(fontSize: 34, color: Colors.white),
            ),
          ),
        ));
  }

  CachedNetworkImage BackgroundImageWidget(BuildContext context) {
    return CachedNetworkImage(
        height: 420,
        width: MediaQuery.of(context).size.width,
        placeholder: (context, url) => Image(
              image: const AssetImage("Assets/placeholder.jpg"),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
        fit: BoxFit.fill,
        imageUrl: widget.movapi.Poster);
  }

  Positioned arrorwidgettopscreen(BuildContext context) {
    return Positioned(
      top: 25,
      left: 25,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10)),
        width: 50,
        height: 50,
        child: Transform.scale(
          scale: 0.9,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'Assets/arrow.png',
            ),
          ),
        ),
      ),
    );
  }

  Container ContainerThirdForTitle(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: const Color(0xFFFFFFFF).withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Padding Containderfirst(MovieApi api) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 660, left: 15, right: 15, bottom: 10),
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFF210F37),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Column(
                children: [
                  secondcontainer(api.Year, 'Assets/Group 357.png'),
                  secondcontainer(api.Country, 'Assets/Vector.png'),
                  secondcontainer(api.Runtime, 'Assets/clock.png'),
                  secondcontainer(api.Language, 'Assets/Group 358.png'),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
  }

  Row secondcontainer(String year, String image) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.6,
          child: IconButton(
            onPressed: () {},
            icon: Image.asset(
              image,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            year,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: const Color(0xFFE9E9F1).withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}

class star extends StatelessWidget {
  const star({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star,
      size: 16,
      color: Color(0xFFF79E44),
    );
  }
}
