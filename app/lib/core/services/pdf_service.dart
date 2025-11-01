import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../data/models/users.dart';
import '../../data/models/tasks.dart';
import '../../data/models/user_tasks.dart';
import '../utils/date_utils.dart' as app_date_utils;

/// Service for generating and printing PDF documents
class PdfService {
  /// Generate Weekly Board PDF (empty checklist for printing)
  Future<Uint8List> generateWeeklyBoardPdf({
    required int weekNumber,
    required int weekYear,
    required List<Users> users,
    required List<Tasks> tasks,
    required List<UserTasks> userTasks,
  }) async {
    final pdf = pw.Document();

    // Load emoji font for PDF
    final emojiFont = await PdfGoogleFonts.notoColorEmoji();

    // Get week start date for header
    final weekStart = app_date_utils.DateUtils.getWeekStartDate(weekNumber, weekYear);
    final weekEnd = weekStart.add(const Duration(days: 6));

    // Format dates for header: "1 Nov - 7 Nov 2025"
    final dateFormat = DateFormat('d MMM', 'en');
    final yearFormat = DateFormat('yyyy');
    final dateRangeText = '${dateFormat.format(weekStart)} - ${dateFormat.format(weekEnd)} ${yearFormat.format(weekEnd)}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(dateRangeText),
              pw.SizedBox(height: 20),
              // Table
              pw.Expanded(
                child: _buildWeeklyTable(
                  weekStart: weekStart,
                  users: users,
                  tasks: tasks,
                  userTasks: userTasks,
                  emojiFont: emojiFont,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Generate Multiple Weeks PDF (empty checklists for N weeks)
  Future<Uint8List> generateMultipleWeeksPdf({
    required int startWeekNumber,
    required int startWeekYear,
    required int numberOfWeeks,
    required List<Users> users,
    required List<Tasks> tasks,
    required List<UserTasks> userTasks,
  }) async {
    final pdf = pw.Document();

    // Load emoji font for PDF
    final emojiFont = await PdfGoogleFonts.notoColorEmoji();

    // Generate a page for each week
    for (int i = 0; i < numberOfWeeks; i++) {
      // Calculate week number for this iteration
      final currentWeekNumber = startWeekNumber + i;
      final weekStart = app_date_utils.DateUtils.getWeekStartDate(currentWeekNumber, startWeekYear);
      final weekEnd = weekStart.add(const Duration(days: 6));

      // Format dates for header
      final dateFormat = DateFormat('d MMM', 'en');
      final yearFormat = DateFormat('yyyy');
      final dateRangeText = '${dateFormat.format(weekStart)} - ${dateFormat.format(weekEnd)} ${yearFormat.format(weekEnd)}';

      // Add page for this week
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(20),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(dateRangeText),
                pw.SizedBox(height: 20),
                // Table
                pw.Expanded(
                  child: _buildWeeklyTable(
                    weekStart: weekStart,
                    users: users,
                    tasks: tasks,
                    userTasks: userTasks,
                    emojiFont: emojiFont,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  /// Build PDF header
  pw.Widget _buildHeader(String dateRange) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          'Family Chart',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          dateRange,
          style: const pw.TextStyle(
            fontSize: 16,
            color: PdfColors.grey700,
          ),
        ),
      ],
    );
  }

  /// Build weekly table with members and tasks
  pw.Widget _buildWeeklyTable({
    required DateTime weekStart,
    required List<Users> users,
    required List<Tasks> tasks,
    required List<UserTasks> userTasks,
    required pw.Font emojiFont,
  }) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
      columnWidths: {
        0: const pw.FixedColumnWidth(120), // Member/Task name column
        // Equal width for all day columns
        for (int i = 1; i <= 7; i++) i: const pw.FlexColumnWidth(1),
      },
      children: [
        // Header row (days + dates)
        _buildHeaderRow(days, weekStart),
        // Member and task rows
        ...users.expand((user) => _buildMemberRows(
          user: user,
          tasks: tasks,
          userTasks: userTasks,
          weekStart: weekStart,
          emojiFont: emojiFont,
        )),
      ],
    );
  }

  /// Build header row with day names and dates
  pw.TableRow _buildHeaderRow(List<String> days, DateTime weekStart) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(
        color: PdfColors.white,
      ),
      children: [
        // Empty cell for member/task names
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(''),
        ),
        // Day columns
        ...List.generate(7, (index) {
          final date = weekStart.add(Duration(days: index));
          return pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  days[index],
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  '${date.day}',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// Build rows for a member (header row + task rows)
  List<pw.TableRow> _buildMemberRows({
    required Users user,
    required List<Tasks> tasks,
    required List<UserTasks> userTasks,
    required DateTime weekStart,
    required pw.Font emojiFont,
  }) {
    final rows = <pw.TableRow>[];

    // Member header row with blue pattern background
    rows.add(_buildMemberHeaderRow(user));

    // Get tasks for this user
    final memberTasks = userTasks.where((ut) => ut.userId == user.userId).toList();

    // Task rows
    for (final userTask in memberTasks) {
      final task = tasks.firstWhere((t) => t.taskId == userTask.taskId);
      rows.add(_buildTaskRow(
        task: task,
        userTask: userTask,
        weekStart: weekStart,
        emojiFont: emojiFont,
      ));
    }

    return rows;
  }

  /// Build member header row with avatar and blue pattern
  pw.TableRow _buildMemberHeaderRow(Users user) {
    // Light blue pattern color
    final bluePattern = PdfColor.fromHex('#E6F4FB');

    return pw.TableRow(
      decoration: pw.BoxDecoration(
        color: bluePattern,
      ),
      children: [
        // Member name with avatar
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Row(
            children: [
              // Avatar
              _buildAvatar(user),
              pw.SizedBox(width: 6),
              // Name
              pw.Expanded(
                child: pw.Text(
                  user.name,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Empty cells for days with blue pattern
        ...List.generate(7, (_) => pw.Container(
          padding: const pw.EdgeInsets.all(8),
        )),
      ],
    );
  }

  /// Build avatar widget (photo or initial letter)
  pw.Widget _buildAvatar(Users user) {
    if (user.avatarBytes != null && user.avatarBytes!.isNotEmpty) {
      // Show photo
      return pw.ClipRRect(
        horizontalRadius: 12,
        verticalRadius: 12,
        child: pw.Container(
          width: 24,
          height: 24,
          child: pw.Image(
            pw.MemoryImage(Uint8List.fromList(user.avatarBytes!)),
            fit: pw.BoxFit.cover,
          ),
        ),
      );
    } else {
      // Show initial letter with color
      final color = _parseColor(user.colorHex);
      return pw.Container(
        width: 24,
        height: 24,
        decoration: pw.BoxDecoration(
          color: color,
          shape: pw.BoxShape.circle,
        ),
        child: pw.Center(
          child: pw.Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
        ),
      );
    }
  }

  /// Build task row with icon and empty circles
  pw.TableRow _buildTaskRow({
    required Tasks task,
    required UserTasks userTask,
    required DateTime weekStart,
    required pw.Font emojiFont,
  }) {
    // Parse frequency days (1=Mon, 7=Sun)
    final frequencyDays = userTask.frequency.split(',').map(int.parse).toList();

    return pw.TableRow(
      children: [
        // Task name with icon
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: pw.Row(
            children: [
              pw.SizedBox(width: 8), // Indent for tasks
              pw.Text(
                task.icon,
                style: pw.TextStyle(fontSize: 12, font: emojiFont, fontFallback: [emojiFont]),
              ),
              pw.SizedBox(width: 4),
              pw.Expanded(
                child: pw.Text(
                  task.title,
                  style: const pw.TextStyle(fontSize: 9),
                  maxLines: 2,
                  overflow: pw.TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
        // Day cells with circles or empty
        ...List.generate(7, (dayIndex) {
          final dayOfWeek = dayIndex + 1; // 1=Mon, 7=Sun
          final hasTask = frequencyDays.contains(dayOfWeek);

          return pw.Container(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Center(
              child: hasTask
                  ? _buildEmptyCircle()
                  : pw.Container(), // Empty cell
            ),
          );
        }),
      ],
    );
  }

  /// Build empty grey circle (unfilled checkbox)
  pw.Widget _buildEmptyCircle() {
    return pw.Container(
      width: 16,
      height: 16,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(
          color: PdfColor.fromHex('#D1D1D6'),
          width: 1.5,
        ),
      ),
    );
  }

  /// Parse color from hex string
  PdfColor _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return PdfColors.grey;
    }
    final hex = hexColor.replaceFirst('#', '');
    return PdfColor.fromHex('#$hex');
  }

  /// Show print preview dialog and print
  Future<void> printDocument(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      format: PdfPageFormat.a4.landscape, // Force landscape orientation
    );
  }

  /// Share PDF file
  Future<void> sharePdf(Uint8List pdfBytes, String filename) async {
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: filename,
    );
  }
}
