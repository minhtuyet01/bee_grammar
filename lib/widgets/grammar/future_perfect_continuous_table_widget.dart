import 'package:flutter/material.dart';

class FuturePerfectContinuousTableWidget extends StatelessWidget {
  const FuturePerfectContinuousTableWidget({super.key});

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
                _buildHeaderCell('Cấu trúc', flex: 4),
              ],
            ),
          ),
          
          // Khẳng định
          _buildDataRow(
            'Khẳng định',
            'S + will/shall + have been + V-ing\nVí dụ: By 10 pm tonight, the kids will have been watching TV for an hour.',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Phủ định
          _buildDataRow(
            'Phủ định',
            'S + will/shall + not + have been + V-ing\nVí dụ: By 10 pm tonight, the kids will not have been watching TV for an hour.',
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Nghi vấn
          _buildDataRow(
            'Nghi vấn',
            'Will/Shall + S + have been + V-ing?\nVí dụ: Will our leader have been talking for nearly two hours by the time we get there?',
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

  Widget _buildDataRow(String type, String structure) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 2, isType: true),
          _buildDataCell(structure, flex: 4),
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
