import 'package:flutter/material.dart';
import 'conditional_detail_screen.dart';

class ConditionalsScreen extends StatelessWidget {
  const ConditionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conditionals = [
      {
        'type': 'Loại 0',
        'title': 'Zero Conditional',
        'usage': 'Sự thật hiển nhiên, chân lý, quy luật tự nhiên',
        'formula': 'If + S + V (hiện tại đơn), S + V (hiện tại đơn)',
        'examples': [
          'If you heat ice, it melts.',
          'If it rains, the ground gets wet.',
          'Water boils if you heat it to 100°C.',
        ],
        'mistake': 'Dùng will trong mệnh đề chính\n❌ If you heat ice, it will melt.',
        'tip': 'Có thể thay "if" = "when"',
        'color': Colors.blue,
      },
      {
        'type': 'Loại 1',
        'title': 'First Conditional',
        'usage': 'Điều kiện có thể xảy ra trong tương lai (khả năng cao)',
        'formula': 'If + S + V (hiện tại đơn), S + will + V',
        'examples': [
          'If it rains tomorrow, I will stay home.',
          'If you study hard, you will pass the exam.',
          'She will be happy if you come to the party.',
        ],
        'mistake': 'Dùng will trong mệnh đề if\n❌ If you will come, I will be happy.\n✅ If you come, I will be happy.',
        'tip': 'Mẹo nhớ: "If hiện tại, will tương lai"',
        'color': Colors.green,
      },
      {
        'type': 'Loại 2',
        'title': 'Second Conditional',
        'usage': 'Điều kiện không có thật ở hiện tại hoặc khó xảy ra trong tương lai',
        'formula': 'If + S + V2/ed (quá khứ đơn), S + would + V',
        'examples': [
          'If I were rich, I would travel the world.',
          'If I had a car, I would drive to work.',
          'If you studied harder, you would pass.',
        ],
        'mistake': 'Dùng "was" thay vì "were" với I/he/she/it\n❌ If I was you... → ✅ If I were you...',
        'tip': 'Với "be", luôn dùng "were" cho mọi chủ ngữ',
        'color': Colors.orange,
      },
      {
        'type': 'Loại 3',
        'title': 'Third Conditional',
        'usage': 'Điều kiện không có thật trong quá khứ (hối tiếc, giả định)',
        'formula': 'If + S + had + V3/ed, S + would have + V3/ed',
        'examples': [
          'If I had studied, I would have passed the exam.',
          'If she had known, she would have come.',
          'If we had left earlier, we wouldn\'t have missed the train.',
        ],
        'mistake': 'Nhầm lẫn giữa had và would have\n❌ If I would have known... → ✅ If I had known...',
        'tip': 'Mẹo nhớ: "If had V3, would have V3"',
        'color': Colors.red,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Câu Điều Kiện'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: conditionals.length,
        itemBuilder: (context, index) {
          final conditional = conditionals[index];
          return _buildConditionalCard(
            context,
            conditional['type'] as String,
            conditional['title'] as String,
            conditional['usage'] as String,
            conditional['formula'] as String,
            conditional['examples'] as List<String>,
            conditional['mistake'] as String,
            conditional['tip'] as String,
            conditional['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildConditionalCard(
    BuildContext context,
    String type,
    String title,
    String usage,
    String formula,
    List<String> examples,
    String mistake,
    String tip,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConditionalDetailScreen(
                type: type,
                title: title,
                usage: usage,
                formula: formula,
                examples: examples,
                mistake: mistake,
                tip: tip,
                color: color,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Type badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      usage,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
