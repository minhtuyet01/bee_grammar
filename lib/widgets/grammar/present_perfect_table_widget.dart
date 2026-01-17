import 'package:flutter/material.dart';

class PresentPerfectTableWidget extends StatelessWidget {
  const PresentPerfectTableWidget({super.key});

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
                _buildHeaderCell('Cấu trúc', flex: 5),
              ],
            ),
          ),
          
          // Khẳng định
          _buildDataRow(
            'Khẳng định',
            'S + have/has + V3/ed + O\nVí dụ: He has lived in Paris for ten years',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Phủ định
          _buildDataRow(
            'Phủ định',
            'S + have/has + not + V3/ed\nVí dụ: He hasn\'t completed the assigned work.',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Nghi vấn
          _buildDataRow(
            'Nghi vấn',
            'Have/Has + S + V3/ed + O?\nVí dụ: Have you ever visited Vietnam?',
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

  Widget _buildDataRow(String type, String formula) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 2, isType: true),
          _buildDataCell(formula, flex: 5),
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
