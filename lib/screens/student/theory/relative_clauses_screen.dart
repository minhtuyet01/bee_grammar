import 'package:flutter/material.dart';

class RelativeClausesScreen extends StatelessWidget {
  const RelativeClausesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mệnh Đề Quan Hệ'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildConceptCard(),
          const SizedBox(height: 16),
          _buildTypesCard(context),
          const SizedBox(height: 16),
          _buildPronounCard(context, 'WHO', 'người (chủ ngữ/tân ngữ)', [
            'The girl who is standing there is my sister. (chủ ngữ)',
            'The man who(m) I met yesterday is my teacher. (tân ngữ)',
          ], Colors.blue),
          _buildPronounCard(context, 'WHICH', 'vật (chủ ngữ/tân ngữ)', [
            'The car which is parked outside is mine. (chủ ngữ)',
            'The book which I\'m reading is great. (tân ngữ)',
          ], Colors.green),
          _buildPronounCard(context, 'THAT', 'người/vật (chủ ngữ/tân ngữ)', [
            'The man that called you is my boss.',
            'The movie that we watched was boring.',
          ], Colors.orange, extraInfo: 'BẮT BUỘC dùng "that" sau: the best/worst/most, all/everything/nothing, the only/first/last'),
          _buildPronounCard(context, 'WHOSE', 'sở hữu (của người/vật)', [
            'The man whose car was stolen called the police.',
            'The house whose roof is red is mine.',
          ], Colors.purple),
          _buildPronounCard(context, 'WHERE', 'nơi chốn', [
            'The hotel where we stayed was very nice.',
            'This is the place where I was born.',
          ], Colors.teal),
          _buildPronounCard(context, 'WHEN', 'thời gian', [
            'I remember the day when we first met.',
            'Summer is the time when I feel happiest.',
          ], Colors.pink),
          const SizedBox(height: 16),
          _buildMistakesCard(context),
          const SizedBox(height: 16),
          _buildComparisonCard(),
          const SizedBox(height: 16),
          _buildSummaryTable(context),
        ],
      ),
    );
  }

  Widget _buildConceptCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📖 Mệnh đề quan hệ là gì?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Mệnh đề phụ bổ sung thông tin cho danh từ đứng trước nó, bắt đầu bằng đại từ quan hệ (who, which, that, whose, where, when...)',
                style: TextStyle(fontSize: 13, color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔵 Hai loại mệnh đề quan hệ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTypeBox(
              context,
              'Xác định (Defining)',
              [
                'Cung cấp thông tin cần thiết',
                'Không có dấu phẩy',
                'Không thể bỏ đi',
              ],
              'The man who lives next door is a doctor.',
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildTypeBox(
              context,
              'Không xác định (Non-defining)',
              [
                'Cung cấp thông tin thêm',
                'Có dấu phẩy ngăn cách',
                'Có thể bỏ đi',
                'Không dùng "that"',
              ],
              'My brother, who lives in London, is a teacher.',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBox(BuildContext context, String title, List<String> points, String example, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color)),
                    Expanded(child: Text(point, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPronounCard(BuildContext context, String pronoun, String usage, List<String> examples, Color color, {String? extraInfo}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    pronoun,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    usage,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...examples.map((ex) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ex,
                    style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                )),
            if (extraInfo != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        extraInfo,
                        style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMistakesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '⚠ Lỗi thường gặp',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMistake(
              context,
              'Thừa đại từ/danh từ',
              '❌ The man who he lives next door...',
              '✅ The man who lives next door...',
            ),
            _buildMistake(
              context,
              'Dùng "that" trong mệnh đề không xác định',
              '❌ My brother, that lives in London, ...',
              '✅ My brother, who lives in London, ...',
            ),
            _buildMistake(
              context,
              'Thiếu dấu phẩy trong mệnh đề không xác định',
              '❌ My brother who lives in London is a teacher.',
              '✅ My brother, who lives in London, is a teacher.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMistake(BuildContext context, String title, String wrong, String correct) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF3E2723)
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.orange[700]!
              : Colors.orange[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.red[900],
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(wrong, style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.red[800])),
          Text(correct, style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.green[800])),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 So sánh nhanh',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildComparison(
              'THAT vs WHICH',
              [
                'Mệnh đề xác định: dùng cả "that" và "which"',
                'Mệnh đề không xác định: chỉ dùng "which"',
                'Sau dấu phẩy: không dùng "that"',
              ],
            ),
            const SizedBox(height: 12),
            _buildComparison(
              'WHO vs WHOM',
              [
                'WHO: chủ ngữ → The man who called',
                'WHOM: tân ngữ → The man whom I called',
                'Trong văn nói: thường dùng "who" cho cả 2',
              ],
            ),
            const SizedBox(height: 12),
            _buildComparison(
              'Có thể lược bỏ đại từ quan hệ khi',
              [
                'Làm tân ngữ trong mệnh đề xác định',
                'The book (which/that) I bought = The book I bought',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparison(String title, List<String> points) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: Colors.blue[700])),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSummaryTable(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💡 Mẹo ghi nhớ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Table(
              border: TableBorder.all(color: Theme.of(context).dividerColor),
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant),
                  children: [
                    _buildTableHeader('Đại từ'),
                    _buildTableHeader('Thay thế'),
                    _buildTableHeader('Ví dụ'),
                  ],
                ),
                _buildTableRow('WHO', 'người (S/O)', 'The girl who...'),
                _buildTableRow('WHICH', 'vật (S/O)', 'The book which...'),
                _buildTableRow('THAT', 'người/vật (S/O)', 'The man/book that...'),
                _buildTableRow('WHOSE', 'sở hữu', 'The man whose car...'),
                _buildTableRow('WHERE', 'nơi chốn', 'The place where...'),
                _buildTableRow('WHEN', 'thời gian', 'The day when...'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String pronoun, String replaces, String example) {
    return TableRow(
      children: [
        _buildTableCell(pronoun, isBold: true),
        _buildTableCell(replaces),
        _buildTableCell(example, isItalic: true),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isBold = false, bool isItalic = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        ),
        textAlign: isBold ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}
