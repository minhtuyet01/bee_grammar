import 'package:flutter/material.dart';

class YesNoQuestionsTableWidget extends StatelessWidget {
  const YesNoQuestionsTableWidget({super.key});

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
                _buildHeaderCell('Thì/Động từ', flex: 3),
                _buildHeaderCell('Công thức', flex: 4),
                _buildHeaderCell('Ví dụ', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('To be (am/is/are)', 'Be + S + ...?', 'Are you a student? - Yes, I am. / No, I\'m not.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Hiện tại đơn', 'Do/Does + S + V?', 'Do you like coffee? - Yes, I do. / No, I don\'t.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Quá khứ đơn', 'Did + S + V?', 'Did you go there? - Yes, I did. / No, I didn\'t.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tương lai', 'Will + S + V?', 'Will you come? - Yes, I will. / No, I won\'t.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Modal verbs', 'Can/Could/Should + S + V?', 'Can you swim? - Yes, I can. / No, I can\'t.'),
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

  Widget _buildDataRow(String tense, String formula, String example) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(tense, flex: 3, isType: true),
          _buildDataCell(formula, flex: 4),
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
