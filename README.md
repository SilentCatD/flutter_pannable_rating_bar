<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Yet another rating bar for Flutter. But this time supported any value, not just full or half.
Tap and drag gestures are all supported.

## Features

* Support any value
* Customizable rating widget
* Make use of Flutters Wrap widget, that mean you can achieve any layout that Wrap supported.

## Getting started

First import the widget

```dart
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
```

## Usage

The widget itself is completely Stateless, that mean you can manipulate any value that the callback
provided and use it as the value for PannableRatingBar.

Just setState with the value provided in onChanged call back, and it will be correctly distributed
for each rate widget respectively.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PannableRatingBar(
          itemCount: 5,
          rate: value,
          spacing: 20,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ),
    ),
  );
}
```

Use your own widget as the rating widget.

```dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PannableRatingBar(
          itemCount: 5,
          rate: value,
          spacing: 20,
          runSpacing: 10,
          rateItem: (context) {
            return const Icon(
              Icons.cabin,
              size: 48,
            );
          },
          selectedColor: Colors.red,
          unSelectedColor: Colors.grey,
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ),
    ),
  );
}
```

This widget itself use Wrap to layout, hence support any layout that can be achieved with Wrap.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PannableRatingBar(
          itemCount: 20,
          rate: value,
          spacing: 20,
          runSpacing: 10,
          selectedColor: Colors.blue,
          unSelectedColor: Colors.amber,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ),
    ),
  );
}
```

## Additional information

Have any idea to improve it? Just raise an issue in the repo!
