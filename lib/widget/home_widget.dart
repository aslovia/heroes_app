import 'package:flutter/material.dart';
import 'package:heroes_app/model/heroes_model.dart';
import 'package:heroes_app/page/detail_page.dart';

class HomeWidget extends StatelessWidget {
  final List<HeroesModel>? dataHero;

  const HomeWidget({Key? key, this.dataHero}) : super(key: key);

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
        itemCount: dataHero?.length,
        itemBuilder: (BuildContext ctx, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(dataHero: dataHero![i])));
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
                          dataHero![i].name!,
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
          );
        });
  }
}
