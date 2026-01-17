import 'package:flutter/material.dart';

class FormulaTableWidget extends StatelessWidget {
  const FormulaTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header row
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
                _buildHeaderCell('Loại câu', flex: 2),
                _buildHeaderCell('Động từ thường', flex: 3),
                _buildHeaderCell('Động từ "to be"', flex: 3),
              ],
            ),
          ),
          
          // Khẳng định
          _buildDataRow(
            'Khẳng định',
            'S + V (s/es) + O\nVí dụ: She goes to work at 7 am everyday.',
            'S + be (am/is/are) + O\nVí dụ: My mother is a teacher.',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Phủ định
          _buildDataRow(
            'Phủ định',
            'S + do not (don\'t) / does not (doesn\'t) + V-infi\nVí dụ: I don\'t like to eat fish.',
            'S + be (am/is/are) + not + O\nVí dụ: He is not a thief.',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Nghi vấn
          _buildDataRow(
            'Nghi vấn',
            'Do/Does + S + V-infi?\nVí dụ: Do you often play badminton?',
            'Am/Is/Are + S + O?\nVí dụ: Is he a doctor?',
          ),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDataRow(String type, String regular, String toBe) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 2, isType: true),
          _buildDataCell(regular, flex: 3),
          _buildDataCell(toBe, flex: 3),
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
