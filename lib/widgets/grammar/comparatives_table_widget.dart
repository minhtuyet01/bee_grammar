import 'package:flutter/material.dart';

class ComparativesTableWidget extends StatelessWidget {
  const ComparativesTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main comparison table
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Header row
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    _buildHeaderCell('Loại so sánh', flex: 2),
                    _buildHeaderCell('Trường hợp', flex: 2),
                    _buildHeaderCell('Công thức', flex: 3),
                  ],
                ),
              ),
              
              // So sánh bằng
              _buildDataRow(
                'So sánh bằng',
                'Mọi trường hợp',
                'S + V + as + Adj/Adv + as + ...\nVí dụ: She is as tall as her sister.',
                rowSpan: 1,
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              // So sánh hơn - Tính từ ngắn
              _buildDataRow(
                'So sánh hơn',
                'Tính từ/Trạng từ ngắn',
                'S + V + Adj/Adv-er + than + O\nVí dụ: She is taller than me.',
                rowSpan: 2,
                isFirstRow: true,
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              // So sánh hơn - Tính từ dài
              _buildDataRow(
                '',
                'Tính từ/Trạng từ dài',
                'S + V + more + Adj/Adv + than + O\nVí dụ: This book is more interesting than that one.',
                rowSpan: 2,
                isFirstRow: false,
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              // So sánh nhất - Tính từ ngắn
              _buildDataRow(
                'So sánh nhất',
                'Tính từ/Trạng từ ngắn',
                'S + V + the + Adj/Adv-est\nVí dụ: He is the tallest in the class.',
                rowSpan: 2,
                isFirstRow: true,
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              // So sánh nhất - Tính từ dài
              _buildDataRow(
                '',
                'Tính từ/Trạng từ dài',
                'S + V + the most + Adj/Adv\nVí dụ: This is the most beautiful place.',
                rowSpan: 2,
                isFirstRow: false,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Note box for suffix rules
        Container(
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            border: Border.all(color: Colors.amber.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'LƯU Ý QUY TẮC THÊM ĐUÔI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildNoteItem('Kết thúc bằng -y: Đổi thành -i rồi thêm er/est'),
              const SizedBox(height: 4),
              _buildNoteItem('  Ví dụ: happy → happier → happiest', isExample: true),
              const SizedBox(height: 8),
              _buildNoteItem('Kết thúc bằng -er, -ow: Thêm er/est'),
              const SizedBox(height: 4),
              _buildNoteItem('  Ví dụ: clever → cleverer → cleverest', isExample: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDataRow(
    String type,
    String condition,
    String formula, {
    int rowSpan = 1,
    bool isFirstRow = true,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (type.isNotEmpty)
            _buildDataCell(type, flex: 2, isType: true)
          else
            Expanded(flex: 2, child: Container()),
          _buildDataCell(condition, flex: 2),
          _buildDataCell(formula, flex: 3),
        ],
      ),
    );
  }

  Widget _buildDataCell(String text, {int flex = 1, bool isType = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isType ? FontWeight.w600 : FontWeight.normal,
            height: 1.5,
          ),
          textAlign: isType ? TextAlign.center : TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildNoteItem(String text, {bool isExample = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(
            fontSize: 14,
            color: isExample ? Colors.grey.shade600 : Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: isExample ? Colors.grey.shade600 : Colors.black87,
              fontStyle: isExample ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
