import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../data/learning_history_service.dart';
import '../../data/service_locator.dart';

class LearningHistoryScreen extends StatefulWidget {
  const LearningHistoryScreen({super.key});

  @override
  State<LearningHistoryScreen> createState() => _LearningHistoryScreenState();
}

class _LearningHistoryScreenState extends State<LearningHistoryScreen> {
  final _service = LearningHistoryService();
  
  // Filter state
  String? _selectedActivityType;
  String? _selectedCategory;
  String? _selectedTimeRange;
  
  // Categories from Firebase
  List<Map<String, String>> _categories = [];
  bool _loadingCategories = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        setState(() => _loadingCategories = false);
        return;
      }

      // Load categories from user's actual history (all collections)
      final categories = await _service.getUserCategories(userId);
      
      setState(() {
        _categories = categories;
        _loadingCategories = false;
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() => _loadingCategories = false);
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(
        selectedActivityType: _selectedActivityType,
        selectedCategory: _selectedCategory,
        selectedTimeRange: _selectedTimeRange,
        categories: _categories,
        onApply: (activityType, category, timeRange) {
          setState(() {
            _selectedActivityType = activityType;
            _selectedCategory = category;
            _selectedTimeRange = timeRange;
          });
          Navigator.pop(context);
        },
        onReset: () {
          setState(() {
            _selectedActivityType = null;
            _selectedCategory = null;
            _selectedTimeRange = null;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử học tập'),
        actions: [
          // Filter button with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterBottomSheet,
              ),
              if (_hasActiveFilters())
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _service.streamLearningHistory(
          userId: userId,
          categoryId: _selectedCategory,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi: ${snapshot.error}'),
            );
          }

          var history = snapshot.data ?? [];

          // Apply filters
          history = _applyFilters(history);

          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _hasActiveFilters() 
                        ? 'Không tìm thấy kết quả'
                        : 'Chưa có lịch sử học tập',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (_hasActiveFilters()) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedActivityType = null;
                          _selectedCategory = null;
                          _selectedTimeRange = null;
                        });
                      },
                      child: const Text('Xóa bộ lọc'),
                    ),
                  ],
                ],
              ),
            );
          }

          // Group by date
          final groupedHistory = _groupByDate(history);

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedHistory.length,
            itemBuilder: (context, index) {
              final group = groupedHistory[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date header
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 8, top: index == 0 ? 0 : 16),
                    child: Text(
                      group['date'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  // History items for this date
                  ...(group['items'] as List<Map<String, dynamic>>).map(
                    (item) => _buildHistoryCard(item),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  bool _hasActiveFilters() {
    return _selectedActivityType != null ||
        _selectedCategory != null ||
        _selectedTimeRange != null;
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> history) {
    var filtered = history;

    // Filter by activity type
  if (_selectedActivityType != null) {
    filtered = filtered.where((item) {
      final itemType = item['type'] as String?;
      final totalQuestions = item['totalQuestions'] ?? 0;
      
      // Determine activity type (same logic as _buildHistoryCard)
      String activityType;
      if (itemType == 'lesson') {
        activityType = 'study';
      } else if (itemType == 'practice') {
        activityType = 'practice';
      } else if (itemType == 'test' || itemType == 'mock_exam' || itemType == 'random_test') {
        activityType = 'test';
      } else {
        activityType = totalQuestions > 0 ? 'practice' : 'study';
      }
      
      return activityType == _selectedActivityType;
    }).toList();
  }

    // Filter by time range
    if (_selectedTimeRange != null) {
      final now = DateTime.now();
      DateTime? startDate;

      switch (_selectedTimeRange) {
        case 'today':
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case '7days':
          startDate = now.subtract(const Duration(days: 7));
          break;
        case '30days':
          startDate = now.subtract(const Duration(days: 30));
          break;
      }

      if (startDate != null) {
        filtered = filtered.where((item) {
          final completedAt = (item['completedAt'] as Timestamp).toDate();
          return completedAt.isAfter(startDate!);
        }).toList();
      }
    }

    return filtered;
  }

  List<Map<String, dynamic>> _groupByDate(List<Map<String, dynamic>> history) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final item in history) {
      final completedAt = (item['completedAt'] as Timestamp).toDate();
      final itemDate = DateTime(completedAt.year, completedAt.month, completedAt.day);

      String dateKey;
      if (itemDate == today) {
        dateKey = 'Hôm nay';
      } else if (itemDate == yesterday) {
        dateKey = 'Hôm qua';
      } else {
        dateKey = DateFormat('dd/MM/yyyy').format(completedAt);
      }

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(item);
    }

    return grouped.entries.map((entry) {
      return {
        'date': entry.key,
        'items': entry.value,
      };
    }).toList();
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    final completedAt = (item['completedAt'] as Timestamp).toDate();
    final correctAnswers = item['correctAnswers'] ?? 0;
    final totalQuestions = item['totalQuestions'] ?? 0;
    final timeSpent = item['timeSpent'] ?? 0;

    // Determine activity type based on item type
    String activityType;
    final itemType = item['type'] as String?;
    
    if (itemType == 'lesson') {
      activityType = 'study';  // Lessons from home = HỌC
    } else if (itemType == 'practice') {
      activityType = 'practice';  // Practice sessions = LUYỆN TẬP
    } else if (itemType == 'test' || itemType == 'mock_exam' || itemType == 'random_test') {
      activityType = 'test';  // Tests = KIỂM TRA
    } else {
      // Fallback: determine by totalQuestions
      activityType = totalQuestions > 0 ? 'practice' : 'study';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getActivityColor(activityType).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getActivityIcon(activityType),
                color: _getActivityColor(activityType),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity type label
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getActivityColor(activityType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getActivityLabel(activityType),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getActivityColor(activityType),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Title - handle different field names
                  Text(
                    item['lessonTitle'] ?? item['practiceTitle'] ?? item['testTitle'] ?? item['title'] ?? 'Không có tiêu đề',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Category - handle different field names
                  if ((item['categoryTitle'] ?? item['category'] ?? '').isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item['categoryTitle'] ?? item['category'] ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),

                  // Result and time
                  Row(
                    children: [
                      // Result
                      if (totalQuestions > 0) ...[
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: _getResultColor(correctAnswers, totalQuestions),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$correctAnswers/$totalQuestions câu',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getResultColor(correctAnswers, totalQuestions),
                          ),
                        ),
                      ] else ...[
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.green[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Hoàn thành',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                      const SizedBox(width: 12),

                      // Time
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(timeSpent),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Timestamp
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('HH:mm').format(completedAt),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'study':
        return Icons.menu_book;
      case 'practice':
        return Icons.edit_note;
      case 'test':
        return Icons.quiz;
      default:
        return Icons.school;
    }
  }

  String _getActivityLabel(String type) {
    switch (type) {
      case 'study':
        return 'HỌC LÝ THUYẾT';
      case 'practice':
        return 'LUYỆN TẬP';
      case 'test':
        return 'KIỂM TRA';
      default:
        return 'HỌC TẬP';
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'study':
        return const Color(0xFFD4A574);
      case 'practice':
        return Colors.blue;
      case 'test':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getResultColor(int correct, int total) {
    if (total == 0) return Colors.grey;
    final percentage = (correct / total * 100);
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '${minutes}p ${secs}s';
    }
    return '${secs}s';
  }
}

// Filter Bottom Sheet Widget
class _FilterBottomSheet extends StatefulWidget {
  final String? selectedActivityType;
  final String? selectedCategory;
  final String? selectedTimeRange;
  final List<Map<String, String>> categories;
  final Function(String?, String?, String?) onApply;
  final VoidCallback onReset;

  const _FilterBottomSheet({
    this.selectedActivityType,
    this.selectedCategory,
    this.selectedTimeRange,
    required this.categories,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _activityType;
  String? _category;
  String? _timeRange;

  @override
  void initState() {
    super.initState();
    _activityType = widget.selectedActivityType;
    _category = widget.selectedCategory;
    _timeRange = widget.selectedTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bộ lọc',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Activity Type Filter
          const Text(
            'Loại hoạt động',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildFilterChip(
                label: 'Học',
                value: 'study',
                selected: _activityType == 'study',
                onSelected: (selected) {
                  setState(() {
                    _activityType = selected ? 'study' : null;
                  });
                },
              ),
              _buildFilterChip(
                label: 'Luyện tập',
                value: 'practice',
                selected: _activityType == 'practice',
                onSelected: (selected) {
                  setState(() {
                    _activityType = selected ? 'practice' : null;
                  });
                },
              ),
              _buildFilterChip(
                label: 'Kiểm tra',
                value: 'test',
                selected: _activityType == 'test',
                onSelected: (selected) {
                  setState(() {
                    _activityType = selected ? 'test' : null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Category Filter
          const Text(
            'Chủ đề',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          widget.categories.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Chưa có chủ đề nào',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.categories.map((category) {
                    final categoryId = category['id']!;
                    final categoryTitle = category['title']!;
                    return _buildFilterChip(
                      label: categoryTitle,
                      value: categoryId,
                      selected: _category == categoryId,
                      onSelected: (selected) {
                        setState(() {
                          _category = selected ? categoryId : null;
                        });
                      },
                    );
                  }).toList(),
                ),
          const SizedBox(height: 24),

          // Time Range Filter
          const Text(
            'Thời gian',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildFilterChip(
                label: 'Hôm nay',
                value: 'today',
                selected: _timeRange == 'today',
                onSelected: (selected) {
                  setState(() {
                    _timeRange = selected ? 'today' : null;
                  });
                },
              ),
              _buildFilterChip(
                label: '7 ngày',
                value: '7days',
                selected: _timeRange == '7days',
                onSelected: (selected) {
                  setState(() {
                    _timeRange = selected ? '7days' : null;
                  });
                },
              ),
              _buildFilterChip(
                label: '30 ngày',
                value: '30days',
                selected: _timeRange == '30days',
                onSelected: (selected) {
                  setState(() {
                    _timeRange = selected ? '30days' : null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onReset,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFD4A574)),
                    foregroundColor: const Color(0xFFD4A574),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Đặt lại'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_activityType, _category, _timeRange);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Áp dụng'),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String value,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: const Color(0xFFD4A574).withOpacity(0.2),
      checkmarkColor: const Color(0xFFD4A574),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFFD4A574) : Colors.grey[700],
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
