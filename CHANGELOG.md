# Release Notes

## 2.4.0

* New feature: Added `onHover` callback, which will reports the rating value of the current cursor
position.
* Documentation: Adding example for `onHover` use case.

## 2.3.0+2

* Documentation: Changes in package description.

## 2.3.0+1

* Documentation: Small change in README.

## 2.3.0

* New feature: Added ability to filter out gestures - choose between `tapOnly` or `tapAndDrag`.
* New feature: Getter for `itemCount` added. Subclasses of `PannableRatingBar` can now access it.
* Documentation: Most of the docs have been rewritten with GPT under my supervision.

## 2.2.0

* New feature: Added `minRating` and `maxRating` parameters.

## 2.1.2

* Update: `BlendMode` changed to `srcIn` instead of `srcATop`.

## 2.1.1

* Optimization: Skip rate calculation process when `onChanged` callback is null.

## 2.1.0+3

* Documentation: Updated example file.

## 2.1.0+2

* Documentation: Added new gif and more examples.

## 2.1.0+1

* Documentation: Added new gif file and example file.

## 2.1.0

* Documentation: README.md code snippets updated for better comprehension of widget usage.
* Update: Constraint for rate value removed. It can now be set as negative or greater
  than `itemCount`.
* New feature: Support for `Wrap` properties added - `textDirection` and `verticalDirection`. The
  widget now takes these properties into consideration and paints indicators correctly.
* Update: Non-nullable constraint of `RatingWidget.unSelectedColor` removed. It is now nullable, and
  if set to null, background painting will be skipped. The implementation of drawing changed
  from `ShaderMask` to `ColorFilter`.

## 2.0.1

* New feature: Parameter for pixels compensation added. Refer to this
  issue: https://github.com/flutter/flutter/issues/98464.

## 2.0.0

* BREAKING CHANGES!
* New feature: Added support for customizing each rating widget.
* New feature: Added builder constructor support.

## 1.0.0

* Initial release.

## 0.0.1

* Preparation for release.