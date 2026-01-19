import 'package:flutter/material.dart';

class WhQuestionsTableWidget extends StatelessWidget {
  const WhQuestionsTableWidget({super.key});

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
                _buildHeaderCell('Thì', flex: 3),
                _buildHeaderCell('Công thức', flex: 5),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Hiện tại đơn', 'Wh- + do/does + S + V?', 'What do you do? Where does he live?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Quá khứ đơn', 'Wh- + did + S + V?', 'When did you arrive? Why did she leave?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tương lai', 'Wh- + will + S + V?', 'Where will you go? When will they come?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('To be', 'Wh- + be + S?', 'Who is that? Where are you?'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Modal verbs', 'Wh- + can/should + S + V?', 'How can I help? What should I do?'),
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
          _buildDataCell(formula, flex: 5),
          _buildDataCell(example, flex: 4),
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
