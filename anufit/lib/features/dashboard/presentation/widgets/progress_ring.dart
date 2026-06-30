import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/core/constants/app_animations.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ProgressRing extends StatefulWidget {
  const ProgressRing({
    required this.currentSteps,
    required this.goalSteps,
    required this.percentage,
    super.key,
  });

  final int currentSteps;
  final int goalSteps;
  final double percentage;

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _displayedSteps;

  @override
  void initState() {
    super.initState();
    _displayedSteps = widget.currentSteps;
    _controller = AnimationController(vsync: this, duration: AppAnimations.slow);
    _animation = Tween<double>(begin: 0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percentage != widget.percentage) {
      _animation = Tween<double>(
        begin: oldWidget.percentage,
        end: widget.percentage,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
    if (oldWidget.currentSteps != widget.currentSteps) {
      _displayedSteps = oldWidget.currentSteps;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: CustomPaint(
                  painter: _RingPainter(progress: _animation.value),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TweenAnimationBuilder<int>(
                          tween: IntTween(
                            begin: _displayedSteps,
                            end: widget.currentSteps,
                          ),
                          duration: AppAnimations.counter,
                          onEnd: () => _displayedSteps = widget.currentSteps,
                          builder: (context, value, _) {
                            return Text(
                              _formatNumber(value),
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            );
                          },
                        ),
                        Text(
                          '/ ${_formatNumber(widget.goalSteps)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${(_animation.value * 100).round()}% complete',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Today's Progress",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const stroke = 14.0;

    final background = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final foreground = Paint()
      ..shader = const SweepGradient(
        colors: [AppColors.primary, AppColors.secondary],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, background);

    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
