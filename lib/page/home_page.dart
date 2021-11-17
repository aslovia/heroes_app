import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroes_app/bloc/home/home_bloc.dart';
import 'package:heroes_app/page/favorite_page.dart';
import 'package:heroes_app/widget/search_widget.dart';
import 'package:heroes_app/widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();

  final TextEditingController _searchCont = TextEditingController();
  final TextEditingController _searchStartYearCont = TextEditingController();
  final TextEditingController _searchEndYearCont = TextEditingController();

  final List _typeSearch = [
    {'searchKey': 'all', 'searchName': 'Cari berdasarkan semua pahlawan'},
    {'searchKey': 'keyword', 'searchName': 'Cari berdasarkan kata kunci'},
    {
      'searchKey': 'alive',
      'searchName': 'Cari berdasarkan tahun periode hidup '
    },
    {'searchKey': 'birth', 'searchName': 'Cari berdasarkan tahun lahir'},
    {'searchKey': 'death', 'searchName': 'Cari berdasarkan tahun meninggal'}
  ];
  String _currentSearch = "all";

  @override
  void initState() {
    super.initState();
    _homeBloc.add(GetHomeList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xff333236),
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: true,
              title: const Text('PAHLAWAN'),
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(_currentSearch == "all" ? 60 : 100),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                      height: 40,
                      color: const Color(0xff333236),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: _typeSearch.map((item) {
                          return DropdownMenuItem(
                              value: item['searchKey'],
                              child: Text(
                                item['searchName'],
                              ));
                        }).toList(),
                        value: _currentSearch,
                        onChanged: _selectSearch,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                    ),
                    SearchWidget(
                        currentSearch: _currentSearch,
                        homeBloc: _homeBloc,
                        searchCont: _searchCont,
                        searchStartYearCont: _searchStartYearCont,
                        searchEndYearCont: _searchEndYearCont)
                  ],
                ),
              ),
            ),
            // Other Sliver Widgets
            SliverList(
              delegate: SliverChildListDelegate([
                BlocProvider(
                  create: (context) => _homeBloc,
                  child: BlocListener<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is HomeErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMessage),
                            duration: const Duration(seconds: 3)));
                      }
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeSuccessState) {
                          return HomeWidget(dataHero: state.heroes);
                        } else if (state is HomeLoadingState) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else if (state is HomeEmptyState) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.3,
                              child: const Center(child: Text("No Data")));
                        } else if (state is HomeErrorState) {
                          return Text(state.errorMessage);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const FavoritePage()))
                .then((value) =>
                    value != null ? _selectSearch(_currentSearch) : null);
          },
          icon: const Icon(Icons.favorite),
          label: const Text("Pahlawan Favorit"),
        ));
  }

  void _selectSearch(value) {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _currentSearch = value;
      if (_currentSearch == "all") {
        _homeBloc.add(GetHomeList());
      } else if (_currentSearch == "keyword") {
        _homeBloc.add(GetSearchByKeywordList(keyword: _searchCont.text));
      } else if (_currentSearch == "alive") {
        _homeBloc.add(GetSearchByAliveList(
            startYear: _searchStartYearCont.text,
            endYear: _searchEndYearCont.text));
      } else if (_currentSearch == "birth") {
        _homeBloc.add(GetSearchByBirthList(
            startYear: _searchStartYearCont.text,
            endYear: _searchEndYearCont.text));
      } else if (_currentSearch == "death") {
        _homeBloc.add(GetSearchByDeathList(
            startYear: _searchStartYearCont.text,
            endYear: _searchEndYearCont.text));
      }
    });
  }
}
