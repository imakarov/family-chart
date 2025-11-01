import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';

/// Main app menu drawer
/// Opens from the left side of the screen (70% width)
class AppMenuDrawer extends StatelessWidget {
  final int? checklistId;
  final bool showDashboardOption;
  final Future<void> Function()? onPrintCurrentWeek;
  final Future<void> Function()? onPrintNextWeek;
  final Future<void> Function()? onPrintNext3Weeks;

  const AppMenuDrawer({
    super.key,
    this.checklistId,
    this.showDashboardOption = true,
    this.onPrintCurrentWeek,
    this.onPrintNextWeek,
    this.onPrintNext3Weeks,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: Column(
          children: [
            // Menu items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  // Dashboard (only show if not on dashboard)
                  if (showDashboardOption) ...[
                    _MenuItem(
                      icon: Icons.dashboard_outlined,
                      title: 'Dashboard',
                      onTap: () {
                        Navigator.pop(context);
                        context.go('/');
                      },
                    ),
                  ],

                  // Try Premium
                  _MenuItem(
                    icon: Icons.star_outline,
                    title: 'Try Premium',
                    onTap: () {
                      Navigator.pop(context);
                      _showPremiumPlaceholder(context);
                    },
                  ),

                  const _MenuDivider(),
                  const _MenuSectionHeader(title: 'Family Checklist'),

                  // Print Checklist
                  _MenuItem(
                    icon: Icons.print_outlined,
                    title: 'Print Checklist',
                    hasSubmenu: true,
                    onTap: () {
                      Navigator.pop(context);
                      _showPrintOptionsDialog(context);
                    },
                  ),

                  // Scan Printed Checklist
                  _MenuItem(
                    icon: Icons.qr_code_scanner_outlined,
                    title: 'Scan Printed Checklist',
                    onTap: () {
                      Navigator.pop(context);
                      _showScanPlaceholder(context);
                    },
                  ),

                  // Edit Checklist
                  _MenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Checklist',
                    hasSubmenu: true,
                    onTap: () {
                      Navigator.pop(context);
                      _showEditChecklistSubmenu(context);
                    },
                  ),

                  const _MenuDivider(),

                  // Settings
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/settings');
                    },
                  ),

                  // Rate Us
                  _MenuItem(
                    icon: Icons.star_rate_outlined,
                    title: 'Rate Us',
                    onTap: () async {
                      Navigator.pop(context);
                      await _rateApp();
                    },
                  ),

                  const _MenuDivider(),

                  // Help Center
                  _MenuItem(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () async {
                      Navigator.pop(context);
                      await _launchURL('https://imakarov.us/index.html#faq');
                    },
                  ),

                  // Terms of Use
                  _MenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms of Use',
                    onTap: () async {
                      Navigator.pop(context);
                      await _launchURL('https://imakarov.us/terms.html');
                    },
                  ),

                  // Privacy Policy
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () async {
                      Navigator.pop(context);
                      await _launchURL('https://imakarov.us/privacy.html');
                    },
                  ),

                  // Restore Purchases
                  _MenuItem(
                    icon: Icons.restore_outlined,
                    title: 'Restore Purchases',
                    onTap: () {
                      Navigator.pop(context);
                      _showRestorePlaceholder(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show premium placeholder
  void _showPremiumPlaceholder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Features'),
        content: const Text('Premium paywall will be integrated here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show print options dialog (iOS 17+ modal bottom sheet style)
  void _showPrintOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main actions sheet
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7), // iOS gray background
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    // Title
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD1D1D6),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Print Checklist',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    // Current Week
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Current Week',
                      onTap: () async {
                        Navigator.pop(context);
                        if (onPrintCurrentWeek != null) {
                          await onPrintCurrentWeek!();
                        } else {
                          _showPrintPlaceholder(context, 'Current Week');
                        }
                      },
                      showDivider: true,
                    ),
                    // Next Week
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Next Week',
                      onTap: () async {
                        Navigator.pop(context);
                        if (onPrintNextWeek != null) {
                          await onPrintNextWeek!();
                        } else {
                          _showPrintPlaceholder(context, 'Next Week');
                        }
                      },
                      showDivider: true,
                    ),
                    // Next 3 Weeks
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Next 3 Weeks',
                      onTap: () async {
                        Navigator.pop(context);
                        if (onPrintNext3Weeks != null) {
                          await onPrintNext3Weeks!();
                        } else {
                          _showPrintPlaceholder(context, 'Next 3 Weeks');
                        }
                      },
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Cancel button (separate)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build bottom sheet action item
  Widget _buildBottomSheetAction({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF007AFF),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 0.5,
            thickness: 0.5,
            color: Color(0xFFD1D1D6),
          ),
      ],
    );
  }

  // Show print placeholder
  void _showPrintPlaceholder(BuildContext context, String option) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Print feature will be implemented: $option')),
    );
  }

  // Show scan placeholder
  void _showScanPlaceholder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Checklist'),
        content: const Text('OCR scanning feature will be integrated here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show edit checklist submenu (iOS 17+ modal bottom sheet style)
  void _showEditChecklistSubmenu(BuildContext context) {
    if (checklistId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a checklist first')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main actions sheet
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7), // iOS gray background
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    // Title
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD1D1D6),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Edit Checklist',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    // Edit Family Members
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Edit Family Members',
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/edit/$checklistId/members');
                      },
                      showDivider: true,
                    ),
                    // Edit Members Tasks
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Edit Members Tasks',
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/edit/$checklistId/tasks');
                      },
                      showDivider: true,
                    ),
                    // Edit Regularity
                    _buildBottomSheetAction(
                      context: context,
                      title: 'Edit Regularity',
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/edit/$checklistId/schedule');
                      },
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Cancel button (separate)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show settings dialog
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement language selection
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Language selection coming soon')),
                );
              },
            ),
            ListTile(
              title: const Text('First Day of Week'),
              subtitle: const Text('Monday'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement first day selection
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Day selection coming soon')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show restore placeholder
  void _showRestorePlaceholder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Purchases'),
        content: const Text('Purchase restoration will be integrated here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Rate app in App Store
  Future<void> _rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      // Fallback to opening App Store
      await inAppReview.openStoreListing();
    }
  }

  // Launch URL
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Menu item widget
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasSubmenu;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasSubmenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: const Color(0xFF000000),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
      ),
      trailing: hasSubmenu
          ? const Icon(
              Icons.chevron_right,
              color: Color(0xFF8E8E93),
            )
          : null,
      onTap: onTap,
    );
  }
}

/// Menu section header
class _MenuSectionHeader extends StatelessWidget {
  final String title;

  const _MenuSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }
}

/// Menu divider
class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Divider(
        color: Color(0xFFE5E5EA),
        height: 1,
      ),
    );
  }
}

