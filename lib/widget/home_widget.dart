import 'package:flutter/material.dart';
import 'package:heroes_app/model/heroes_model.dart';
import 'package:heroes_app/page/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  final List<HeroesModel>? dataHero;

  const HomeWidget({Key? key, this.dataHero}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
      print("masuk shared");
      if (mounted) {
        setState(() {
          _dataHeroFavorite =
              HeroesModel.decode(_prefs.getString("favoriteHero")!);
        });
        print("ini data hero favorite cache " + HeroesModel.encode(_dataHeroFavorite));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.dataHero?.length,
        itemBuilder: (BuildContext ctx, i) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(dataHero: widget.dataHero![i])));
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
                              widget.dataHero![i].name!,
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
                        if (_dataHeroFavorite.any(
                            (item) => item.name == widget.dataHero![i].name)) {
                          print("masuk");
                          removeFavoriteHero(widget.dataHero![i]);
                        } else {
                          addFavoriteHero(widget.dataHero![i]);
                        }
                      },
                      child: Icon(_dataHeroFavorite.any(
                              (item) => item.name == widget.dataHero![i].name)
                          ? Icons.favorite
                          : Icons.favorite_border))),
            ],
          );
        });
  }

  void addFavoriteHero(HeroesModel heroFavorite) async {
    if (mounted) {
      setState(() {
        print("ini data hero favorite add 1" + _dataHeroFavorite.toString());
        _dataHeroFavorite.add(heroFavorite);
        String encodedData = HeroesModel.encode(_dataHeroFavorite);
        _prefs.setString("favoriteHero", encodedData);
        print("ini data hero favorite add" + encodedData.toString());
      });
    }
  }

  void removeFavoriteHero(HeroesModel heroFavorite) async {
    String encodedData = HeroesModel.encode([heroFavorite]);
    String encodedDataFav = HeroesModel.encode(_dataHeroFavorite);
    print("ini data encode favorite remove 1" + encodedData.toString());
    print("ini data hero favorite remove 2" + encodedDataFav.toString());
    if (mounted) {
      setState(() {
        _dataHeroFavorite.removeWhere((item) => item.name == heroFavorite.name);
        String encodedData = HeroesModel.encode(_dataHeroFavorite);
        _prefs.setString("favoriteHero", encodedData);
        print("ini data hero favorite remove" + encodedData.toString());
      });
    }
  }
}
