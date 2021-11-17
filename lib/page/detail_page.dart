import 'package:flutter/material.dart';
import 'package:heroes_app/model/heroes_model.dart';

class DetailPage extends StatelessWidget {
  final HeroesModel dataHero;

  const DetailPage({Key? key, required this.dataHero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  alignment: Alignment.topCenter,
                  height: 250.0,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(25, 10),
                        bottomRight: Radius.elliptical(25, 10),
                      )),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/images/account_picture_default.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 200.0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 55.0),
                      child: Center(
                          child: Text(dataHero.name!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)))),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    backgroundColor: Colors.transparent, //No more green
                    elevation: 0.0, //Shadow gone
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
              child: Card(
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(dataHero.birthYear!,
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text('Lahir', style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(dataHero.deathYear!.toString(),
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text('Wafat', style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(dataHero.ascensionYear!.toString(),
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text('Pengangkatan',
                                style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            dataHero.description!.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                    child: Text(dataHero.description!,
                        textAlign: TextAlign.center),
                  )
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }
}
