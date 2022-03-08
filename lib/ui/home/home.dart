import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/constants/route_constants.dart';
import 'package:todo/constants/search_bar_constant.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/widgets/search_bar.dart';

import '../../widgets/empty_animation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> _addButtonAnimation;
  late AnimationController _addButtonAnimationController;

  @override
  void initState() {
    _addButtonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _addButtonAnimation = CurvedAnimation(
      parent: _addButtonAnimationController,
      curve: Curves.easeInOut,
    );

    _addButtonAnimationController.repeat(
      reverse: true,
      period: const Duration(
        milliseconds: 1500,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _addButtonAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _handleAdd,
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: _addButtonAnimation,
        ),
      ),
      body: Stack(children: const [
        Padding(
          padding: EdgeInsets.only(
            top: SearchBarConstant.height,
          ),
          child: Center(
            child: EmptyAnimation(),
          ),
        ),
        SearchBar()
      ]),
    );
  }

  void _handleAdd() {
    Navigator.pushNamed(context, RouteConstants.addTodo);
  }
}
