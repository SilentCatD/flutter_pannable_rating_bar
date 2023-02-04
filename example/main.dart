import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

/// For the [onHover] example, view on Web or desktop related device for best
/// experiences.

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: "Basics",
              ),
              Tab(
                text: "Variety",
              ),
              Tab(
                text: "Customized",
              ),
              Tab(
                text: "Multiple",
              ),
              Tab(
                text: "Animation",
              ),
              Tab(
                text: "Hover",
              )
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            BasicExample(),
            VarietyExample(),
            CustomizedExample(),
            MultipleExample(),
            AnimatedExample(),
            HoverExample(),
          ],
        ),
      ),
    );
  }
}

class BasicExample extends StatefulWidget {
  const BasicExample({Key? key}) : super(key: key);

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  double rating = 0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$rating',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 10,
          ),
          PannableRatingBar(
            rate: rating,
            onChanged: updateRating,
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
    );
  }
}

class VarietyExample extends StatefulWidget {
  const VarietyExample({Key? key}) : super(key: key);

  @override
  State<VarietyExample> createState() => _VarietyExampleState();
}

class _VarietyExampleState extends State<VarietyExample> {
  double rating = 0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$rating',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            PannableRatingBar(
              rate: rating,
              onChanged: updateRating,
              spacing: 20,
              items: const [
                RatingWidget(
                  selectedColor: Colors.blue,
                  child: Text(
                    "Pannable",
                    style: TextStyle(color: Colors.grey, fontSize: 40),
                  ),
                ),
                RatingWidget(
                  selectedColor: Colors.red,
                  child: Text(
                    "Rating",
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                ),
                RatingWidget(
                  selectedColor: Colors.amber,
                  child: Text(
                    "Bar",
                    style: TextStyle(color: Colors.grey, fontSize: 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomizedExample extends StatefulWidget {
  const CustomizedExample({Key? key}) : super(key: key);

  @override
  State<CustomizedExample> createState() => _CustomizedExampleState();
}

class _CustomizedExampleState extends State<CustomizedExample> {
  double rating = 0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$rating',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 10,
          ),
          PannableRatingBar(
            rate: rating,
            spacing: 20,
            onChanged: updateRating,
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
    );
  }
}

class MultipleExample extends StatefulWidget {
  const MultipleExample({Key? key}) : super(key: key);

  @override
  State<MultipleExample> createState() => _MultipleExampleState();
}

class _MultipleExampleState extends State<MultipleExample> {
  double rating = 0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                '$rating',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: PannableRatingBar.builder(
              rate: rating,
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 10,
              itemCount: 20,
              direction: Axis.vertical,
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.up,
              onChanged: updateRating,
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
    );
  }
}

class AnimatedExample extends StatefulWidget {
  const AnimatedExample({Key? key}) : super(key: key);

  @override
  State<AnimatedExample> createState() => _AnimatedExampleState();
}

class _AnimatedExampleState extends State<AnimatedExample> {
  double rating = 0;

  void updateRating(double value) {
    setState(() {
      rating = double.parse(value.toStringAsFixed(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PannableRatingBar(
            rate: rating,
            spacing: 20,
            onChanged: updateRating,
            items: [
              RatingWidget(
                selectedColor: rating <= 0.5 ? Colors.red : Colors.green,
                unSelectedColor: Colors.grey,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: rating <= 0.5
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
          const SizedBox(
            height: 10,
          ),
          Slider(
            value: rating,
            onChanged: updateRating,
            min: 0,
            max: 1,
          ),
        ],
      ),
    );
  }
}

class HoverExample extends StatefulWidget {
  const HoverExample({Key? key}) : super(key: key);

  @override
  State<HoverExample> createState() => _HoverExampleState();
}

class _HoverExampleState extends State<HoverExample> {
  double rating = 0;
  double ratingSet = 0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  void setRating(double value) {
    setState(() {
      ratingSet = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$ratingSet',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 10,
          ),
          PannableRatingBar(
            rate: rating,
            onChanged: setRating,
            onHover: updateRating,
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
    );
  }
}
