import 'package:blog_app_case_study/app/shared/ui/extensions/sized_context.dart';
import 'package:flutter/material.dart'
    show BuildContext, Key, SizedBox, StatelessWidget, Widget;

class VerticalSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  const VerticalSpace({
    Key? key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.height;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenHeight;
    return SizedBox(height: size);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  const HorizontalSpace({
    Key? key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenWidth;
    return SizedBox(width: size);
  }
}

enum SizeUnit { pixel, percent }