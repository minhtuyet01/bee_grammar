import 'package:flutter/material.dart';

class AdjectivesTableWidget extends StatelessWidget {
  const AdjectivesTableWidget({super.key});

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
                _buildHeaderCell('Loại tính từ', flex: 3),
                _buildHeaderCell('Chức năng', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Tính từ miêu tả (Descriptive)', 'Miêu tả tính chất', 'beautiful, big, happy, red, old'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tính từ số lượng (Quantitative)', 'Chỉ số lượng', 'many, few, some, several, enough'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tính từ chỉ định (Demonstrative)', 'Chỉ định đối tượng', 'this, that, these, those'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tính từ sở hữu (Possessive)', 'Chỉ sự sở hữu', 'my, your, his, her, its, our, their'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tính từ nghi vấn (Interrogative)', 'Dùng trong câu hỏi', 'which, what, whose'),
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
}
