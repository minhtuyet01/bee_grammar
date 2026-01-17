import 'package:flutter/material.dart';
import '../../../models/grammar_section.dart';

class TenseDetailScreen extends StatelessWidget {
  final GrammarSection tense;
  final Color color;

  const TenseDetailScreen({
    super.key,
    required this.tense,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tense.title),
            if (tense.subtitle != null)
              Text(
                tense.subtitle!,
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
          _buildSectionTitle('Dùng khi nào?', Icons.lightbulb_outline, color),
          const SizedBox(height: 8),
          ...tense.usage.map((u) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color)),
                    Expanded(child: Text(u)),
                  ],
                ),
              )),
          const SizedBox(height: 16),

          // Formulas
          if (tense.formulas != null) ...[
            _buildSectionTitle('Công thức', Icons.functions, color),
            const SizedBox(height: 8),
            ...tense.formulas!.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
          ],

          // Examples
          _buildSectionTitle('Ví dụ', Icons.format_quote, color),
          const SizedBox(height: 8),
          ...tense.examples.map((ex) => Container(
                margin: const EdgeInsets.only(left: 8, bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Text(
                  ex,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )),
          const SizedBox(height: 16),

          // Common Mistakes
          _buildSectionTitle('⚠ Lỗi thường gặp', Icons.warning_amber, color),
          const SizedBox(height: 8),
          ...tense.commonMistakes.map((mistake) => Container(
                margin: const EdgeInsets.only(left: 8, bottom: 6),
                padding: const EdgeInsets.all(10),
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
                    fontSize: 13,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.red[900],
                  ),
                ),
              )),

          // Comparison
          if (tense.comparison != null) ...[
            const SizedBox(height: 16),
            _buildSectionTitle('So sánh nhanh', Icons.compare_arrows, color),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Text(
                tense.comparison!,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.blue[900],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
