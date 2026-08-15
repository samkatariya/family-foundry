import 'package:flutter/material.dart';
import '../../data/local/mock_data.dart';

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meeting = mockNextMeeting;
    return Scaffold(
      appBar: AppBar(title: const Text('Meetings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next Meeting', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      meeting['date'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Agenda', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    ...(meeting['agenda'] as List<String>).map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(child: Text(item)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Past Meetings', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Meeting #01'),
                subtitle: Text('10 Aug – Ideation & problem discussion'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
