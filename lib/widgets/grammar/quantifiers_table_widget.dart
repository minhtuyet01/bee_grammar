import 'package:flutter/material.dart';

class QuantifiersTableWidget extends StatelessWidget {
  const QuantifiersTableWidget({super.key});

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
                _buildHeaderCell('Lượng từ', flex: 3),
                _buildHeaderCell('Dùng với', flex: 2),
                _buildHeaderCell('Ví dụ', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('many', 'Danh từ đếm được', 'many books, many students, many cars'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('much', 'Danh từ không đếm được', 'much water, much time, much money'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('a lot of / lots of', 'Cả hai loại', 'a lot of books, lots of water'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('some', 'Cả hai (khẳng định)', 'some apples, some milk'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('any', 'Cả hai (phủ định, hỏi)', 'any questions, any water'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('few / a few', 'Danh từ đếm được', 'few people, a few books'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('little / a little', 'Danh từ không đếm được', 'little time, a little sugar'),
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

  Widget _buildDataRow(String quantifier, String usage, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(quantifier, flex: 3, isType: true),
          _buildDataCell(usage, flex: 2),
          _buildDataCell(examples, flex: 5),
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
