import 'package:flutter/material.dart';

class WishTableWidget extends StatelessWidget {
  const WishTableWidget({super.key});

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
                _buildHeaderCell('Thời điểm ước', flex: 3),
                _buildHeaderCell('Công thức', flex: 5),
              ],
            ),
          ),
          
          // Wish present
          _buildDataRow(
            'Hiện tại',
            'S1 + wish(es) + S2 + V_ed/2 (Quá khứ đơn)',
          ),
          _buildExampleRow('Ví dụ: I wish I were taller.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Wish future
          _buildDataRow(
            'Tương lai',
            'S1 + wish(es) + S2 + would/could + V',
          ),
          _buildExampleRow('Ví dụ: I wish it would stop raining.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Wish past
          _buildDataRow(
            'Quá khứ',
            'S1 + wish(es) + S2 + had + P2 (Quá khứ hoàn thành)',
          ),
          _buildExampleRow('Ví dụ: I wish I had studied harder.'),
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

  Widget _buildDataRow(String time, String formula) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(time, flex: 3, isType: true),
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
        style: const TextStyle(
          fontSize: 13,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
