import 'package:flutter/material.dart';

class CyberpunkFilter {
  Color color;
  BlendMode blendMode;
  double opacity;
  Offset offset;
  Offset blurSigma;

  CyberpunkFilter({
    this.color, this.blendMode, this.opacity,
    this.offset, this.blurSigma
  });
}
