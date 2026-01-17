import 'package:flutter/material.dart';
import 'theory/grammar_basic_screen.dart';
import 'theory/ipa_phonetics_screen.dart';
import 'theory/conditionals_screen.dart';
import 'theory/active_passive_screen.dart';
import 'theory/relative_clauses_screen.dart';

class TheoryDocumentsScreen extends StatefulWidget {
  const TheoryDocumentsScreen({super.key});

  @override
  State<TheoryDocumentsScreen> createState() => _TheoryDocumentsScreenState();
}

class _TheoryDocumentsScreenState extends State<TheoryDocumentsScreen> {
  final List<Map<String, dynamic>> _documents = [
    {
      'title': 'Ngữ pháp cơ bản',
      'subtitle': '12 thì tiếng Anh',
      'icon': Icons.book,
      'color': Colors.blue,
    },
    {
      'title': 'Bảng phiên âm IPA',
      'subtitle': 'Nguyên âm & Phụ âm',
      'icon': Icons.record_voice_over,
      'color': Colors.green,
    },
    {
      'title': 'Câu điều kiện',
      'subtitle': '4 loại câu điều kiện',
      'icon': Icons.alt_route,
      'color': Colors.orange,
    },
    {
      'title': 'Chủ động & Bị động',
      'subtitle': 'Chuyển đổi câu',
      'icon': Icons.swap_horiz,
      'color': Colors.purple,
    },
    {
      'title': 'Mệnh đề quan hệ',
      'subtitle': 'Đại từ quan hệ',
      'icon': Icons.link,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài liệu lý thuyết'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          final doc = _documents[index];
          return _buildDocumentCard(
            title: doc['title'],
            subtitle: doc['subtitle'],
            icon: doc['icon'],
            color: doc['color'],
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to specific screen based on title
          Widget? screen;
          
          switch (title) {
            case 'Ngữ pháp cơ bản':
              screen = const GrammarBasicScreen();
              break;
            case 'Bảng phiên âm IPA':
              screen = const IPAPhoneticsScreen();
              break;
            case 'Câu điều kiện':
              screen = const ConditionalsScreen();
              break;
            case 'Chủ động & Bị động':
              screen = const ActivePassiveScreen();
              break;
            case 'Mệnh đề quan hệ':
              screen = const RelativeClausesScreen();
              break;
          }
          
          if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen!),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Mở $title')),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),

                  // Title and subtitle
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
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
