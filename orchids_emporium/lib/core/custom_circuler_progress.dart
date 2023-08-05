import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/progress_painter.dart';
import 'package:orchids_emporium/core/typography/style.dart';

class CustomProgress extends StatefulWidget {
  const CustomProgress({super.key});

  @override
  CustomProgressState createState() => CustomProgressState();
}

class CustomProgressState extends State<CustomProgress>
    with SingleTickerProviderStateMixin {
  double? _percentage;
  double? _nextPercentage;
  Timer? _timer;
  AnimationController? _progressAnimationController;
  bool? _progressDone;

  @override
  initState() {
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = null;
    _progressDone = false;
    initAnimationController();
  }

  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(
        () {
          setState(() {
            _percentage = lerpDouble(_percentage, _nextPercentage,
                _progressAnimationController!.value);
          });
        },
      );
  }

  start() {
    Timer.periodic(const Duration(milliseconds: 30), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage! < 100) {
      publishProgress();
    } else {
      timer.cancel();
      setState(() {
        _progressDone = true;
      });
    }
  }

  startProgress() {
    if (null != _timer && _timer!.isActive) {
      _timer!.cancel();
    }
    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      _progressDone = false;
      start();
    });
  }

  endProgress() {
    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      _progressDone = false;

      _timer!.cancel();
    });
  }

  void publishProgress() {
    setState(() {
      _percentage = _nextPercentage ?? 0.0;
      _nextPercentage = (_nextPercentage ?? 0.0) + 2.0;
      if (_nextPercentage! > 100.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController?.forward(from: 0.0);
    });
  }

  getDoneText() {
    return Text(
      'Done',
      style: AppTypography.regular24(),
    );
  }

  getProgressText() {
    return Text(
      _nextPercentage == 0 ? 'Tap' : '${_nextPercentage!.toInt()}',
      style: AppTypography.regular24(),
    );
  }

  progressView() {
    return CustomPaint(
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Palette.greenwhiteColor,
          percentageCompletedCircleColor: Palette.greenColor,
          completedPercentage: _percentage!,
          circleWidth: 25.0),
      child: GestureDetector(
        onLongPress: () {
          startProgress();
        },
        onLongPressEnd: (context) {
          endProgress();
        },
        child: Center(
          child: _progressDone! ? getDoneText() : getProgressText(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      padding: const EdgeInsets.all(10.0),
      child: progressView(),
    );
  }
}
