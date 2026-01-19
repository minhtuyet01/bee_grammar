import 'package:flutter/material.dart';

class QuestionWordsTableWidget extends StatelessWidget {
  const QuestionWordsTableWidget({super.key});

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
                _buildHeaderCell('Từ để hỏi', flex: 2),
                _buildHeaderCell('Hỏi về', flex: 2),
                _buildHeaderCell('Ví dụ', flex: 6),
              ],
            ),
          ),
          
          _buildDataRow('Who', 'Người', 'Who is that? (Đó là ai?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('What', 'Vật, sự việc', 'What is this? (Đây là gì?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('When', 'Thời gian', 'When do you go? (Bạn đi khi nào?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Where', 'Nơi chốn', 'Where do you live? (Bạn sống ở đâu?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Why', 'Lý do', 'Why are you late? (Tại sao bạn muộn?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('How', 'Cách thức, mức độ', 'How are you? (Bạn khỏe không?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Which', 'Lựa chọn', 'Which color do you like? (Bạn thích màu nào?)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Whose', 'Sở hữu', 'Whose book is this? (Đây là sách của ai?)'),
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

  Widget _buildDataRow(String word, String meaning, String example) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(word, flex: 2, isType: true),
          _buildDataCell(meaning, flex: 2),
          _buildDataCell(example, flex: 6),
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
