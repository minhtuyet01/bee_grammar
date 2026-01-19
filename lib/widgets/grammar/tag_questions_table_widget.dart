import 'package:flutter/material.dart';

class TagQuestionsTableWidget extends StatelessWidget {
  const TagQuestionsTableWidget({super.key});

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
                _buildHeaderCell('Câu chính', flex: 3),
                _buildHeaderCell('Câu hỏi đuôi', flex: 2),
                _buildHeaderCell('Ví dụ', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('Khẳng định', 'Phủ định', 'You are a student, aren\'t you?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Phủ định', 'Khẳng định', 'You aren\'t tired, are you?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Có "to be"', 'be + S?', 'She is beautiful, isn\'t she?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Có modal verb', 'modal + S?', 'You can swim, can\'t you?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ thường', 'do/does/did + S?', 'They like coffee, don\'t they?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Let\'s', 'shall we?', 'Let\'s go, shall we?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Mệnh lệnh', 'will you?', 'Open the door, will you?'),
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

  Widget _buildDataRow(String mainClause, String tag, String example) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(mainClause, flex: 3, isType: true),
          _buildDataCell(tag, flex: 2),
          _buildDataCell(example, flex: 5),
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
