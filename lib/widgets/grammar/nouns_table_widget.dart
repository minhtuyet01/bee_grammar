import 'package:flutter/material.dart';

class NounsTableWidget extends StatelessWidget {
  const NounsTableWidget({super.key});

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
                _buildHeaderCell('Loại danh từ', flex: 3),
                _buildHeaderCell('Đặc điểm', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Danh từ đếm được (Countable)', 'Có thể đếm, có số nhiều', 'book/books, cat/cats, student/students'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Danh từ không đếm được (Uncountable)', 'Không đếm, không có số nhiều', 'water, rice, information, advice'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Danh từ riêng (Proper)', 'Tên riêng, viết hoa', 'John, London, Monday, English'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Danh từ chung (Common)', 'Tên chung, không viết hoa', 'boy, city, day, language'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Danh từ trừu tượng (Abstract)', 'Không nhìn thấy, sờ được', 'love, happiness, freedom, knowledge'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Danh từ cụ thể (Concrete)', 'Nhìn thấy, sờ được', 'table, dog, flower, car'),
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

  Widget _buildDataRow(String type, String feature, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
          _buildDataCell(feature, flex: 3),
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
}
