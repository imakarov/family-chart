import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/settings_repository.dart';
import '../core/utils/week_day_helper.dart';

/// Reusable weekday selector widget with 3-letter day names and checkmarks
class WeekdaySelector extends ConsumerWidget {
  final List<int> selectedDays; // ISO day numbers (1-7) stored in DB
  final Function(int) onDayToggle; // Callback receives UI index (0-6)

  const WeekdaySelector({
    super.key,
    required this.selectedDays,
    required this.onDayToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get weekStartDay setting to determine day order
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays; // ISO days in UI order

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use actual available width from parent
        final availableWidth = constraints.maxWidth;
        final gapWidth = 6.0 * 6; // 6px gap between 7 buttons = 36px
        final buttonSize = (availableWidth - gapWidth) / 7;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(7, (uiIndex) {
            final isoDayOfWeek = orderedDays[uiIndex]; // Get ISO day for this UI position
            final isSelected = selectedDays.contains(isoDayOfWeek); // Check if this ISO day is selected
            final dayLabel = helper.getShortLabel(isoDayOfWeek); // Get short label for this ISO day

            return Container(
              margin: EdgeInsets.only(right: uiIndex < 6 ? 6 : 0),
              child: GestureDetector(
                onTap: () => onDayToggle(uiIndex), // Pass UI index to callback
                child: SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF34C759) : const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF34C759) : const Color(0xFFE5E5EA),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Day name (always at top)
                          Text(
                            dayLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                              height: 1.2,
                            ),
                          ),
                          // Checkmark (visible or invisible placeholder)
                          Text(
                            isSelected ? '✓' : '',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
