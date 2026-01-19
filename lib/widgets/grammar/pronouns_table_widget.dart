import 'package:flutter/material.dart';

class PronounsTableWidget extends StatelessWidget {
  const PronounsTableWidget({super.key});

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
                _buildHeaderCell('Loại đại từ', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('Đại từ nhân xưng (Personal)', 'I, you, he, she, it, we, they, me, him, her, us, them'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ sở hữu (Possessive)', 'mine, yours, his, hers, its, ours, theirs'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ phản thân (Reflexive)', 'myself, yourself, himself, herself, itself, ourselves, themselves'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ chỉ định (Demonstrative)', 'this, that, these, those'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ bất định (Indefinite)', 'someone, anyone, everyone, nobody, something, anything'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ quan hệ (Relative)', 'who, whom, which, that, whose'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Đại từ nghi vấn (Interrogative)', 'who, what, which, whose, whom'),
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

  Widget _buildDataRow(String type, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
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
