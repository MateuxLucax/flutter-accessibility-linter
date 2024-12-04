import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accessibility Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Accessibility Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // expect_lint: avoid_image_without_semantic_label
            Image.network(
              'https://http.cat/images/102.jpg',
            ),
            SizedBox(
              width: 48,
              height: 48,
              // expect_lint: avoid_icon_button_without_tooltip
              child: IconButton(
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  debugPrint('Pressed');
                },
                // expect_lint: avoid_icon_without_semantic_label
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
            SizedBox(
              height: 48,
              width: 256,
              // expect_lint: add_haptic_feedback_on_user_interaction
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('test');
                },
                child: Text('test'),
              ),
            ),
          ],
        ),
      ),
      // expect_lint: avoid_small_interactive_elements
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        // expect_lint: avoid_icon_without_semantic_label
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
