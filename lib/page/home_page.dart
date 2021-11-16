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

  @override
  void initState() {
    super.initState();
    _homeBloc.add(GetHomeList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff333236),
          centerTitle: true,
          title: Text("PAHLAWAN"),
        ),
        body: BlocProvider(
          create: (context) => _homeBloc,
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeErrorState) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 3),
                ));
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeSuccessState) {
                  return HomeWidget(dataHero: state.heroes);
                } else if (state is HomeLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.black));
                } else if (state is HomeEmptyState) {
                  return const Text("No Data");
                } else if (state is HomeErrorState) {
                  return Text(state.errorMessage);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }
}
