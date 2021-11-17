import 'package:flutter/material.dart';
import 'package:heroes_app/model/heroes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<HeroesModel> _dataHeroFavorite = <HeroesModel>[];
  late SharedPreferences _prefs;

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("favoriteHero")) {
      if (mounted) {
        setState(() {
          _dataHeroFavorite =
              HeroesModel.decode(_prefs.getString("favoriteHero")!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //trigger leaving and use own data
        Navigator.pop(context, false);
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff333236),
          title: const Text("Pahlawan favorit"),
        ),
        body: _dataHeroFavorite.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dataHeroFavorite.length,
                itemBuilder: (BuildContext ctx, i) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(dataHero: _dataHeroFavorite[i])));
                        },
                        child: Card(
                          margin: const EdgeInsets.only(
                              top: 0.0, bottom: 0.0, right: 3.0, left: 3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/account_picture_default.png'),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      _dataHeroFavorite[i].name!,
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0.0,
                          left: 80,
                          child: GestureDetector(
                              onTap: () {
                                if (_dataHeroFavorite.any((item) =>
                                    item.name == _dataHeroFavorite[i].name)) {
                                  removeFavoriteHero(_dataHeroFavorite[i]);
                                } else {
                                  addFavoriteHero(_dataHeroFavorite[i]);
                                }
                              },
                              child: Icon(_dataHeroFavorite.any((item) =>
                                      item.name == _dataHeroFavorite[i].name)
                                  ? Icons.favorite
                                  : Icons.favorite_border))),
                    ],
                  );
                })
            : const Center(child: Text("No Data")),
      ),
    );
  }

  void addFavoriteHero(HeroesModel heroFavorite) async {
    if (mounted) {
      setState(() {
        _dataHeroFavorite.add(heroFavorite);
        String encodedData = HeroesModel.encode(_dataHeroFavorite);
        _prefs.setString("favoriteHero", encodedData);
      });
    }
  }

  void removeFavoriteHero(HeroesModel heroFavorite) async {
    if (mounted) {
      setState(() {
        _dataHeroFavorite.removeWhere((item) => item.name == heroFavorite.name);
        String encodedData = HeroesModel.encode(_dataHeroFavorite);
        _prefs.setString("favoriteHero", encodedData);
      });
    }
  }
}
