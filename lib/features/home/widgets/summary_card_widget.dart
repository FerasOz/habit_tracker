import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/spacing.dart';
import 'package:habit_tracker/core/styles/colors.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

class SummaryCardWidget extends StatelessWidget {
  final int done;
  final int total;
  final double progress;

  const SummaryCardWidget({
    super.key,
    required this.done,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();
    final theme = Theme.of(context);
    final statusMessage = _statusMessage(context, percentage);

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primary,
            const Color(0xFF12A564),
            ColorsManager.secondary.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primary.withOpacity(0.28),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.home_summary_title.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const Icon(Icons.trending_up, color: Colors.white70),
            ],
          ),
          verticalSpace(12),
          Text(
            "$done / $total ${LocaleKeys.home_summary_completed.tr()}",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          verticalSpace(6),
          Text(
            "$percentage%",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          verticalSpace(4),
          Text(
            statusMessage,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          verticalSpace(14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8.h,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _statusMessage(BuildContext context, int percentage) {
    if (percentage >= 80) return LocaleKeys.home_summary_excellent.tr();
    if (percentage >= 40) return LocaleKeys.home_summary_good.tr();
    return LocaleKeys.home_summary_start.tr();
  }
}
