import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Configuration for widget used as a rate widget.
class RatingWidget {
  const RatingWidget({
    this.selectedColor = Colors.yellow,
    this.unSelectedColor,
    required this.child,
  });

  /// The widget to be used as a rate widget, [selectedColor] and
  /// [unSelectedColor] will be draw on this. The widget can be of any size,
  /// shape, type,... and different [RatingWidget] do NOT have to be similar
  /// in any of the above aspects.
  final Widget child;

  /// Color that will be draw on [child] to indicate the portion of current
  /// selection, default to [Colors.yellow].
  final Color selectedColor;

  /// Color that will be draw on [child], but bellow [selectedColor] to indicate
  /// the not-selected portion. Set this value to null to skip the drawing of
  /// background color filter layer, default to null.
  final Color? unSelectedColor;
}

/// Signature for function that return a [RatingWidget], used in
/// [PannableRatingBar.builder]
typedef IndexedRatingWidgetBuilder = RatingWidget Function(BuildContext, int);

/// A rating bar widget that support both tap and pan (drag) event, any value
/// for [PannableRatingBar.rate] is supported, it's NOT limited
/// to half or full only, the value will be correctly distributed to
/// [RatingWidget.child] each respectively.
///
/// The widget itself is completely stateless and will report it's value through
/// [PannableRatingBar.onChanged] callback. The reported value can be processed
/// anyway one want.
///
/// This widget support all property of the Flutter's [Wrap] widget, in fact,
/// it use [Wrap] to laid out it's children, for more information about each
/// of these property, refer to documentation of [Wrap].
/// This widget will also take [Wrap.textDirection] and [Wrap.verticalDirection]
/// into consideration when perform drawing.
class PannableRatingBar extends StatelessWidget {
  /// Create a [PannableRatingBar] widget, one must provide a list of
  /// [RatingWidget] to be used as children. If many of the items is similar,
  /// the use of [PannableRatingBar.builder] should be considered.
  /// Items provided do not have to be the same, each can have different size,
  /// shape,...
  const PannableRatingBar({
    Key? key,
    required this.rate,
    required List<RatingWidget> items,
    this.onChanged,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.spacing = 0,
    this.runAlignment = WrapAlignment.center,
    this.runSpacing = 0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.enablePixelsCompensation = true,
  })  : _useItemBuilder = false,
        _items = items,
        _itemCount = items.length,
        _itemBuilder = null,
        super(key: key);

  /// Create the [PannableRatingBar] widget with builder function,
  /// items returned from this function do not have to be the same, each can
  /// have different size, shape,...
  const PannableRatingBar.builder({
    Key? key,
    required this.rate,
    required IndexedRatingWidgetBuilder itemBuilder,
    required int itemCount,
    this.onChanged,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.spacing = 0,
    this.runAlignment = WrapAlignment.center,
    this.runSpacing = 0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.enablePixelsCompensation = true,
  })  : _useItemBuilder = true,
        _items = null,
        _itemCount = itemCount,
        _itemBuilder = itemBuilder,
        super(key: key);

  /// The current rating value of this widget, which will be correctly
  /// distributed for all [RatingWidget.child] children.
  final double rate;

  /// The callback each time there's new value of rate to be received.
  /// Note that this itself only reporting the next value, to actually change
  /// the visual of this widget, please rebuild with new [rate] value.
  final ValueChanged<double>? onChanged;

  /// See this issue: https://github.com/flutter/flutter/issues/98464
  /// So until they fixed it, all child widget will have a margin of 1px when
  /// this flag is true.
  final bool enablePixelsCompensation;

  // [Wrap] properties, please do see the document of the Flutter [Wrap] widget
  // to learn more about these.
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;

  // private property used to store data needed of each constructor respectively
  final bool _useItemBuilder;
  final List<RatingWidget>? _items;
  final IndexedRatingWidgetBuilder? _itemBuilder;
  final int _itemCount;

  double calcPercent(int index, double rate) {
    if (index < rate.floor()) {
      return 1;
    }
    if (index >= rate) {
      return 0;
    }
    return (rate - rate.floor()).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final List<_RateItem> children = [];
    for (var i = 0; i < _itemCount; i++) {
      RatingWidget config;
      if (_useItemBuilder) {
        config = _itemBuilder!.call(context, i);
      } else {
        config = _items![i];
      }
      Widget child = config.child;
      if (enablePixelsCompensation) {
        child = Container(
          margin: const EdgeInsets.all(1),
          child: child,
        );
      }
      children.add(_RateItem(
        key: ValueKey<int>(i),
        percent: calcPercent(i, rate),
        selectedColor: config.selectedColor,
        unSelectedColor: config.unSelectedColor,
        axis: direction,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        child: child,
      ));
    }
    return _PannableWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      onChanged: onChanged,
      children: children,
    );
  }
}

