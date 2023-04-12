import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_5/bloc/blueBlock.dart';
import 'package:flutter_application_5/bloc/red_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedScreen extends StatelessWidget {
  const RedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RedBloc, RedState>(
          builder: (BuildContext context, RedState state) {
            int red = state.amount;
            return Container(
              height: 300,
              color: Color.fromRGBO(red, 0, 0, 1),
            );
          }, // BlocBuilder > builder
        ),
        BlocBuilder<BlueBloc, BlueState>(
          builder: (BuildContext context, BlueState state) {
            int blue = state.amount;
            return Container(
              height: 300,
              color: Color.fromRGBO(0, 0, blue, 1),
            );
          }, // BlocBuilder > builder
        ),
        Builder(builder: (BuildContext context) {
          RedState redState = context.watch<RedBloc>().state;
          BlueState blueState = context.watch<BlueBloc>().state;
          return Container(
            height: 300,
            color: Color.fromRGBO(redState.amount, 0, blueState.amount, 1),
          );
        }),
      ], // Column > Children
    );
  } // Widget
}
