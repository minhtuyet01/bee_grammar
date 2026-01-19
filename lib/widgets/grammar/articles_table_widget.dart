import 'package:flutter/material.dart';

class ArticlesTableWidget extends StatelessWidget {
  const ArticlesTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
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
                _buildHeaderCell('Mạo từ', flex: 2),
                _buildHeaderCell('Cách dùng', flex: 4),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('a / an', 'Danh từ đếm được số ít, chưa xác định', 'a book, an apple, a student, an hour'),
          _buildExampleRow('Quy tắc: "a" trước phụ âm, "an" trước nguyên âm (a, e, i, o, u)'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('the', 'Danh từ đã xác định, duy nhất', 'the sun, the book (đã nhắc đến), the first'),
          _buildExampleRow('Dùng khi cả người nói và người nghe đều biết đối tượng nào'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Không dùng mạo từ', 'Danh từ chung chung, số nhiều, không đếm được', 'Books are useful. Water is important.'),
          _buildExampleRow('Không dùng với tên riêng, bữa ăn, môn thể thao, ngôn ngữ'),
        ],
      ),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDataRow(String article, String usage, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(article, flex: 2, isType: true),
          _buildDataCell(usage, flex: 4),
          _buildDataCell(examples, flex: 4),
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

  Widget _buildExampleRow(String note) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
          right: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(fontSize: 12, height: 1.5, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
