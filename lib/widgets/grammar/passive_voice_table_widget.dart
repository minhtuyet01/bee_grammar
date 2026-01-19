import 'package:flutter/material.dart';

class PassiveVoiceTableWidget extends StatelessWidget {
  const PassiveVoiceTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table 1: Công thức gốc
        _buildFormulaTable(),
        
        const SizedBox(height: 16),
        
        // Transformation rules box
        _buildTransformationRulesBox(),
        
        const SizedBox(height: 16),
        
        // Table 2: Các loại câu
        _buildSentenceTypesTable(),
        
        const SizedBox(height: 16),
        
        // Table 3: Các thì thường dùng
        _buildCommonTensesTable(),
      ],
    );
  }

  Widget _buildFormulaTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: const Center(
              child: Text(
                'CÔNG THỨC GỐC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Active
          _buildFormulaRow('Chủ động:', 'S + V + O'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Passive
          _buildFormulaRow('Bị động:', 'S (tân ngữ cũ) + be + V3 + by O (chủ ngữ cũ)'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Example
          _buildExampleRow('Ví dụ: She writes a letter. → A letter is written by her.'),
        ],
      ),
    );
  }

  Widget _buildTransformationRulesBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        border: Border.all(color: Colors.amber.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
              const SizedBox(width: 8),
              const Text(
                'QUY TẮC CHUYỂN ĐỔI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRuleItem('1. Lấy Tân ngữ (O) câu chủ động → làm Chủ ngữ (S) câu bị động'),
          const SizedBox(height: 8),
          _buildRuleItem('2. Xác định thì của động từ chính → chia động từ "to be" theo thì đó'),
          const SizedBox(height: 8),
          _buildRuleItem('3. Động từ chính chuyển thành dạng Phân từ 2 (V_P2)'),
          const SizedBox(height: 8),
          _buildRuleItem('4. Chủ ngữ (S) câu chủ động → làm tân ngữ sau "by" (hoặc bỏ nếu không xác định)'),
        ],
      ),
    );
  }

  Widget _buildSentenceTypesTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
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
                _buildHeaderCell('Công thức', flex: 5),
              ],
            ),
          ),
          
          // Affirmative
          _buildDataRow('Khẳng định', 'S + be + V3 + by + O'),
          _buildExampleRow('Ví dụ: The book is read by many people.'),
          
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Question
          _buildDataRow('Câu hỏi', 'Be + S + V3 + by + O?'),
          _buildExampleRow('Ví dụ: Is the book read by many people?'),
        ],
      ),
    );
  }

  Widget _buildCommonTensesTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
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
                _buildHeaderCell('Thì', flex: 3),
                _buildHeaderCell('Công thức bị động', flex: 5),
              ],
            ),
          ),
          
          _buildDataRow('Hiện tại đơn', 'am/is/are + V3'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Quá khứ đơn', 'was/were + V3'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Tương lai', 'will be + V3'),
          Divider(height: 1, color: Colors.grey.shade300),
          
          _buildDataRow('Hiện tại hoàn thành', 'have/has been + V3'),
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

  Widget _buildFormulaRow(String label, String formula) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              formula,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String type, String formula) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDataCell(type, flex: type == 'Khẳng định' || type == 'Câu hỏi' ? 2 : 3, isType: true),
          _buildDataCell(formula, flex: type == 'Khẳng định' || type == 'Câu hỏi' ? 5 : 5),
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

  Widget _buildRuleItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: 14),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
