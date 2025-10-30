import 'package:flutter/material.dart';

/// Reusable weekday selector widget with 3-letter day names and checkmarks
class WeekdaySelector extends StatelessWidget {
  final List<int> selectedDays; // 0=Sun, 1=Mon, ..., 6=Sat
  final Function(int) onDayToggle;

  const WeekdaySelector({
    super.key,
    required this.selectedDays,
    required this.onDayToggle,
  });

  static final List<String> _weekdayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use actual available width from parent
        final availableWidth = constraints.maxWidth;
        final gapWidth = 6.0 * 6; // 6px gap between 7 buttons = 36px
        final buttonSize = (availableWidth - gapWidth) / 7;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(7, (index) {
            final isSelected = selectedDays.contains(index);
            return Container(
              margin: EdgeInsets.only(right: index < 6 ? 6 : 0),
              child: GestureDetector(
                onTap: () => onDayToggle(index),
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
                            _weekdayNames[index],
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
