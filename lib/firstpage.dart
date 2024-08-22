import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  final bool isCupertino;
  const MyHomePage({super.key, required this.isCupertino});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getCurrentTime() {
    DateTime time = DateTime.now();
    String rt;
    if (time.month <= DateTime.february) {
      rt = '${time.year.toInt() - 1912}A';
    } else if (time.month <= DateTime.august) {
      rt = '${time.year.toInt() - 1912}B';
    } else {
      rt = '${time.year.toInt() - 1911}A';
    }
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isCupertino ? cupertinoScaffold() : materialScaffold();
  }

  Widget materialScaffold() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getCurrentTime(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget cupertinoScaffold() {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            backgroundColor: Colors.transparent,
            largeTitle: Text('Main Page'),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    getCurrentTime(),
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navLargeTitleTextStyle,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
