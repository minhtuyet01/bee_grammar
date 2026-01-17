import 'package:flutter/material.dart';

class ActivePassiveScreen extends StatelessWidget {
  const ActivePassiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câu Chủ Động & Bị Động'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildConceptCard(),
          const SizedBox(height: 16),
          _buildWhenToUseCard(),
          const SizedBox(height: 16),
          _buildFormulaCard(),
          const SizedBox(height: 16),
          _buildTenseTable(context),
          const SizedBox(height: 16),
          _buildExamplesCard(context),
          const SizedBox(height: 16),
          _buildMistakesCard(context),
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
              '📖 Khái niệm',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDefinition(
              'Câu chủ động (Active Voice)',
              'Chủ ngữ thực hiện hành động',
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildDefinition(
              'Câu bị động (Passive Voice)',
              'Chủ ngữ chịu tác động của hành động',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefinition(String title, String description, Color color) {
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
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildWhenToUseCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔄 Khi nào dùng?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildUsageSection(
              'Dùng chủ động khi:',
              [
                'Biết rõ ai làm',
                'Muốn nhấn mạnh người thực hiện',
                'Văn phong tự nhiên, trực tiếp',
              ],
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildUsageSection(
              'Dùng bị động khi:',
              [
                'Không biết/không quan trọng ai làm',
                'Muốn nhấn mạnh hành động hoặc đối tượng chịu tác động',
                'Văn viết chính thức, khoa học',
              ],
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageSection(String title, List<String> points, Color color) {
    return Column(
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
        const SizedBox(height: 6),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(color: color)),
                  Expanded(child: Text(point, style: const TextStyle(fontSize: 13))),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildFormulaCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📝 Công thức chuyển đổi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'S + V + O',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(Icons.arrow_downward, color: Colors.purple[700]),
                  const SizedBox(height: 8),
                  Text(
                    'O + be + V3/ed (+ by S)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenseTable(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Các thì thường dùng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Table(
              border: TableBorder.all(color: Theme.of(context).dividerColor),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant),
                  children: [
                    _buildTableHeader('Thì'),
                    _buildTableHeader('Chủ động'),
                    _buildTableHeader('Bị động'),
                  ],
                ),
                _buildTenseRow('Hiện tại đơn', 'She cleans the room', 'The room is cleaned', context),
                _buildTenseRow('Hiện tại tiếp diễn', 'She is cleaning the room', 'The room is being cleaned', context),
                _buildTenseRow('Quá khứ đơn', 'She cleaned the room', 'The room was cleaned', context),
                _buildTenseRow('Hiện tại hoàn thành', 'She has cleaned the room', 'The room has been cleaned', context),
                _buildTenseRow('Tương lai đơn', 'She will clean the room', 'The room will be cleaned', context),
                _buildTenseRow('Modal verbs', 'She can clean the room', 'The room can be cleaned', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTenseRow(String tense, String active, String passive, BuildContext context) {
    return TableRow(
      children: [
        _buildTableCell(tense, context, isBold: true),
        _buildTableCell(active, context),
        _buildTableCell(passive, context),
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

  Widget _buildTableCell(String text, BuildContext context, {bool isBold = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isBold ? FontStyle.normal : FontStyle.italic,
          color: isDark ? Colors.white : null,
        ),
      ),
    );
  }

  Widget _buildExamplesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💡 Ví dụ minh họa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildExamplePair(
              context,
              'People speak English all over the world.',
              'English is spoken all over the world.',
            ),
            _buildExamplePair(
              context,
              'The company hired 10 new employees.',
              '10 new employees were hired (by the company).',
            ),
            _buildExamplePair(
              context,
              'Someone has stolen my bike.',
              'My bike has been stolen.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamplePair(BuildContext context, String active, String passive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('✓ ', style: TextStyle(color: Colors.blue[700])),
                Expanded(
                  child: Text(
                    active,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blue[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('→ ', style: TextStyle(color: Colors.orange[700])),
                Expanded(
                  child: Text(
                    passive,
                    style: TextStyle(fontSize: 13, color: Colors.orange[900]),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              'Quên "be" trong câu bị động',
              '❌ The house built in 1990.',
              '✅ The house was built in 1990.',
            ),
            _buildMistake(
              context,
              'Dùng sai dạng động từ',
              '❌ The book was wrote by him.',
              '✅ The book was written by him.',
            ),
            _buildMistake(
              context,
              'Dùng bị động không cần thiết',
              '❌ The ball was kicked by me.',
              '✅ I kicked the ball. (Tự nhiên hơn)',
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
}
