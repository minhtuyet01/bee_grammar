import 'package:flutter/material.dart';

class WouldYouLikeTableWidget extends StatelessWidget {
  const WouldYouLikeTableWidget({super.key});

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
                _buildHeaderCell('Cách Dùng', flex: 2),
                _buildHeaderCell('Công Thức', flex: 3),
              ],
            ),
          ),
          _buildDataRow(
            'Mời làm gì',
            'Would you like + to V?\nVí dụ: Would you like to have dinner with me?\n(Bạn có muốn ăn tối với tôi không?)',
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          _buildDataRow(
            'Mời cái gì',
            'Would you like + N?\nVí dụ: Would you like some coffee?\n(Bạn có muốn chút cà phê không?)',
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDataRow(String usage, String formula) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(usage, flex: 2, isUsage: true),
          _buildDataCell(formula, flex: 3),
        ],
      ),
    );
  }

  Widget _buildDataCell(String text, {int flex = 1, bool isUsage = false}) {
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
            fontWeight: isUsage ? FontWeight.w600 : FontWeight.normal,
            height: 1.5,
          ),
          textAlign: isUsage ? TextAlign.center : TextAlign.left,
        ),
      ),
    );
  }
}
