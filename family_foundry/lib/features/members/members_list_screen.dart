import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_member_repository.dart';
import '../../data/models/member.dart';
import 'widgets/member_card.dart';

final membersProvider = FutureProvider<List<Member>>((ref) async {
  return MockMemberRepository().getAllMembers();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredMembersProvider = FutureProvider<List<Member>>((ref) async {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final allMembers = await MockMemberRepository().getAllMembers();
  if (query.isEmpty) return allMembers;
  return allMembers.where((m) {
    return m.name.toLowerCase().contains(query) ||
        m.profession.toLowerCase().contains(query) ||
        m.skills.any((s) => s.name.toLowerCase().contains(query)) ||
        m.canHelpWith.any((h) => h.toLowerCase().contains(query));
  }).toList();
});

class MembersListScreen extends ConsumerStatefulWidget {
  final String? initialSearch;
  const MembersListScreen({super.key, this.initialSearch});

  @override
  ConsumerState<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends ConsumerState<MembersListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: widget.initialSearch ?? '');
    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchQueryProvider.notifier).state = widget.initialSearch!;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(filteredMembersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Who can help with…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                ref.read(searchQueryProvider.notifier).state = val;
                setState(() {}); // rebuild to show/hide clear button
              },
            ),
          ),
        ),
      ),
      body: membersAsync.when(
        data: (members) => members.isEmpty
            ? const Center(child: Text('No members match your search.'))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: members.length,
                itemBuilder: (context, index) =>
                    MemberCard(member: members[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading members: $err')),
      ),
    );
  }
}
