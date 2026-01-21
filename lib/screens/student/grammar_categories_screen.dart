import 'package:flutter/material.dart';
import '../../data/grammar_content_service.dart';
import '../../models/grammar_lesson.dart';
import '../../widgets/skeleton_loading.dart';
import 'grammar_lessons_screen.dart';
import 'grammar_tenses_screen.dart';

class GrammarCategoriesScreen extends StatefulWidget {
  const GrammarCategoriesScreen({super.key});

  @override
  State<GrammarCategoriesScreen> createState() => _GrammarCategoriesScreenState();
}

class _GrammarCategoriesScreenState extends State<GrammarCategoriesScreen> {
  final _contentService = GrammarContentService();
  List<GrammarCategory> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      // Load from Firebase with caching
      final categories = await _contentService.getCategories(forceRefresh: true);
      
      // DEBUG: Check if categories have iconPath
      for (final cat in categories) {
        print('📦 Category ${cat.id}: iconPath = ${cat.iconPath}');
      }
      
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải dữ liệu: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _isLoading
          ? const CategoryListSkeleton(itemCount: 5)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return _buildCategoryCard(context, category);
              },
            ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, GrammarCategory category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => category.id == 'cat_1'
                  ? GrammarTensesScreen(category: category)
                  : GrammarLessonsScreen(category: category),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: category.iconPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          // Automatically switch between light_mode and dark_mode icons
                          category.iconPath!.replaceAll(
                            'light_mode',
                            Theme.of(context).brightness == Brightness.dark
                                ? 'dark_mode'
                                : 'light_mode',
                          ),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(category.icon, color: category.color, size: 32),
              ),
              const SizedBox(width: 16),

              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${category.lessonIds.length} bài học',
                      style: TextStyle(
                        fontSize: 12,
                        color: category.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
