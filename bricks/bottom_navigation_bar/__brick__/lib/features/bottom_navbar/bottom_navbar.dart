import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

{{#tabs}}
{{^navbar}}
import 'package:{{project_name.snakeCase()}}/features/{{name.snakeCase()}}/presentation/pages/{{name.snakeCase()}}_page.dart'; {{/navbar}}{{/tabs}}
import 'package:{{project_name.snakeCase()}}/features/bottom_navbar/home_tabs.dart';
{{#navbar}}
import 'package:{{project_name.snakeCase()}}/features/bottom_navbar/navbar_delegates.dart';
{{/navbar}}


class BottomNavbar extends ConsumerStatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);
  
  @override
  ConsumerState<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends ConsumerState<BottomNavbar> {
  late int currentIndex;
  {{#navbar}}final _routerDelegates = listOfBeamerDelegates();{{/navbar}}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    currentIndex = _getCurrentString(uriString);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: {{^navbar}}const{{/navbar}} [{{#tabs}}{{^navbar}}
            {{name.pascalCase()}}Page(),{{/navbar}}{{#navbar}}
            Beamer(
                routerDelegate: {{#isFirst}}_routerDelegates.first{{/isFirst}}{^isFirst}}{{^isLast}}_routerDelegates[{{indexAt}}]{{/isLast}}{{/isFirst}}{{#isLast}}_routerDelegates[{{indexAt}}]{{/isLast}},
              ),{{/navbar}}{{/tabs}}
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.1),
            selectedItemColor: Colors.red.shade400,
            unselectedItemColor: Colors.black.withOpacity(0.6),
            type: BottomNavigationBarType.fixed,
            items: HomeTabs.values.map(
              (tab) {
                return BottomNavigationBarItem(
                  icon: Icon(
                    tab.getImagePath(),
                  ),
                  label: tab.getTabTitle(),
                );
              },
            ).toList(),
            onTap: (index) {
               if (index != currentIndex) {
                setState(() => currentIndex = index);
                {{^navbar}}Beamer.of(context).update(
                  configuration: RouteInformation(
                    location: HomeTabExtension.tabRoute.entries
                        .elementAt(index)
                        .value,
                  ),
                  rebuild: false,
                );{{/navbar}}{{#navbar}}_routerDelegates[currentIndex].update(rebuild: false);{{/navbar}}
              }
            },
          ),
        ),
        
      ],
    );
  }
}

int _getCurrentString(String uriString) {
    return HomeTabs.values
        .where((element) => uriString.startsWith(element.getSnakeCaseTitle()))
        .first
        .index;
}
