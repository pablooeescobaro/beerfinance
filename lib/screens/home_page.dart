import 'package:beer_app/styles.dart';
import 'package:beer_app/widget/buttom.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

HomeBloc _bloc = HomeBloc();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: 'Beer',
          style: BS.bold18.apply(color: BC.brandBlack),
        ),
        TextSpan(
          text: 'Finance',
          style: BS.bold18.apply(color: BC.brandYellow),
        ),
      ])),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _mainInformation(context),
        _mainActivity(context),
        _mainButton(context),
      ],
    );
  }

  Widget _mainInformation(BuildContext context) {
    return Container();
  }

  Widget _mainActivity(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: const [],
        ),
      ),
    );
  }

  Widget _mainButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          color: BC.brandBlack,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: CustomButton(text: 'Внести трату', width: MediaQuery.of(context).size.width / 3),
          ),
          InkWell(
            child: CustomButton(text: 'Внести сбережение', width: MediaQuery.of(context).size.width / 3),
          ),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: CustomButton(text: 'Внести доход', width: MediaQuery.of(context).size.width / 3),
          )
        ],
      ),
    );
  }
}
