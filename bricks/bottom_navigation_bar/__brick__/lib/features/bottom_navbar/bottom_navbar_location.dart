import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/features/bottom_navbar/bottom_navbar.dart';

class BottomNavbarLocation extends BeamLocation<BeamState> {
  final RouteInformation routeInformation;

  BottomNavbarLocation(this.routeInformation) : super(routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('main{{^navbar}}-${DateTime.now()}{{/navbar}}'),
        title: 'Home',
        child: BottomNavbar(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [
        '/',
      ];
}
