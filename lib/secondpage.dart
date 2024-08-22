import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final bool isCupertino;
  final VoidCallback toggleDesign;
  const SecondPage(
      {super.key, required this.isCupertino, required this.toggleDesign});

  @override
  Widget build(BuildContext context) {
    return isCupertino ? cupertinoScaffold() : materialScaffold();
  }

  Widget materialScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: toggleDesign,
          child: const Text('Toggle Design'),
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
            largeTitle: Text('Second Page'),
          ),
          SliverFillRemaining(
            child: Center(
              child: CupertinoButton(
                onPressed: toggleDesign,
                child: const Text('Toggle Design'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
