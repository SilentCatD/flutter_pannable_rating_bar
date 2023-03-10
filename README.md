[![pub package](https://img.shields.io/pub/v/flutter_pannable_rating_bar?color=green&include_prereleases&style=plastic)](https://pub.dev/packages/flutter_pannable_rating_bar)

# PannableRatingBar

Introducing a new and improved rating bar for Flutter, offering versatility and full customization. 
Unlike other rating bars, this one allows for any value to be selected, not just full or half 
ratings when interacted. Tap, drag and hover gestures are seamlessly supported, providing a smooth 
user experience.

## Features
* Offers fractional values for rating
* High degree of customization for the rating widgets, which can be of different sizes, shapes, and colors.
* Precise hit testing, as the child widget's render object is utilized to determine the results.
* Allows for filtering gestures with either `tapOnly`, `dragOnly` or `tapAndDrag` options.
* Rating reports on cursor hovering supported.
* Built on Flutter's `Wrap` widget, offering a variety of supported layouts, including consideration 
of `Wrap` properties such as `textDirection` and `verticalDirection` when painting the indicators.

## Getting started

First import the widget

```dart
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
```

## Usage

This widget is stateless and highly flexible, allowing you to easily manipulate values and 
customize the display of the `PannableRatingBar`. Simply rebuild the widget with the value provided 
in the `onChanged` callback or `onHover` callback and the widget will automatically adjust the 
rating distribution across each rating widget.

<img src="https://github.com/SilentCatD/flutter_pannable_rating_bar/blob/main/assets/basics.gif?raw=true" width="200px">

```dart
double rating = 0.0;

PannableRatingBar(
  rate: rating,
  items: List.generate(5, (index) =>
    const RatingWidget(
      selectedColor: Colors.yellow,
      unSelectedColor: Colors.grey,
      child: Icon(
        Icons.star,
        size: 48,
      ),
    )),
  onChanged: (value) { // the rating value is updated on tap or drag.
    setState(() {
      rating = value;
    });
  },
)
```

The widget also supports getting the rate value by hovering with the `onHover` callback. It works 
best on devices that support a mouse cursor, including desktop web browsers.

```dart
double rating = 0.0;

PannableRatingBar(
  rate: rating,
  items: List.generate(5, (index) =>
    const RatingWidget(
      selectedColor: Colors.yellow,
      unSelectedColor: Colors.grey,
      child: Icon(
        Icons.star,
        size: 48,
      ),
    )),
  onHover: (value) { // the rating value is updated every time the cursor moves over a new item.
    setState(() {
      rating = value;
    });
  },
)
```


Utilize your own custom widgets as the rating indicators. With complete customization freedom, they 
don't have to be uniform in size, color, or any other aspect.

<img src="https://github.com/SilentCatD/flutter_pannable_rating_bar/blob/main/assets/crazy.gif?raw=true" width="200px">

```dart
double rating = 0.0;

PannableRatingBar(
  rate: rating,
  onChanged: (value) {
    setState(() {
      rating = value;
    });
  },
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
)
```

<img src="https://github.com/SilentCatD/flutter_pannable_rating_bar/blob/main/assets/variety.gif?raw=true" width="200px">

```dart
double rating = 0;
PannableRatingBar(
  rate: rating,
  onChanged: (value){
    setState((){
      rating = value;
    });
  },
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
```


This widget utilizes the layout capabilities of Flutter's built-in `Wrap` widget, allowing for a wide 
range of possible layouts to be achieved. The properties of the `Wrap` widget, such as `textDirection` 
and `verticalDirection`, are also considered when painting the indicators, giving you even greater 
control over the final look and feel of the rating bar.

<img src="https://github.com/SilentCatD/flutter_pannable_rating_bar/blob/main/assets/builder.gif?raw=true" width="200px">

```dart
double rating = 0.0;

PannableRatingBar.builder(
  rate: rating,
  alignment: WrapAlignment.center,
  spacing: 20,
  runSpacing: 10,
  itemCount: 20,
  direction: Axis.vertical,
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
  onChanged: (value) {
    setState(() {
      rating = value;
    });
  },
)
```

Customize the appearance of the rating indicators based on their values.

<img src="https://github.com/SilentCatD/flutter_pannable_rating_bar/blob/main/assets/animation.gif?raw=true" width="200px">

```dart
double rating = 0;

PannableRatingBar(
    rate: rating,
    spacing: 20,
    onChanged: (value){
      setState((){
        rating = value;
      });
    },
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
```

For ease of transforming / mutating rating values, the library support using functions to do as such,
used as a parameter in `PannableRatingBar`.

Return null from this will cause the current rating value skipped in all callbacks.
```dart
typedef RatingValueTransformer = double? Function(double value);
```
Some of the pre-built `RatingValueTransformer`s available are:

```dart
// Rounding to nearest single fractional digit. This is also the default one that 
// `PannableRatingBar` used.
double singleFractionalValueTransformer(double value);
```

```dart
// Rounding to nearest .5.
double halfFractionalValueTransformer(double value);
```

```dart
// Leave the rating as is.
double rawValueTransformer(double value);
```

## Additional information

For more, checkout and play with the example file.
If you have any suggestions for improvement, simply create an issue in the repository!

