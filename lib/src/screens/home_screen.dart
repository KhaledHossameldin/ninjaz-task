import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ninjaz_task/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.child});

  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _routes = GetIt.instance.get<Routes>();

  int _currentIndex = 0;

  void _changeTab(int index) {
    switch (index) {
      case 0:
        context.go(_routes.home);
        break;

      case 1:
        context.go(_routes.tab2);
        break;

      case 2:
        context.go(_routes.tab3);
        break;

      default:
        context.go(_routes.home);
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ninjaz Task')),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_rounded),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_as_unread_rounded),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Tab 3',
          ),
        ],
      ),
    );
  }
}
