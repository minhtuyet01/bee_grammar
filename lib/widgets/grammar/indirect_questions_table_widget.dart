import 'package:flutter/material.dart';

class IndirectQuestionsTableWidget extends StatelessWidget {
  const IndirectQuestionsTableWidget({super.key});

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
                _buildHeaderCell('Loại câu hỏi', flex: 3),
                _buildHeaderCell('Công thức', flex: 5),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Yes/No trực tiếp', 'Cụm lịch sự + if/whether + S + V', 'Can you tell me if she is here?'),
          _buildExampleRow('Câu trực tiếp: Is she here?'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Wh- trực tiếp', 'Cụm lịch sự + Wh- + S + V', 'Do you know where he lives?'),
          _buildExampleRow('Câu trực tiếp: Where does he live?'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Cụm lịch sự thường dùng', 'Can you tell me...? / Do you know...? / Could you explain...?', 'Could you explain how this works?'),
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

  Widget _buildDataRow(String type, String formula, String example) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
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

  Widget _buildExampleRow(String note) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
          right: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_forward, size: 16, color: Colors.blue.shade700),
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
