import 'package:flutter/material.dart';

class ReportedSpeechTableWidget extends StatelessWidget {
  const ReportedSpeechTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main table
        Container(
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
                    _buildHeaderCell('Loại câu', flex: 2),
                    _buildHeaderCell('Công thức', flex: 5),
                  ],
                ),
              ),
              
              _buildDataRow('Trần thuật', 'S + said (that) + S + V (lùi thì)'),
              _buildExampleRow('Ví dụ: She said, "I am tired." → She said she was tired.'),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildDataRow('Câu hỏi Yes/No', 'S + asked + if/whether + S + V'),
              _buildExampleRow('Ví dụ: He asked, "Do you like coffee?" → He asked if I liked coffee.'),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildDataRow('Câu hỏi Wh-', 'S + asked + Wh- + S + V'),
              _buildExampleRow('Ví dụ: She asked, "Where do you live?" → She asked where I lived.'),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildDataRow('Mệnh lệnh', 'S + told + O + to V'),
              _buildExampleRow('Ví dụ: She said, "Open the book." → She told me to open the book.'),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Tense backshift table
        Container(
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
                padding: const EdgeInsets.all(12),
                child: const Center(
                  child: Text(
                    'BẢNG LÙI THÌ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('Simple Present', 'Simple Past'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('Present Continuous', 'Past Continuous'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('Present Perfect', 'Past Perfect'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('Simple Past', 'Past Perfect'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('will', 'would'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('can', 'could'),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Adverb conversion table
        Container(
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
                padding: const EdgeInsets.all(12),
                child: const Center(
                  child: Text(
                    'BẢNG ĐỔI TRẠNG TỪ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('today', 'that day'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('now', 'then'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('yesterday', 'the day before'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('tomorrow', 'the next day'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('here', 'there'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('this', 'that'),
              Divider(height: 1, color: Colors.grey.shade300),
              
              _buildTenseRow('these', 'those'),
            ],
          ),
        ),
      ],
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

  Widget _buildTenseRow(String from, String to) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              from,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              to,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
