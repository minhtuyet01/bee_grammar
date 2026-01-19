import 'package:flutter/material.dart';

class ConditionalsTableWidget extends StatelessWidget {
  const ConditionalsTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                _buildHeaderCell('Loại', flex: 2),
                _buildHeaderCell('Mệnh đề IF (Điều kiện)', flex: 4),
                _buildHeaderCell('Mệnh đề Chính (Kết quả)', flex: 4),
              ],
            ),
          ),
          
          // Type 0
          _buildDataRow(
            'Loại 0',
            'Hiện tại đơn\n(S + V)',
            'Hiện tại đơn\n(S + V)',
          ),
          _buildExampleRow('Ví dụ: If you heat water to 100°C, it boils.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Type 1
          _buildDataRow(
            'Loại 1',
            'Hiện tại đơn\n(S + V)',
            'Tương lai đơn\n(S + will + V)',
          ),
          _buildExampleRow('Ví dụ: If it rains, I will stay home.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Type 2
          _buildDataRow(
            'Loại 2',
            'Quá khứ đơn\n(S + V_ed/2)',
            'S + would/could + V',
          ),
          _buildExampleRow('Ví dụ: If I were rich, I would travel the world.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Type 3
          _buildDataRow(
            'Loại 3',
            'Quá khứ hoàn thành\n(S + had + P2)',
            'S + would/have + P2',
          ),
          _buildExampleRow('Ví dụ: If I had studied, I would have passed.'),
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
    String ifClause,
    String mainClause,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 2, isType: true),
          _buildDataCell(ifClause, flex: 4),
          _buildDataCell(mainClause, flex: 4),
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

  Widget _buildExampleRow(String example) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
          right: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Text(
        example,
        style: const TextStyle(
          fontSize: 13,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
