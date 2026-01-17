import 'package:flutter/material.dart';

class ConditionalDetailScreen extends StatelessWidget {
  final String type;
  final String title;
  final String usage;
  final String formula;
  final List<String> examples;
  final String mistake;
  final String tip;
  final Color color;

  const ConditionalDetailScreen({
    super.key,
    required this.type,
    required this.title,
    required this.usage,
    required this.formula,
    required this.examples,
    required this.mistake,
    required this.tip,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              type,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Usage
          _buildSection(
            'Dùng khi nào?',
            Icons.lightbulb_outline,
            color,
            Text(usage, style: const TextStyle(fontSize: 14)),
          ),

          // Formula
          _buildSection(
            'Công thức',
            Icons.functions,
            color,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Text(
                formula,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Examples
          _buildSection(
            'Ví dụ',
            Icons.format_quote,
            color,
            Column(
              children: examples
                  .map((ex) => Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          ex,
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Mistake
          _buildSection(
            '⚠ Lỗi thường gặp',
            Icons.warning_amber,
            Colors.red,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF3E2723)
                    : const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.orange[700]!
                      : Colors.orange[300]!,
                ),
              ),
              child: Text(
                mistake,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.red[900],
                ),
              ),
            ),
          ),

          // Tip
          _buildSection(
            '💡 Mẹo nhớ',
            Icons.tips_and_updates,
            Colors.amber,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Text(
                tip,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.amber[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
