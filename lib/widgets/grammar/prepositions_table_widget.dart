import 'package:flutter/material.dart';

class PrepositionsTableWidget extends StatelessWidget {
  const PrepositionsTableWidget({super.key});

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
                _buildHeaderCell('Loại giới từ', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 7),
              ],
            ),
          ),
          
          _buildDataRow('Giới từ thời gian', 'at (at 5pm), on (on Monday), in (in 2024), before, after, during, for, since'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Giới từ nơi chốn', 'at (at home), on (on the table), in (in the room), under, above, between, behind, in front of'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Giới từ chỉ hướng', 'to, from, into, out of, towards, through, across, along'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Giới từ chỉ phương tiện', 'by (by car, by bus), on (on foot), in (in a car)'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Giới từ khác', 'with, without, about, for, of, from, by'),
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
          _buildDataCell(examples, flex: 7),
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
