import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:takeroot/main.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key, required this.child, required this.location});

  final String location;
  final Widget child;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  int _getSelectedIndex(BuildContext context) {
    final String location = widget.location;
    switch (location) {
      case '/home':
        return 0;
      case '/shop':
        return 1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        NavigationRail(
          useIndicator: true,
          selectedIndex: _getSelectedIndex(context),
          groupAlignment: groupAlignment,
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PopupMenuButton(
                    child: const CircleAvatar(
                      child: Text("LS"),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Text('Log Out'),
                        onTap: () async {
                          await supabase.auth.signOut();
                          if (context.mounted) context.go('/');
                        },
                      )
                    ],
                  )),
            ),
          ),
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/shop');
                break;
            }
          },
          labelType: labelType,
          leading: const Padding(
            padding: EdgeInsets.only(bottom: 10, top: 5),
            child: SizedBox(width: 50, height: 50, child: Text("LogoHere")),
          ),
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard),
                label: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Home'),
                )),
            NavigationRailDestination(
                icon: Icon(Icons.shop),
                selectedIcon: Icon(Icons.shop_2),
                label: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Shop'),
                )),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
            child: Column(
          children: [Expanded(child: widget.child)],
        )),
      ],
    ));
  }
}
