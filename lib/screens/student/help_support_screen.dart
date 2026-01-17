import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trợ giúp & Hỗ trợ'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Câu hỏi thường gặp',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildFAQItem(
            question: 'Làm sao để bắt đầu học ngữ pháp?',
            answer: 'Vào tab Trang Chủ, chọn một chủ đề ngữ pháp bạn muốn học. Mỗi bài học có 3 phần: Lý thuyết, Ví dụ và Bài tập.',
          ),
          
          _buildFAQItem(
            question: 'Streak là gì?',
            answer: 'Streak (chuỗi ngày) là số ngày liên tiếp bạn học trên ứng dụng. Hãy học mỗi ngày để duy trì streak của bạn!',
          ),
          
          _buildFAQItem(
            question: 'Làm sao để xem tiến độ học tập?',
            answer: 'Vào tab Hồ Sơ để xem streak và các thông tin học tập của bạn. Bạn cũng có thể xem lịch sử học tập và thống kê.',
          ),
          
          _buildFAQItem(
            question: 'Tôi có thể học offline không?',
            answer: 'Hiện tại ứng dụng cần kết nối internet để tải nội dung bài học. Chúng tôi đang phát triển tính năng học offline.',
          ),
          
          _buildFAQItem(
            question: 'Làm sao để thay đổi giao diện sáng/tối?',
            answer: 'Vào tab Hồ Sơ > Cài đặt > Giao diện. Bạn có thể chuyển đổi giữa chế độ sáng và tối.',
          ),
          
          _buildFAQItem(
            question: 'Tôi quên mật khẩu, phải làm sao?',
            answer: 'Vào tab Hồ Sơ > Tài khoản > Đổi mật khẩu. Bạn sẽ cần nhập mật khẩu cũ để đặt mật khẩu mới.',
          ),
          
          _buildFAQItem(
            question: 'Làm sao để liên hệ hỗ trợ?',
            answer: 'Bạn có thể gửi email đến support@beegrammar.com hoặc liên hệ qua fanpage Facebook của chúng tôi.',
          ),
          
          _buildFAQItem(
            question: 'Ứng dụng có miễn phí không?',
            answer: 'Có! BeeGrammar hoàn toàn miễn phí. Tất cả nội dung ngữ pháp đều có thể truy cập không giới hạn.',
          ),
          
          _buildFAQItem(
            question: 'Làm sao để cập nhật thông tin cá nhân?',
            answer: 'Vào tab Hồ Sơ > Tài khoản > Thông tin cá nhân. Bạn có thể cập nhật tên, email và các thông tin khác.',
          ),
          
          _buildFAQItem(
            question: 'Tôi gặp lỗi khi làm bài tập, phải làm sao?',
            answer: 'Hãy thử tải lại trang hoặc khởi động lại ứng dụng. Nếu vẫn gặp lỗi, vui lòng liên hệ đội ngũ hỗ trợ.',
          ),
          
          const SizedBox(height: 24),
          
          // Contact section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.support_agent, size: 48, color: Colors.blue),
                  const SizedBox(height: 12),
                  const Text(
                    'Cần thêm trợ giúp?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Liên hệ với chúng tôi qua email:\nsupport@beegrammar.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
