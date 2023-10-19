import 'package:blog_app_case_study/app/shared/ui/extensions/sized_context.dart';
import 'package:flutter/material.dart'
    show BuildContext, SizedBox, StatelessWidget, Widget;

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({
    super.key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  });
  final double size;
  final SizeUnit unit;
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.height;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenHeight;
    return SizedBox(height: size);
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({
    super.key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  });
  final double size;
  final SizeUnit unit;
  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenWidth;
    return SizedBox(width: size);
  }
}

enum SizeUnit { pixel, percent }
