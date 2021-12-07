import 'dart:math';
import 'dart:ui' as ui show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A rectangular border with rounded top corners and drag marker.
///
/// Typically used with [ModalBottomSheet] to draw container box.
///
/// This shape can interpolate to and from [CircleBorder].
///
/// Created by Roman Donchenko ;)
///
class BottomSheetBorder extends OutlinedBorder {
  /// Creates a rounded rectangle border.
  ///
  /// The arguments must not be null.
  const BottomSheetBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    this.tickWidth = 40.0,
    this.tickHeight = 4.0,
    this.tickPadding = 16.0,
    this.tickRadius = const Radius.circular(4.0),
    this.tickColor = const Color(0xFFA0AEC0),
  }) : super(side: side);

  final double tickWidth;
  final double tickHeight;
  final double tickPadding;
  final Radius tickRadius;
  final Color tickColor;

  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return BottomSheetBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
      tickWidth: tickWidth,
      tickHeight: tickHeight,
      tickPadding: tickPadding,
      tickRadius: tickRadius,
      tickColor: tickColor,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is BottomSheetBorder) {
      return BottomSheetBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
      );
    }
    if (a is CircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: borderRadius,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: 1.0 - t,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is BottomSheetBorder) {
      return BottomSheetBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
      );
    }
    if (b is CircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: borderRadius,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: t,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Returns a copy of this BottomSheetBorder with the given fields
  /// replaced with the new values.
  @override
  BottomSheetBorder copyWith({BorderSide? side, BorderRadius? borderRadius}) {
    return BottomSheetBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      tickWidth: tickWidth,
      tickHeight: tickHeight,
      tickPadding: tickPadding,
      tickRadius: tickRadius,
      tickColor: tickColor,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect),
              side.toPaint());
        } else {
          final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }
    _drawTick(canvas, rect);
  }

  void _drawTick(Canvas canvas, Rect rect) {
    final width = min(rect.width - 16.0, tickWidth);
    final height = min(rect.height - tickPadding, tickHeight);
    if (width < 2.0 || height < 1.0) {
      return; // too small
    }

    final halfWidth = width / 2.0;

    final topCenter = rect.topCenter.dx;
    final tickRect = RRect.fromLTRBR(
      topCenter - halfWidth, //left
      rect.top + tickPadding, //top
      topCenter + halfWidth, //right
      rect.top + tickPadding + height, //bottom
      tickRadius,
    );
    final tickPaint = Paint()
      ..color = tickColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(tickRect, tickPaint);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is BottomSheetBorder &&
        other.side == side &&
        other.tickWidth == tickWidth &&
        other.tickHeight == tickHeight &&
        other.tickPadding == tickPadding &&
        other.tickRadius == tickRadius &&
        other.tickColor == tickColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius, tickHeight, tickWidth,
      tickPadding, tickRadius, tickColor);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'BottomSheetBorder')}($side, $borderRadius)';
  }
}

class _RoundedRectangleToCircleBorder extends OutlinedBorder {
  const _RoundedRectangleToCircleBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    required this.tickWidth,
    required this.tickHeight,
    required this.tickPadding,
    required this.tickRadius,
    required this.tickColor,
    required this.circleness,
  }) : super(side: side);

  final double tickWidth;
  final double tickHeight;
  final double tickPadding;
  final Radius tickRadius;
  final Color tickColor;

  final BorderRadiusGeometry borderRadius;

  final double circleness;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return _RoundedRectangleToCircleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
      tickWidth: tickWidth,
      tickHeight: tickHeight,
      tickPadding: tickPadding,
      tickRadius: tickRadius,
      tickColor: tickColor,
      circleness: t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is BottomSheetBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: circleness * t,
      );
    }
    if (a is CircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: borderRadius,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: circleness + (1.0 - circleness) * (1.0 - t),
      );
    }
    if (a is _RoundedRectangleToCircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: ui.lerpDouble(a.circleness, circleness, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is BottomSheetBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: circleness * (1.0 - t),
      );
    }
    if (b is CircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: borderRadius,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: circleness + (1.0 - circleness) * t,
      );
    }
    if (b is _RoundedRectangleToCircleBorder) {
      return _RoundedRectangleToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
        BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        tickWidth: tickWidth,
        tickHeight: tickHeight,
        tickPadding: tickPadding,
        tickRadius: tickRadius,
        tickColor: tickColor,
        circleness: ui.lerpDouble(circleness, b.circleness, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  Rect _adjustRect(Rect rect) {
    if (circleness == 0.0 || rect.width == rect.height) return rect;
    if (rect.width < rect.height) {
      final double delta = circleness * (rect.height - rect.width) / 2.0;
      return Rect.fromLTRB(
        rect.left,
        rect.top + delta,
        rect.right,
        rect.bottom - delta,
      );
    } else {
      final double delta = circleness * (rect.width - rect.height) / 2.0;
      return Rect.fromLTRB(
        rect.left + delta,
        rect.top,
        rect.right - delta,
        rect.bottom,
      );
    }
  }

  BorderRadius _adjustBorderRadius(Rect rect, TextDirection? textDirection) {
    final BorderRadius resolvedRadius = borderRadius.resolve(textDirection);
    if (circleness == 0.0) return resolvedRadius;
    return BorderRadius.lerp(resolvedRadius,
        BorderRadius.circular(rect.shortestSide / 2.0), circleness)!;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(_adjustBorderRadius(rect, textDirection)
          .toRRect(_adjustRect(rect))
          .deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
          _adjustBorderRadius(rect, textDirection).toRRect(_adjustRect(rect)));
  }

  @override
  _RoundedRectangleToCircleBorder copyWith(
      {BorderSide? side, BorderRadius? borderRadius, double? circleness}) {
    return _RoundedRectangleToCircleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      tickWidth: tickWidth,
      tickHeight: tickHeight,
      tickPadding: tickPadding,
      tickRadius: tickRadius,
      tickColor: tickColor,
      circleness: circleness ?? this.circleness,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(
              _adjustBorderRadius(rect, textDirection)
                  .toRRect(_adjustRect(rect)),
              side.toPaint());
        } else {
          final RRect outer = _adjustBorderRadius(rect, textDirection)
              .toRRect(_adjustRect(rect));
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }
    _drawTick(canvas, rect);
  }

  void _drawTick(Canvas canvas, Rect rect) {
    final width = min(rect.width - 16.0, tickWidth);
    final height = min(rect.height - tickPadding, tickHeight);
    if (width < 2.0 || height < 1.0) return; // too small

    final halfWidth = width / 2.0;

    final topCenter = rect.topCenter.dx;
    final tickRect = RRect.fromLTRBR(
      topCenter - halfWidth, //left
      rect.top + tickPadding, //top
      topCenter + halfWidth, //right
      rect.top + tickPadding + height, //bottom
      tickRadius,
    );
    final tickPaint = Paint()
      ..color = tickColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(tickRect, tickPaint);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _RoundedRectangleToCircleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.tickWidth == tickWidth &&
        other.tickHeight == tickHeight &&
        other.tickPadding == tickPadding &&
        other.tickRadius == tickRadius &&
        other.tickColor == tickColor &&
        other.circleness == circleness;
  }

  @override
  int get hashCode => hashValues(side, borderRadius, circleness, tickHeight,
      tickWidth, tickPadding, tickRadius, tickColor);

  @override
  String toString() {
    return 'BottomSheetBorder($side, $borderRadius, ${(circleness * 100).toStringAsFixed(1)}% of the way to being a CircleBorder)';
  }
}
