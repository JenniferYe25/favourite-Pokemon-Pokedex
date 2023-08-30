import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Food Weight(grams)'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChartLine(title: 'Fat', number: 1800, rate: 1),
                ChartLine(title: 'Protein', number: 600, rate: 0.4)
              ],
            ),
          ),
          _title('Ratios'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChartLine(
                  number: 10,
                  title: 'Calculum/Phosporous ratio = 2:1',
                  rate: 0.5,
                ),
                ChartLine(
                  number: 20,
                  title: 'Omega3/6 ratio = 1:4',
                  rate: 0.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4),
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ChartLine extends StatelessWidget {
  const ChartLine({
    Key? key,
    required this.rate,
    required this.title,
    required this.number,
  })  : assert(title != null),
        assert(rate != null),
        assert(rate > 0),
        assert(rate <= 1),
        super(key: key);

  final double rate;
  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final lineWidget = constraints.maxWidth * rate;
      print("max width: ${constraints.maxWidth}");
      print("linewidth for $rate: $lineWidget");
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: lineWidget),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    if (number != null)
                      Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              // color: Colors.blue,
              height: 30,
              width: lineWidget,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue, width: 0),
                  borderRadius: BorderRadius.all(
                      Radius.elliptical(lineWidget, lineWidget))),
            )
          ],
        ),
      );
    });
  }
}
