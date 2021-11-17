import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroes_app/bloc/home/home_bloc.dart';

class SearchWidget extends StatefulWidget {
  final String currentSearch;
  final TextEditingController? searchCont,
      searchStartYearCont,
      searchEndYearCont;
  final HomeBloc homeBloc;

  const SearchWidget(
      {Key? key,
      required this.currentSearch,
      this.searchCont,
      this.searchStartYearCont,
      this.searchEndYearCont,
      required this.homeBloc})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.currentSearch == "keyword"
        ? displaySearchKeyword()
        : widget.currentSearch == "alive" ||
                widget.currentSearch == "birth" ||
                widget.currentSearch == "death"
            ? displaySearchAliveYear()
            : Container();
  }

  Widget displaySearchKeyword() {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: TextField(
        controller: widget.searchCont,
        onChanged: onTextChangedKeyword,
        decoration: const InputDecoration(
            hintText: 'Masukan kata kunci', prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  Widget displaySearchAliveYear() {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.searchStartYearCont,
              onChanged: onTextChangedYear,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  hintText: 'Tahun', prefixIcon: Icon(Icons.date_range)),
            ),
          ),
          const Expanded(child: Center(child: Text("Sampai"))),
          Expanded(
            child: TextField(
              controller: widget.searchEndYearCont,
              onChanged: onTextChangedYear,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  hintText: 'Tahun', prefixIcon: Icon(Icons.date_range)),
            ),
          )
        ],
      ),
    );
  }

  void onTextChangedKeyword(String value) async {
    if (!mounted) return;
    await Future.delayed(const Duration(seconds: 1));
    if (value.isNotEmpty && value == widget.searchCont!.text) {
      print("cari" + value);
      setState(() {
        widget.homeBloc
            .add(GetSearchByKeywordList(keyword: widget.searchCont!.text));
      });
    }
    if (widget.searchCont!.text.toString().isEmpty) {
      setState(() {
        widget.homeBloc.add(GetHomeList());
      });
    }
    return;
  }

  void onTextChangedYear(String value) async {
    if (!mounted) return;
    await Future.delayed(const Duration(seconds: 1));
    if (widget.searchStartYearCont!.text.isNotEmpty &&
        widget.searchEndYearCont!.text.isNotEmpty) {
      print("cari" + value);
      setState(() {
        if (widget.currentSearch == "alive") {
          widget.homeBloc.add(GetSearchByAliveList(
              startYear: widget.searchStartYearCont!.text,
              endYear: widget.searchEndYearCont!.text));
        } else if (widget.currentSearch == "birth") {
          widget.homeBloc.add(GetSearchByBirthList(
              startYear: widget.searchStartYearCont!.text,
              endYear: widget.searchEndYearCont!.text));
        } else if (widget.currentSearch == "death") {
          widget.homeBloc.add(GetSearchByDeathList(
              startYear: widget.searchStartYearCont!.text,
              endYear: widget.searchEndYearCont!.text));
        }
      });
    }
    if (widget.searchStartYearCont!.text.toString().isEmpty &&
        widget.searchEndYearCont!.text.toString().isEmpty) {
      setState(() {
        widget.homeBloc.add(GetHomeList());
      });
    }
    return;
  }
}
