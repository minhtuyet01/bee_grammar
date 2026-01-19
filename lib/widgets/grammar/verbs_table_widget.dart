import 'package:flutter/material.dart';

class VerbsTableWidget extends StatelessWidget {
  const VerbsTableWidget({super.key});

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
                _buildHeaderCell('Loại động từ', flex: 3),
                _buildHeaderCell('Đặc điểm', flex: 3),
                _buildHeaderCell('Ví dụ', flex: 4),
              ],
            ),
          ),
          
          _buildDataRow('Động từ thường (Main Verb)', 'Diễn tả hành động, trạng thái', 'run, eat, sleep, study, work'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ "to be"', 'am, is, are, was, were', 'I am a student. She is happy.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ khiếm khuyết (Modal)', 'can, could, may, might, must, should, will, would', 'I can swim. You should study.'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ nối (Linking)', 'Nối chủ ngữ với tính từ', 'be, become, seem, appear, feel, look'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ trợ (Auxiliary)', 'Giúp tạo thì, thể', 'do, does, did, have, has, had'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ nội động (Intransitive)', 'Không cần tân ngữ', 'sleep, arrive, die, laugh'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Động từ ngoại động (Transitive)', 'Cần tân ngữ', 'eat, buy, read, write'),
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

  Widget _buildDataRow(String type, String feature, String examples) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: 3, isType: true),
          _buildDataCell(feature, flex: 3),
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
