import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroes_app/bloc/home/home_bloc.dart';
import 'package:heroes_app/widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();
  final TextEditingController _searchCont = TextEditingController();

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
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.shopping_cart),
            //     onPressed: () {},
            //   ),
            // ],
            bottom: AppBar(
              backgroundColor: const Color(0xff333236),
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    controller: _searchCont,
                    onChanged: onTextChanged,
                    decoration: const InputDecoration(
                        hintText: 'Cari dengan kata kunci',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.camera_alt)),
                  ),
                ),
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
    );
  }

  void onTextChanged(String value) async {
    if (!mounted) return;
    await Future.delayed(const Duration(seconds: 1));
    if (value.isNotEmpty && value == _searchCont.text) {
      print("cari" + value);
      setState(() {
        _homeBloc.add(GetSearchByKeywordList(keyword: _searchCont.text));
      });
    }
    if (_searchCont.text.toString().isEmpty) {
      setState(() {
        _homeBloc.add(GetHomeList());
      });
    }
    return;
  }
}
