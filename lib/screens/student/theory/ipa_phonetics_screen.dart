import 'package:flutter/material.dart';

class IPAPhoneticsScreen extends StatefulWidget {
  const IPAPhoneticsScreen({super.key});

  @override
  State<IPAPhoneticsScreen> createState() => _IPAPhoneticsScreenState();
}

class _IPAPhoneticsScreenState extends State<IPAPhoneticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng Phiên Âm IPA'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Nguyên âm'),
            Tab(text: 'Phụ âm'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVowelsTab(),
          _buildConsonantsTab(),
        ],
      ),
    );
  }

  Widget _buildVowelsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        _buildSectionTitle('Nguyên âm ngắn (Short Vowels)'),
        _buildIPATable([
          ['/ɪ/', '"i" ngắn', 'bit, sit, fish'],
          ['/e/', '"e" ngắn', 'bed, red, pen'],
          ['/æ/', '"a" rộng', 'cat, bad, hat'],
          ['/ʌ/', '"a" ngắn', 'cup, bus, love'],
          ['/ʊ/', '"u" ngắn', 'book, good, put'],
          ['/ɒ/', '"o" tròn', 'hot, dog, watch'],
          ['/ə/', '"ơ" nhẹ', 'about, sofa, banana'],
        ]),
        const SizedBox(height: 20),
        _buildSectionTitle('Nguyên âm dài (Long Vowels)'),
        _buildIPATable([
          ['/iː/', '"i" dài', 'see, eat, key'],
          ['/ɑː/', '"a" dài', 'car, father, palm'],
          ['/ɔː/', '"o" dài', 'door, four, born'],
          ['/uː/', '"u" dài', 'food, blue, through'],
          ['/ɜː/', '"ơ" dài', 'bird, work, nurse'],
        ]),
        const SizedBox(height: 20),
        _buildSectionTitle('Nguyên âm đôi (Diphthongs)'),
        _buildIPATable([
          ['/eɪ/', '"ei"', 'day, make, great'],
          ['/aɪ/', '"ai"', 'I, buy, night'],
          ['/ɔɪ/', '"oi"', 'boy, toy, choice'],
          ['/aʊ/', '"ao"', 'now, house, about'],
          ['/əʊ/', '"ou"', 'go, home, know'],
          ['/ɪə/', '"ia"', 'here, ear, beer'],
          ['/eə/', '"ea"', 'where, air, care'],
          ['/ʊə/', '"ua"', 'poor, tour, sure'],
        ]),
        const SizedBox(height: 20),
        _buildTipsCard(),
      ],
    );
  }

  Widget _buildConsonantsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Phụ âm cơ bản'),
        _buildIPATable([
          ['/p/', '"p"', 'pen, happy, stop'],
          ['/b/', '"b"', 'book, robber, web'],
          ['/t/', '"t"', 'tea, better, cat'],
          ['/d/', '"d"', 'dog, ladder, good'],
          ['/k/', '"k"', 'cat, key, book'],
          ['/g/', '"g"', 'go, bigger, dog'],
          ['/f/', '"f"', 'fish, coffee, enough'],
          ['/v/', '"v"', 'very, never, love'],
          ['/s/', '"s"', 'sun, miss, nice'],
          ['/z/', '"z"', 'zoo, easy, is'],
          ['/m/', '"m"', 'man, summer, home'],
          ['/n/', '"n"', 'no, dinner, sun'],
          ['/l/', '"l"', 'love, yellow, call'],
          ['/r/', '"r"', 'red, very, car'],
          ['/h/', '"h"', 'hot, behind'],
          ['/w/', '"w"', 'we, away'],
          ['/j/', '"y"', 'yes, use'],
        ]),
        const SizedBox(height: 20),
        _buildSectionTitle('Phụ âm đặc biệt (Người Việt dễ nhầm)'),
        _buildSpecialConsonantsTable(),
        const SizedBox(height: 20),
        _buildPronunciationTips(),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                'IPA là gì?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'IPA (International Phonetic Alphabet) là hệ thống ký hiệu phiên âm quốc tế, giúp bạn biết cách phát âm chính xác mỗi từ tiếng Anh.',
            style: TextStyle(color: Colors.blue[900], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIPATable(List<List<String>> data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Table(
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
                _buildTableHeader('IPA'),
                _buildTableHeader('Cách đọc'),
                _buildTableHeader('Ví dụ'),
              ],
            ),
            ...data.map((row) => TableRow(
                  children: [
                    _buildTableCell(row[0], isIPA: true),
                    _buildTableCell(row[1]),
                    _buildTableCell(row[2], isExample: true),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialConsonantsTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Table(
          border: TableBorder.all(color: Theme.of(context).dividerColor),
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2.5),
            3: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant),
              children: [
                _buildTableHeader('IPA'),
                _buildTableHeader('Cách đọc'),
                _buildTableHeader('Ví dụ'),
                _buildTableHeader('Lưu ý'),
              ],
            ),
            ...[
              ['/θ/', '"th" không rung', 'think, bath', 'Lưỡi chạm răng'],
              ['/ð/', '"th" rung', 'this, mother', 'Lưỡi chạm răng, rung'],
              ['/ʃ/', '"sh"', 'she, fish', 'Môi tròn'],
              ['/ʒ/', '"zh"', 'pleasure, vision', 'Như /ʃ/ nhưng rung'],
              ['/tʃ/', '"ch"', 'chair, teach', '"t" + "sh"'],
              ['/dʒ/', '"j"', 'job, bridge', '"d" + "zh"'],
              ['/ŋ/', '"ng"', 'sing, think', 'Âm mũi, không "g"'],
            ].map((row) => TableRow(
                  children: [
                    _buildTableCell(row[0], isIPA: true),
                    _buildTableCell(row[1]),
                    _buildTableCell(row[2], isExample: true),
                    _buildTableCell(row[3], isSmall: true),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text,
      {bool isIPA = false, bool isExample = false, bool isSmall = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmall ? 11 : 13,
          fontFamily: isIPA ? 'monospace' : null,
          fontStyle: isExample ? FontStyle.italic : null,
          fontWeight: isIPA ? FontWeight.bold : null,
        ),
        textAlign: isIPA ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
              const SizedBox(width: 8),
              Text(
                'Mẹo tra từ điển',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...[ 
            "Gặp /ː/ → kéo dài âm",
            "Gặp /ə/ → đọc nhẹ, không nhấn",
            "Dấu /'/ → trọng âm chính",
            "Dấu /,/ → trọng âm phụ",
          ].map((tip) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: Colors.amber[700])),
                    Expanded(
                      child: Text(
                        tip,
                        style: TextStyle(color: Colors.amber[900], fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPronunciationTips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.orange[700]!
              : Colors.orange[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.red[700]),
              const SizedBox(width: 8),
              Text(
                'Âm dễ nhầm với người Việt',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...[
            ['/θ/ vs /s/', 'think ≠ sink', 'Lưỡi chạm răng'],
            ['/v/ vs /w/', 'very ≠ wery', 'Răng trên chạm môi dưới'],
            ['/l/ vs /r/', 'light ≠ right', 'Lưỡi chạm lợi trên'],
            ['/ŋ/ cuối từ', 'sing ≠ sing-guh', 'Chỉ âm mũi, không "g"'],
          ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '❌ ${item[1]}',
                      style: TextStyle(color: Colors.red[800], fontSize: 12),
                    ),
                    Text(
                      '✅ ${item[2]}',
                      style: TextStyle(color: Colors.green[800], fontSize: 12),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
