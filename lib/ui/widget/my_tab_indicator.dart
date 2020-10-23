// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// Used with [TabBar.indicator] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [borderSide] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabBarIndicatorSize.label],
/// or the entire tab with [TabBarIndicatorSize.tab].
class FloatingLineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const FloatingLineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  }) : assert(borderSide != null),
       assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the tab
  /// indicator's bounds in terms of its (centered) tab widget with
  /// [TabBarIndicatorSize.label], or the entire tab with
  /// [TabBarIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is FloatingLineTabIndicator) {
      return FloatingLineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is FloatingLineTabIndicator) {
      return FloatingLineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _FloatingLinePainter createBoxPainter([ VoidCallback onChanged ]) {
    return _FloatingLinePainter(this, onChanged);
  }


  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _FloatingLinePainter extends BoxPainter {
  _FloatingLinePainter(this.decoration, VoidCallback onChanged)
    : assert(decoration != null),
      super(onChanged);

  final FloatingLineTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    // final Rect rect = offset & configuration.size;
    // final TextDirection textDirection = configuration.textDirection;
    // final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    // final Paint paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.square;
    // canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);

    final Rect rect = offset & configuration.size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(40.0));
    Gradient gradient =LinearGradient(colors:[Colors.blue[100], Colors.blue[300]]);
    canvas.drawRRect(rrect,
        Paint()..style = PaintingStyle.fill
          ..shader = gradient.createShader(rect));
  }
}
