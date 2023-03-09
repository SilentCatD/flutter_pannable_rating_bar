# Release Notes

### 2.7.1

* Update: changing impl of internal `ShaderMask` drawing to single color.

### 2.7.0

* New feature: `GestureType.DragOnly` added, allow further gesture filtering.

### 2.6.0

* New feature: `RatingValueTransformer` added, allow transforming rating values.

## 2.5.2+1

* Files: remove `assets` file in publishing.

## 2.5.2

* Update: Add `assert(debugHandleEvent(...))` in the `handleEvent` function according to docs

## 2.5.1+2

* Files: remove `assets` file in publishing.

## 2.5.1+1

* Optimization: reduce library size by ignore `assets` folder.

## 2.5.1

* Update: Remove unused variable `visibleForTracking`.
* Update: Mark `calcPercent` function `protected`.
* Documentation: Added more examples and formatted the `example` file.

## 2.5.0+1

* Documentation: Change package description to fit with pub.dev standard.

## 2.5.0

* New feature: Added `onCompleted` callback, which will reports the rating value at the position
  which user stop contacting the device.

## 2.4.1+1

* Documentation: Fix documentation typo in README.

## 2.4.1

* Update: changing internal implementation of calculate indexes of children.

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