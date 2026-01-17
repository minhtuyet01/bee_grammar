import 'package:flutter/material.dart';
import '../../../data/service_locator.dart';
import '../../../models/grammar_topic.dart';
import 'tense_detail_screen.dart';

class GrammarBasicScreen extends StatefulWidget {
  const GrammarBasicScreen({super.key});

  @override
  State<GrammarBasicScreen> createState() => _GrammarBasicScreenState();
}

class _GrammarBasicScreenState extends State<GrammarBasicScreen> {
  bool _isLoading = true;
  List<dynamic> _sections = [];

  @override
  void initState() {
    super.initState();
    _loadGrammarData();
  }

  Future<void> _loadGrammarData() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Update to use new grammar service structure
      // For now, using empty list to allow app to build
      setState(() {
        _sections = [];
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading grammar: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ngữ pháp cơ bản')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_sections.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ngữ pháp cơ bản')),
        body: const Center(child: Text('Không tải được dữ liệu')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ngữ pháp cơ bản'),
            Text(
              '12 thì tiếng Anh',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          final section = _sections[index];
          return _buildTenseCard(section, index);
        },
      ),
    );
  }

  Widget _buildTenseCard(section, int index) {
    // Color scheme for different tense groups
    Color getColor() {
      if (index < 4) return Colors.blue; // Present tenses
      if (index < 8) return Colors.orange; // Past tenses
      return Colors.green; // Future tenses
    }

    final color = getColor();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TenseDetailScreen(
                tense: section,
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
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.schedule, color: color, size: 24),
              ),
              const SizedBox(width: 16),

              // Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (section.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        section.subtitle!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
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