class _PannableWrap extends Wrap {
  _PannableWrap({
    required Axis direction,
    required WrapAlignment alignment,
    required double spacing,
    required WrapAlignment runAlignment,
    required double runSpacing,
    required WrapCrossAlignment crossAxisAlignment,
    required TextDirection? textDirection,
    required VerticalDirection verticalDirection,
    required Clip clipBehavior,
    required List<Widget> children,
    required this.onChanged,
  }) : super(
          direction: direction,
          alignment: alignment,
          spacing: spacing,
          runAlignment: runAlignment,
          runSpacing: runSpacing,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          clipBehavior: clipBehavior,
          children: children,
        );
  final ValueChanged<double>? onChanged;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return _RenderPannableWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      onChanged: onChanged,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderPannableWrap renderObject) {
    renderObject
      ..direction = direction
      ..alignment = alignment
      ..spacing = spacing
      ..runAlignment = runAlignment
      ..runSpacing = runSpacing
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..verticalDirection = verticalDirection
      ..clipBehavior = clipBehavior
      ..onChanged = onChanged;
  }
}

class _RenderPannableWrap extends RenderWrap {
  _RenderPannableWrap({
    List<RenderBox>? children,
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
    this.onChanged,
  }) : super(
          children: children,
          direction: direction,
          alignment: alignment,
          spacing: spacing,
          runAlignment: runAlignment,
          runSpacing: runSpacing,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          clipBehavior: clipBehavior,
        ) {
    final team = GestureArenaTeam();
    _tap = TapGestureRecognizer(debugOwner: this);
    _tap
      ..team = team
      ..onTapDown = (details) {
        _onChange(details.localPosition);
      };
    _drag = PanGestureRecognizer(debugOwner: this)
      ..team = team
      ..onStart = (details) {
        _onChange(details.localPosition);
      }
      ..onUpdate = (details) {
        _onChange(details.localPosition);
      };
  }

  ValueChanged<double>? onChanged;

  late final TapGestureRecognizer _tap;
  late final PanGestureRecognizer _drag;

  void _onChange(Offset position) {
    _RenderRateItem? child = firstChild as _RenderRateItem?;
    final result = BoxHitTestResult();
    int childIndex = 0;
    double? percent;
    while (child != null) {
      final WrapParentData childParentData =
          child.parentData! as WrapParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          final isHit = child!.hitTest(result, position: transformed);
          if (isHit) {
            percent = child._percentHitTest(position: transformed);
          }
          return isHit;
        },
      );
      if (isHit && percent != null) {
        final rounded =
            double.parse((childIndex + percent!).toStringAsFixed(1));
        onChanged?.call(rounded);
        break;
      }
      childIndex += 1;
      child = childParentData.nextSibling as _RenderRateItem?;
    }
  }

  @override
  void handleEvent(
      PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    if (event is PointerDownEvent && onChanged != null) {
      _drag.addPointer(event);
      _tap.addPointer(event);
    }
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();
    super.dispose();
  }
}

class _RateItem extends SingleChildRenderObjectWidget {
  const _RateItem({
    Key? key,
    required Widget child,
    required this.percent,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.axis,
    this.textDirection,
    required this.verticalDirection,
  })  : assert(percent >= 0 && percent <= 1),
        super(
          key: key,
          child: child,
        );
  final Color selectedColor;
  final Color? unSelectedColor;
  final double percent;
  final Axis axis;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderRateItem(
      selectedColor: selectedColor,
      unSelectedColor: unSelectedColor,
      percent: percent,
      axis: axis,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      verticalDirection: verticalDirection,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderRateItem renderObject) {
    renderObject
      ..percent = percent
      ..selectedColor = selectedColor
      ..unSelectedColor = unSelectedColor
      ..axis = axis
      ..verticalDirection = verticalDirection
      ..textDirection = textDirection ?? Directionality.maybeOf(context);
  }
}

