## 2.1.0

* Edit the README.md code snippets, make the use of this widget more comprehensible.
* Remove constraint of the `rate` value. Now this value can be set as negative or bigger than
  itemCount.
* Add support for `Wrap` properties: `textDirection` and `verticleDirection`. The widget will now
  paint indicators correctly and take these 2 properties into consideration.
* Remove Non-nullable constraint of `RatingWidget.unSelectedColor`, this properties is now nullable,
  and if it is, then the background painting will be skipped. Otherwise, implementation of the
  drawing has changed from ShaderMask to ColorFilter.

## 2.0.1

* add params for pixels compensation, see this
  issue: https://github.com/flutter/flutter/issues/98464

## 2.0.0

* BREAKING CHANGES!
* Support customize each rating widget.
* Support builder constructor.

## 1.0.0

* Release

## 0.0.1

* Prepare for release
