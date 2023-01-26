import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Default rating widget widget for [PannableRatingBar.rateItem]
Widget defaultRateItem(BuildContext context) {
  return const Icon(
    Icons.star,
    size: 48,
    color: Colors.grey,
  );
}

/// A rating bar widget that support both tap and pan (drag) event, any value
/// [double] go in [PannableRatingBar.rate] is supported, it's NOT limited
/// to half or full only, the value will be correctly rendered in percentage
/// of [PannableRatingBar.rateItem] each respectively.
///
/// Of course, the [PannableRatingBar.rate] must be within reasonable range (
/// no more than [PannableRatingBar.itemCount])
///
/// The widget itself is completely stateless and will report it's value through
/// [PannableRatingBar.onChanged] callback. The reported value can be processed
/// anyway one want.
///
/// This widget support all property of the Flutter's [Wrap] widget. To see more
/// information about them, refer to documentation of [Wrap].
class PannableRatingBar extends StatelessWidget {
  const PannableRatingBar({
    Key? key,
    required this.itemCount,
    required this.rate,
    this.rateItem = defaultRateItem,
    this.onChanged,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.spacing = 20,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 10,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.unSelectedColor,
    this.selectedColor = Colors.yellow,
  })  : assert(rate >= 0 && rate <= itemCount),
        super(key: key);

  /// Number of item of this widget.
  final int itemCount;

  /// The current rating value of this widget, which will be correctly
  /// distributed for all [rateItem].
  final double rate;

  /// The widget to be used as rate widget, default to [defaultRateItem].
  final WidgetBuilder rateItem;

  /// The callback each time there's new value of rate to be received.
  /// Note that this itself only reporting the next value, to actually change
  /// the visual of this widget, please rebuild with new [rate] value.
  final ValueChanged<double>? onChanged;

  /// The color to be draw on top of [rateItem] when itself is selected.
  final Color selectedColor;

  /// The color to draw on top of all [rateItem], but bellow [selectedColor].
  final Color? unSelectedColor;

  // wrap properties, please do see the document of the Flutter [Wrap] widget
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

  double _calcPercent(int index, double rate) {
    if (index < rate.floor()) {
      return 1;
    }
    if (index >= rate) {
      return 0;
    }
    return rate - rate.floor();
  }

  @override
  Widget build(BuildContext context) {
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
      children: List.generate(
        itemCount,
        (index) => _RateItem(
          axis: direction,
          percent: _calcPercent(index, rate),
          selectedColor: selectedColor,
          unSelectedColor: unSelectedColor ?? Colors.transparent,
          child: rateItem.call(context),
        ),
      ),
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
    if (event is PointerDownEvent) {
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
  })  : assert(percent >= 0 && percent <= 1),
        super(
          key: key,
          child: child,
        );
  final Color selectedColor;
  final Color unSelectedColor;
  final double percent;
  final Axis axis;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderRateItem(
      selectedColor: selectedColor,
      unSelectedColor: unSelectedColor,
      percent: percent,
      axis: axis,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderRateItem renderObject) {
    renderObject
      ..percent = percent
      ..selectedColor = selectedColor
      ..unSelectedColor = unSelectedColor
      ..axis = axis;
  }
}

class _RenderRateItem extends RenderProxyBox {
  _RenderRateItem({
    required Color selectedColor,
    required Color unSelectedColor,
    required double percent,
    required Axis axis,
  })  : _selectedColor = selectedColor,
        _unSelectedColor = unSelectedColor,
        _percent = percent,
        _axis = axis;

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

  Color _unSelectedColor;

  Color get unSelectedColor => _unSelectedColor;

  set unSelectedColor(Color value) {
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

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => true;

  void _paintChild(PaintingContext context, Offset offset) {
    assert(child != null);
    context.paintChild(child!, offset);
  }

  void paintBackground(PaintingContext context, Offset offset,
      PaintingContextCallback paintChild) {
    _backgroundHandle.layer ??= ShaderMaskLayer();
    _backgroundHandle.layer!
      ..shader = LinearGradient(
              tileMode: TileMode.decal,
              colors: [unSelectedColor, unSelectedColor])
          .createShader(Offset.zero & size)
      ..maskRect = offset & Size(size.width, size.height)
      ..blendMode = BlendMode.srcATop;

    context.pushLayer(_backgroundHandle.layer!, paintChild, offset);
  }

  void paintForeground(PaintingContext context, Offset offset,
      PaintingContextCallback paintChild) {
    final maskSize = Size(
      size.width * (axis == Axis.horizontal ? percent : 1),
      size.height * (axis == Axis.vertical ? percent : 1),
    );

    _foregroundHandle.layer ??= ShaderMaskLayer();
    _foregroundHandle.layer!
      ..shader = LinearGradient(
              tileMode: TileMode.decal, colors: [selectedColor, selectedColor])
          .createShader(Offset.zero & maskSize)
      ..maskRect = offset & maskSize
      ..blendMode = BlendMode.srcATop;
    context.pushLayer(_foregroundHandle.layer!, paintChild, offset);
  }

  @override
  void dispose() {
    _backgroundHandle.layer = null;
    _foregroundHandle.layer = null;
    super.dispose();
  }

  double _percentHitTest({required Offset position}) {
    if (size.contains(position)) {
      switch (axis) {
        case Axis.horizontal:
          return position.dx / size.width;
        case Axis.vertical:
          return position.dy / size.height;
      }
    }
    return 0;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(child != null);
    assert(needsCompositing);
    paintForeground(context, offset, (context, offset) {
      paintBackground(context, offset, _paintChild);
    });
  }

  final LayerHandle<ShaderMaskLayer> _backgroundHandle =
      LayerHandle<ShaderMaskLayer>();
  final LayerHandle<ShaderMaskLayer> _foregroundHandle =
      LayerHandle<ShaderMaskLayer>();
}
