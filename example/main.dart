import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double rating1 = 0;
  double rating2 = 0;
  double rating3 = 0;
  double rating4 = 0;

  void updateRating1(double value) {
    setState(() {
      rating1 = value;
    });
  }

  void updateRating2(double value) {
    setState(() {
      rating2 = value;
    });
  }

  void updateRating3(double value) {
    setState(() {
      rating3 = value;
    });
  }

  void updateRating4(double value) {
    setState(() {
      rating4 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Basics",
              ),
              Tab(
                text: "Customized",
              ),
              Tab(
                text: "Multiple",
              ),
              Tab(
                text: "Animation",
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$rating1',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PannableRatingBar(
                    rate: rating1,
                    onChanged: updateRating1,
                    spacing: 20,
                    items: List.generate(
                      5,
                      (index) => const RatingWidget(
                        selectedColor: Colors.yellow,
                        unSelectedColor: Colors.grey,
                        child: Icon(
                          Icons.star,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$rating2',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PannableRatingBar(
                    rate: rating2,
                    spacing: 20,
                    onChanged: updateRating2,
                    items: const [
                      RatingWidget(
                        selectedColor: Colors.yellow,
                        unSelectedColor: Colors.grey,
                        child: Icon(
                          Icons.star,
                          size: 48,
                        ),
                      ),
                      RatingWidget(
                        selectedColor: Colors.blue,
                        unSelectedColor: Colors.red,
                        child: Icon(
                          Icons.ac_unit,
                          size: 48,
                        ),
                      ),
                      RatingWidget(
                        selectedColor: Colors.purple,
                        unSelectedColor: Colors.amber,
                        child: Icon(
                          Icons.access_time_filled,
                          size: 48,
                        ),
                      ),
                      RatingWidget(
                        selectedColor: Colors.cyanAccent,
                        unSelectedColor: Colors.grey,
                        child: Icon(
                          Icons.abc,
                          size: 48,
                        ),
                      ),
                      RatingWidget(
                        selectedColor: Colors.tealAccent,
                        unSelectedColor: Colors.purple,
                        child: Icon(
                          Icons.accessibility_new_sharp,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        '$rating3',
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PannableRatingBar.builder(
                      rate: rating3,
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 10,
                      itemCount: 20,
                      direction: Axis.vertical,
                      onChanged: updateRating3,
                      itemBuilder: (context, index) {
                        return const RatingWidget(
                          selectedColor: Colors.yellow,
                          unSelectedColor: Colors.grey,
                          child: Icon(
                            Icons.star,
                            size: 48,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: PannableRatingBar(
                rate: rating4,
                spacing: 20,
                onChanged: updateRating4,
                items: [
                  RatingWidget(
                    selectedColor: rating4 <= 0.5 ? Colors.red : Colors.green,
                    unSelectedColor: Colors.grey,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: rating4 <= 0.5
                          ? const Icon(
                              Icons.sentiment_very_dissatisfied,
                              key: ValueKey("sad"),
                              size: 100,
                            )
                          : const Icon(
                              Icons.sentiment_satisfied,
                              key: ValueKey("happy"),
                              size: 100,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
