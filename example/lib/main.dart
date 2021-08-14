import 'package:flutter/material.dart';
import 'package:overlay_builder/overlay_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overlay Builder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _overlayWidget = GlobalKey<OverlayWidgetState>();
  final _overlayFullscreen = GlobalKey<OverlayWidgetState>();

  OverlayWidgetState get overlayWidgetController {
    return _overlayWidget.currentState!;
  }

  OverlayWidgetState get overlayFullscreenController {
    return _overlayFullscreen.currentState!;
  }

  void onTap() {
    overlayWidgetController.toggle();
    overlayFullscreenController.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Builder Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OverlayWidget(
              key: _overlayWidget,
              child: const Text('Overlay Builder Demo'),
              overlayChild: const Material(
                type: MaterialType.transparency,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OverlayFullscreen(
        key: _overlayFullscreen,
        child: FloatingActionButton(
          onPressed: onTap,
          tooltip: 'Show Overlay',
          child: const Icon(Icons.zoom_out_map),
        ),
        overlayChild: const Material(
          type: MaterialType.transparency,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
