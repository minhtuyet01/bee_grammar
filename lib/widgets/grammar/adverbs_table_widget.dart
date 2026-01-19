import 'package:flutter/material.dart';

class AdverbsTableWidget extends StatelessWidget {
  const AdverbsTableWidget({super.key});

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
                _buildHeaderCell('Loại trạng từ', flex: 3),
                _buildHeaderCell('Trả lời câu hỏi', flex: 2),
                _buildHeaderCell('Ví dụ', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('Trạng từ cách thức (Manner)', 'How?', 'quickly, slowly, carefully, well, badly'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Trạng từ thời gian (Time)', 'When?', 'now, today, yesterday, tomorrow, soon, already'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Trạng từ nơi chốn (Place)', 'Where?', 'here, there, everywhere, outside, upstairs'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Trạng từ tần suất (Frequency)', 'How often?', 'always, usually, often, sometimes, never'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Trạng từ mức độ (Degree)', 'How much?', 'very, too, quite, almost, extremely, completely'),
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

  Widget _buildDataRow(String type, String question, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
          _buildDataCell(question, flex: 2),
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
