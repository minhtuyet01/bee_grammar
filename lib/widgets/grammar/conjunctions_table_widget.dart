import 'package:flutter/material.dart';

class ConjunctionsTableWidget extends StatelessWidget {
  const ConjunctionsTableWidget({super.key});

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
                _buildHeaderCell('Loại liên từ', flex: 3),
                _buildHeaderCell('Chức năng', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Liên từ kết hợp (Coordinating)', 'Nối 2 mệnh đề ngang nhau', 'and, but, or, so, for, nor, yet'),
          _buildExampleRow('Ví dụ: I like tea and coffee. She is tired but happy.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Liên từ phụ thuộc (Subordinating)', 'Nối mệnh đề phụ với mệnh đề chính', 'because, although, if, when, while, since, unless'),
          _buildExampleRow('Ví dụ: I stay home because it rains. Although he is rich, he is unhappy.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Liên từ tương quan (Correlative)', 'Dùng theo cặp', 'both...and, either...or, neither...nor, not only...but also'),
          _buildExampleRow('Ví dụ: Both Tom and Mary are students. Either you or I am wrong.'),
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

  Widget _buildDataRow(String type, String function, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
          _buildDataCell(function, flex: 3),
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
        style: const TextStyle(fontSize: 13, height: 1.5, fontStyle: FontStyle.italic),
      ),
    );
  }
}
