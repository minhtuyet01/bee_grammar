import 'package:flutter/material.dart';
import 'practice_config_screen.dart';
import '../../data/grammar_content_service.dart';
import '../../models/grammar_lesson.dart';

class TopicSelectionScreen extends StatefulWidget {
  const TopicSelectionScreen({super.key});

  @override
  State<TopicSelectionScreen> createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen> {
  final GrammarContentService _contentService = GrammarContentService();
  List<GrammarCategory> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Icon mapping for categories
  final Map<String, IconData> _categoryIcons = {
    'cat_1': Icons.access_time,
    'cat_2': Icons.question_mark,
    'cat_3': Icons.swap_horiz,
    'cat_4': Icons.link,
    'cat_5': Icons.chat_bubble_outline,
  };

  // Color mapping for categories
  final Map<String, Color> _categoryColors = {
    'cat_1': Colors.blue,
    'cat_2': Colors.green,
    'cat_3': Colors.orange,
    'cat_4': Colors.purple,
    'cat_5': Colors.red,
  };

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final categories = await _contentService.getCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Không thể tải danh sách chủ đề: $e';
        _isLoading = false;
      });
    }
  }

  IconData _getIconForCategory(String categoryId) {
    return _categoryIcons[categoryId] ?? Icons.book;
  }

  Color _getColorForCategory(String categoryId) {
    return _categoryColors[categoryId] ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn chủ đề'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCategories,
            tooltip: 'Tải lại',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadCategories,
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_categories.isEmpty) {
      return const Center(
        child: Text('Không có chủ đề nào'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final icon = _getIconForCategory(category.id);
        final color = _getColorForCategory(category.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            title: Text(
              category.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: category.description.isNotEmpty
                ? Text(
                    category.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PracticeConfigScreen(
                    topicId: category.id,
                    topicTitle: category.title,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
