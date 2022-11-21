import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  final Alignment align;
  final double size;
  final bool isFit;

  LoadingIndicator({
    this.backgroundColor = Colors.transparent,
    this.align = Alignment.center,
    this.size = 64,
    this.isFit = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: backgroundColor ?? Colors.transparent,
        child: Align(
          alignment: align ?? Alignment.center,
          child: isFit
              ? Lottie.asset('assets/loading_indicator3.zip')
              : Lottie.asset(
                  'assets/loading_indicator1.zip',
                  width: size,
                  height: size,
                ),
        ),
      );
}
