import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/isar_provider.dart';
import '../../data/models/users.dart';
import '../../data/models/user_tasks.dart';
import '../../data/models/task_completions.dart';

/// Family member model
class FamilyMember {
  final String id;
  String name;
  String role; // 'parent' or 'kid'
  String avatar;

  FamilyMember({
    required this.id,
    this.name = '',
    required this.role,
    required this.avatar,
  });
}

/// Screen 1 (Step 1/3): Add family members
class Step1FamilyMembersScreen extends ConsumerStatefulWidget {
  final Function(List<FamilyMember>) onContinue;
  final List<FamilyMember>? initialMembers; // For edit mode
  final int? checklistId; // For edit mode (to delete from DB)

  const Step1FamilyMembersScreen({
    super.key,
    required this.onContinue,
    this.initialMembers,
    this.checklistId,
  });

  @override
  ConsumerState<Step1FamilyMembersScreen> createState() =>
      _Step1FamilyMembersScreenState();
}

class _Step1FamilyMembersScreenState extends ConsumerState<Step1FamilyMembersScreen> {
  late List<FamilyMember> _members;
  final Map<String, TextEditingController> _nameControllers = {};

  // Available avatars (matching HTML)
  final List<String> _avatars = [
    '👨', '👩', '👦', '👧', '🧑', '👶', '👴', '👵',
    '🧔', '👱', '👨‍🦰', '👩‍🦰', '👨‍🦱', '👩‍🦱', '👨‍🦳', '👩‍🦳',
    '🧒', '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with existing members or start fresh
    if (widget.initialMembers != null && widget.initialMembers!.isNotEmpty) {
      _members = List.from(widget.initialMembers!);
      // Create controllers for existing members
      for (final member in _members) {
        _nameControllers[member.id] = TextEditingController(text: member.name);
      }
    } else {
      _members = [];
      // Start with one parent (matching HTML behavior)
      _addMember('parent');
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (final controller in _nameControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addMember(String role) {
    final id = 'member_${DateTime.now().millisecondsSinceEpoch}';
    final avatar = role == 'parent'
        ? (_members.isEmpty ? '👨' : '👩')
        : (_members.length % 2 == 0 ? '👦' : '👧');

    final member = FamilyMember(
      id: id,
      role: role,
      avatar: avatar,
    );

    setState(() {
      _members.add(member);
      // Create controller for new member
      _nameControllers[id] = TextEditingController(text: member.name);
    });
  }

  Future<void> _removeMember(String id) async {
    final member = _members.firstWhere((m) => m.id == id);

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Member?'),
        content: Text(
          'All tasks and completion data for ${member.name.isEmpty ? "this member" : member.name} will be deleted. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // If in edit mode, delete from database
    if (widget.checklistId != null && id.startsWith('member_')) {
      try {
        final userIdStr = id.substring(7); // Remove 'member_' prefix
        final userId = int.tryParse(userIdStr);

        if (userId != null) {
          final isar = await ref.read(isarProvider.future);

          await isar.writeTxn(() async {
            // 1. Delete all UserTasks for this user in this checklist
            final userTasks = await isar.userTasks
                .filter()
                .userIdEqualTo(userId)
                .checklistIdEqualTo(widget.checklistId!)
                .findAll();

            for (final userTask in userTasks) {
              await isar.userTasks.delete(userTask.id);
            }

            // 2. Delete all TaskCompletions for this user in this checklist
            final completions = await isar.taskCompletions
                .filter()
                .userIdEqualTo(userId)
                .checklistIdEqualTo(widget.checklistId!)
                .findAll();

            for (final completion in completions) {
              await isar.taskCompletions.delete(completion.id);
            }

            // 3. Delete the user
            await isar.users.delete(userId);
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting member: $e')),
          );
        }
        return;
      }
    }

    // Remove from local state
    setState(() {
      _members.removeWhere((m) => m.id == id);
      // Dispose and remove controller
      _nameControllers[id]?.dispose();
      _nameControllers.remove(id);
    });
  }

  void _updateMemberName(String id, String name) {
    final member = _members.firstWhere((m) => m.id == id);
    setState(() {
      member.name = name;
    });
  }

  void _showAvatarPicker(String memberId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Avatar',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final member = _members.firstWhere((m) => m.id == memberId);
                    setState(() {
                      member.avatar = _avatars[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        _avatars[index],
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E8E93),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRolePicker(String memberId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Role',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _buildRoleOption('👨 Parent', 'parent', memberId),
            const SizedBox(height: 12),
            _buildRoleOption('👧 Kid', 'kid', memberId),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E8E93),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(String label, String role, String memberId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final member = _members.firstWhere((m) => m.id == memberId);
          setState(() {
            member.role = role;
          });
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F7),
          foregroundColor: const Color(0xFF0A7FCC),
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // Reduced from 100
              // Header
              const Text(
                'Family Members',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add your family members to get started',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              // Members grid with scroll
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _members.length + 1, // +1 for "Add Member" card
                  itemBuilder: (context, index) {
                    if (index < _members.length) {
                      return _buildMemberCard(_members[index]);
                    } else {
                      return _buildAddMemberCard();
                    }
                  },
                ),
              ),
              const SizedBox(height: 12), // Reduced from 80
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 34, top: 8),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _members.isEmpty ? null : () => widget.onContinue(_members),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A7FCC),
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFF0A7FCC).withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
              shadowColor: const Color(0xFF0A7FCC).withOpacity(0.3),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(FamilyMember member) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              GestureDetector(
                onTap: () => _showAvatarPicker(member.id),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF667EEA).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      member.avatar,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Name input
              TextField(
                controller: _nameControllers[member.id],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: member.role == 'parent' ? 'Parent name' : 'Kid name',
                  hintStyle: const TextStyle(
                    color: Color(0xFFC7C7CC),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                onChanged: (value) => _updateMemberName(member.id, value),
              ),
              const SizedBox(height: 4),
              // Role badge
              GestureDetector(
                onTap: () => _showRolePicker(member.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    member.role == 'parent' ? '👨 Parent' : '👧 Kid',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Remove button
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _removeMember(member.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '×',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF3B30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberCard() {
    return GestureDetector(
      onTap: () => _addMember('kid'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: const Color(0xFFC7C7CC),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0A7FCC),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add Member',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0A7FCC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
