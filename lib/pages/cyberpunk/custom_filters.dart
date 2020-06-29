import 'dart:typed_data';

import 'package:photofilters/filters/color_filters.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/subfilters.dart';


class CyberpunkFilter extends ColorFilter {
  CyberpunkFilter() : super(name: "Cyberpunk") {
    subFilters.add(new ContrastSubFilter(0.22));
    subFilters.add(new BrightnessSubFilter(0.01));
    subFilters.add(new SepiaSubFilter(.01));
    subFilters.add(new RGBOverlaySubFilter(235, 3, 155, 0.1));
    subFilters.add(new RGBScaleSubFilter(1.01, 1.04, 1));
    subFilters.add(new RGBOverlaySubFilter(28, 127, 219, 0.2));
  }
}