class _RenderRateItem extends RenderProxyBox {
  _RenderRateItem({
    required Color selectedColor,
    required Color? unSelectedColor,
    required double percent,
    required Axis axis,
    required TextDirection? textDirection,
    required VerticalDirection verticalDirection,
  })  : _selectedColor = selectedColor,
        _unSelectedColor = unSelectedColor,
        _percent = percent,
        _axis = axis,
        _textDirection = textDirection,
        _verticalDirection = verticalDirection;

  VerticalDirection _verticalDirection;

  VerticalDirection get verticalDirection => _verticalDirection;

  set verticalDirection(VerticalDirection value) {
    if (value != _verticalDirection) {
      _verticalDirection = value;
      markNeedsPaint();
    }
  }

  TextDirection? _textDirection;

  TextDirection? get textDirection => _textDirection;

  set textDirection(TextDirection? value) {
    if (value != _textDirection) {
      _textDirection = value;
      markNeedsPaint();
    }
  }

  Axis _axis;

  Axis get axis => _axis;

  set axis(Axis value) {
    if (_axis != value) {
      _axis = value;
      markNeedsPaint();
    }
  }

  Color _selectedColor;

  Color get selectedColor => _selectedColor;

  set selectedColor(Color value) {
    if (_selectedColor != value) {
      _selectedColor = value;
      markNeedsPaint();
    }
  }

  Color? _unSelectedColor;

  Color? get unSelectedColor => _unSelectedColor;

  set unSelectedColor(Color? value) {
    if (value != _unSelectedColor) {
      _unSelectedColor = value;
      markNeedsPaint();
    }
  }

  double _percent;

  double get percent => _percent;

  set percent(double value) {
    if (_percent != value) {
      _percent = value;
      markNeedsPaint();
    }
  }

  double? _percentHitTest({required Offset position}) {
    if (size.contains(position)) {
      double result;
      switch (axis) {
        case Axis.horizontal:
          result = position.dx / size.width;
          if (textDirection == TextDirection.rtl) {
            result = 1 - result;
          }
          break;
        case Axis.vertical:
          result = position.dy / size.height;
          if (verticalDirection == VerticalDirection.up) {
            result = 1 - result;
          }
          break;
      }
      return result;
    }
    return null;
  }

  void _paintBackground(PaintingContext context, Offset offset,
      PaintingContextCallback paintChild) {
    assert(unSelectedColor != null);
    _backgroundHandle.layer ??= ColorFilterLayer();
    _backgroundHandle.layer!.colorFilter = ColorFilter.mode(
      unSelectedColor!,
      BlendMode.srcATop,
    );

    context.pushLayer(_backgroundHandle.layer!, paintChild, offset);
  }

  void _paintForeground(PaintingContext context, Offset offset,
      PaintingContextCallback paintChild) {
    double width = 0.0;
    double height = 0.0;
    if (axis == Axis.horizontal) {
      width = size.width * percent;
      height = size.height;
    } else {
      width = size.width;
      height = size.height * percent;
    }
    final maskSize = Size(
      width,
      height,
    );

    Rect maskRect = offset & maskSize;
    if (textDirection == TextDirection.rtl && axis == Axis.horizontal) {
      maskRect = maskRect.shift(Offset(size.width - maskRect.width, 0));
    } else if (verticalDirection == VerticalDirection.up &&
        axis == Axis.vertical) {
      maskRect = maskRect.shift(Offset(0, size.height - maskRect.height));
    }

    _foregroundHandle.layer ??= ShaderMaskLayer();
    _foregroundHandle.layer!
      ..shader = LinearGradient(
              tileMode: TileMode.decal, colors: [selectedColor, selectedColor])
          .createShader(Offset.zero & maskSize)
      ..maskRect = maskRect
      ..blendMode = BlendMode.srcATop;
    context.pushLayer(_foregroundHandle.layer!, paintChild, offset);
  }

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  void dispose() {
    _backgroundHandle.layer = null;
    _foregroundHandle.layer = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(child != null);
    assert(needsCompositing);
    if (unSelectedColor != null) {
      _paintForeground(context, offset, (context, offset) {
        _paintBackground(context, offset, super.paint);
      });
    } else {
      _backgroundHandle.layer = null;
      _paintForeground(context, offset, super.paint);
    }
  }

  final LayerHandle<ColorFilterLayer> _backgroundHandle =
      LayerHandle<ColorFilterLayer>();
  final LayerHandle<ShaderMaskLayer> _foregroundHandle =
      LayerHandle<ShaderMaskLayer>();
}
