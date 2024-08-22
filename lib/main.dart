import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'firstpage.dart';
import 'secondpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool _isCupertino = true;

  void _toggleDesign() {
    setState(() {
      _isCupertino = !_isCupertino;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isCupertino ? _buildCupertinoApp() : _buildMaterialApp();
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(
        isCupertino: _isCupertino,
        toggleDesign: _toggleDesign,
      ),
    );
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: MainScreen(
        isCupertino: _isCupertino,
        toggleDesign: _toggleDesign,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isCupertino;
  final VoidCallback toggleDesign;

  const MainScreen({
    super.key,
    required this.isCupertino,
    required this.toggleDesign,
  });

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      MyHomePage(isCupertino: widget.isCupertino),
      SecondPage(
        isCupertino: widget.isCupertino,
        toggleDesign: widget.toggleDesign,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isCupertino ? cupertinoScaffold() : materialScaffold();
  }

  Widget materialScaffold() {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.navigate_next), label: 'Second')
        ],
      ),
    );
  }

  Widget cupertinoScaffold() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.today),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.arrow_right),
            label: 'Second',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              child: Center(
                child: _pages.elementAt(index),
              ),
            );
          },
        );
      },
    );
  }
}
