import 'package:flutter/material.dart';

class RelativeClausesTableWidget extends StatelessWidget {
  const RelativeClausesTableWidget({super.key});

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
                _buildHeaderCell('Đại từ quan hệ', flex: 2),
                _buildHeaderCell('Thay thế', flex: 2),
                _buildHeaderCell('Công thức', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('who', 'Người (chủ ngữ)', 'N (người) + who + V'),
          _buildExampleRow('Ví dụ: The man who is standing there is my teacher.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('whom', 'Người (tân ngữ)', 'N (người) + whom + S + V'),
          _buildExampleRow('Ví dụ: The girl whom I met yesterday is my friend.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('which', 'Vật', 'N (vật) + which + V/S + V'),
          _buildExampleRow('Ví dụ: The book which I bought is interesting.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('that', 'Người/Vật', 'N + that + V/S + V'),
          _buildExampleRow('Ví dụ: The car that I like is expensive.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('whose', 'Sở hữu', 'N + whose + N + V'),
          _buildExampleRow('Ví dụ: The girl whose bag is red is my sister.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('where', 'Nơi chốn', 'N (nơi chốn) + where + S + V'),
          _buildExampleRow('Ví dụ: The house where I was born is very old.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('when', 'Thời gian', 'N (thời gian) + when + S + V'),
          _buildExampleRow('Ví dụ: The day when we met was wonderful.'),
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

  Widget _buildDataRow(String pronoun, String replaces, String formula) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(pronoun, flex: 2, isType: true),
          _buildDataCell(replaces, flex: 2),
          _buildDataCell(formula, flex: 4),
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
