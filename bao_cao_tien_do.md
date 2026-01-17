# BÁO CÁO TIẾN ĐỘ THỰC TẬP
## Đề tài: Xây dựng ứng dụng hỗ trợ học ngữ pháp tiếng Anh cho người mới bắt đầu

---

## 1. Tóm tắt nội dung đã thực hiện được

Tại đơn vị thực tập đã tuân thủ đúng thời gian và địa điểm thực tập theo quyết định của nhà trường, chấp hành nghiêm túc nội quy, quy định của công ty và hoàn thành các công việc được giao và tìm hiểu nội dung nghiên cứu theo đúng đề tài khóa luận.

### Nghiên cứu và Tìm hiểu

- **Tìm hiểu về ứng dụng học ngữ pháp tiếng Anh**: Nghiên cứu các ứng dụng học ngữ pháp phổ biến như Duolingo, Grammarly để hiểu cách các ứng dụng này hoạt động và những gì người dùng cần khi học ngữ pháp tiếng Anh.

- **Nghiên cứu các công nghệ để xây dựng ứng dụng**:
  - **Flutter**: Công cụ để làm ứng dụng điện thoại có thể chạy được trên cả Android và iPhone
  - **Firebase**: Hệ thống lưu trữ và quản lý dữ liệu trên cloud, bao gồm:
    - Đăng nhập/đăng ký người dùng
    - Lưu trữ dữ liệu bài học và tiến độ học tập
    - Lưu hình ảnh và file âm thanh
    - Gửi thông báo đến người dùng
  - Các công cụ hỗ trợ khác để phát âm thanh, chọn ảnh, lưu dữ liệu trên điện thoại

### Hoàn thành Báo cáo

- **Hoàn thành báo cáo chương 1**: Tổng quan về các ứng dụng học ngữ pháp hiện có, xu hướng công nghệ và lý thuyết về phương pháp học ngữ pháp hiệu quả.

### Thiết kế Hệ thống

- **Phân tích và thiết kế**: 
  - Xác định 2 loại người dùng: Học viên và Quản trị viên
  - Vẽ sơ đồ các chức năng như học bài, làm bài tập, xem tiến độ
  - Thiết kế cách tổ chức dữ liệu trên hệ thống

- **Thiết kế cách lưu trữ dữ liệu**: 
  - Thông tin người dùng (tên, email, avatar)
  - 26 bài học ngữ pháp với đầy đủ nội dung
  - Tiến độ học tập của từng người
  - Hệ thống điểm thưởng và thành tích

- **Thiết kế giao diện**: 
  - Màn hình đăng nhập và đăng ký
  - Thanh điều hướng với 4 tab: Trang chủ, Học tập, Luyện tập, Hồ sơ
  - Các màn hình học bài và làm bài tập
  - Hỗ trợ chế độ sáng và tối với biểu tượng riêng

- **Hoàn thành báo cáo chương 2**: Phân tích và thiết kế hệ thống với đầy đủ sơ đồ và mô tả chi tiết.

### Xây dựng các Tính năng

- **Chức năng đăng nhập và đăng ký**:
  - Người dùng có thể đăng ký tài khoản bằng email
  - Đăng nhập vào ứng dụng
  - Quên mật khẩu và đổi mật khẩu
  - Phân quyền cho học viên và quản trị viên

- **Xây dựng nội dung ngữ pháp hoàn chỉnh**:
  - Xây dựng 26 bài học ngữ pháp được chia thành 5 nhóm chính:
    - **Nhóm 1 - Các thì trong tiếng Anh**: 12 bài (thì hiện tại đơn, hiện tại tiếp diễn, hiện tại hoàn thành, quá khứ đơn, quá khứ tiếp diễn, tương lai đơn, v.v.)
    - **Nhóm 2 - Các loại câu**: 5 bài (câu khẳng định, phủ định, nghi vấn, mệnh lệnh, câu hỏi WH-)
    - **Nhóm 3 - Các từ loại**: 6 bài (danh từ, động từ, tính từ, trạng từ, đại từ, mạo từ)
    - **Nhóm 4 - Cấu trúc đặc biệt**: 5 bài (câu bị động, câu điều kiện, so sánh, v.v.)
    - **Nhóm 5 - Giao tiếp thực tế**: 4 bài (cách dùng Would you like, How about, Let's, v.v.)
  - Mỗi bài đều có: Mục tiêu học, Lý thuyết, Công thức, Cách dùng, Ví dụ minh họa, Lỗi hay mắc phải

- **Hệ thống bài tập đa dạng giống Duolingo**:
  - **Trắc nghiệm**: Chọn 1 trong 4 đáp án đúng
  - **Sắp xếp câu**: Kéo thả các từ để tạo thành câu đúng
  - **Điền từ vào chỗ trống**: Gõ từ thích hợp vào câu có gợi ý

- **Theo dõi tiến độ học tập**:
  - Lưu lại bài nào đã học, bài nào chưa học
  - Ghi nhận điểm số và thời gian làm bài
  - Hiển thị biểu đồ trực quan về quá trình học

- **Các tính năng bổ sung**:
  - Quản lý thông tin cá nhân
  - Đổi ảnh đại diện
  - Chuyển đổi giữa tiếng Việt và tiếng Anh
  - Hệ thống điểm thưởng và huy hiệu
  - Nhận quà hàng ngày khi học đều
  - Bảng xếp hạng và theo dõi bạn bè

- **Trang quản trị cho Admin**:
  - Xem tổng quan hệ thống
  - Quản lý người dùng
  - Chỉnh sửa nội dung bài học
  - Gửi thông báo

---

## 2. Những nội dung đang thực hiện

### Hoàn thiện nội dung bài học

- **Bổ sung bài tập**: Hiện tại đã làm xong 7 bài tập cho khoảng 10 bài học (mỗi bài có 4 câu trắc nghiệm, 2 câu sắp xếp, 1 câu điền từ). Đang làm tiếp cho 16 bài học còn lại.

- **Hoàn thiện phần lý thuyết**: Bổ sung thêm công thức, ví dụ và lỗi sai thường gặp cho các bài chưa đầy đủ.

### Kết nối và Tối ưu hệ thống lưu trữ

- **Xây dựng các module kết nối với Firebase**:
  - Module quản lý đăng nhập/đăng ký
  - Module quản lý nội dung bài học
  - Module lưu tiến độ học tập
  - Module quản lý bạn bè và bảng xếp hạng
  - Module gửi thông báo

- **Cho phép học offline**: Lưu dữ liệu xuống điện thoại để người dùng có thể học khi không có mạng.

- **Tăng tốc độ ứng dụng**: 
  - Chỉ tải dữ liệu cần thiết thay vì tải hết một lúc
  - Chia nhỏ dữ liệu thành nhiều trang
  - Giảm số lần phải kết nối lên server

### Hoàn thiện giao diện

- **Thiết kế các màn hình**:
  - Danh sách bài học theo 5 nhóm ngữ pháp
  - Chi tiết bài học với lý thuyết và ví dụ
  - Làm bài tập tương tác
  - Kết quả bài làm với giải thích chi tiết
  - Biểu đồ theo dõi tiến độ

- **Chế độ sáng/tối**: Thiết kế icon và màu sắc đẹp cho cả 2 chế độ.

- **Cải thiện trải nghiệm sử dụng**:
  - Hiệu ứng chuyển màn hình mượt mà
  - Phản hồi rõ ràng khi người dùng nhấn nút
  - Biểu tượng loading khi đợi tải dữ liệu
  - Thông báo lỗi dễ hiểu

### Phát triển tính năng nâng cao

- **Bài tập nghe**: Tích hợp file âm thanh để người dùng có thể luyện nghe.

- **Yếu tố trò chơi hóa**: 
  - Hệ thống điểm số và chuỗi ngày học liên tục
  - Thành tích và huy hiệu khi hoàn thành mục tiêu
  - Quà tặng hàng ngày khuyến khích học đều
  - Bảng xếp hạng toàn ứng dụng và giữa bạn bè

- **Hỗ trợ 2 ngôn ngữ**: Người dùng có thể chuyển giao diện sang tiếng Việt hoặc tiếng Anh.

### Kiểm tra và Sửa lỗi

- **Kiểm tra các chức năng**: Đảm bảo đăng nhập, làm bài tập, lưu tiến độ hoạt động đúng.

- **Kiểm tra giao diện**: Xem ứng dụng hiển thị tốt trên các màn hình khác nhau.

- **Sửa các lỗi phát hiện được**: Xử lý lỗi kết nối, lỗi nhập liệu, lỗi hiển thị.

---

## 3. Những khó khăn vướng mắc

### Về Kỹ thuật

- **Chưa quen với Flutter và ngôn ngữ Dart**: 
  - Cú pháp viết code còn lạ, chưa thuộc các cách viết
  - Quản lý dữ liệu trong ứng dụng đôi khi bị lỗi không cập nhật giao diện
  - Chưa nắm vững cách hoạt động của các thành phần trong Flutter

- **Lưu trữ dữ liệu trên Firebase**:
  - Cách tổ chức dữ liệu khác với các hệ thống thông thường, cần thời gian để làm quen
  - Truy vấn dữ liệu phức tạp có nhiều giới hạn
  - Xử lý đồng bộ dữ liệu khi có và không có mạng còn gặp khó khăn
  - Lo ngại chi phí tăng cao nếu không tối ưu

- **Xử lý các tác vụ chờ đợi**: 
  - Viết code để chờ dữ liệu từ server trả về còn hay gặp lỗi
  - Quản lý trạng thái đang tải và báo lỗi chưa tốt

### Về Thiết kế

- **Kinh nghiệm thiết kế giao diện còn ít**:
  - Thiết kế giao diện cho nhiều kích thước màn hình còn khó
  - Chọn màu sắc, phông chữ, khoảng cách sao cho đẹp và dễ nhìn
  - Tạo hiệu ứng chuyển động mượt mà

- **Chế độ tối**: Đảm bảo màu sắc phù hợp, không quá chói hoặc quá tối.

### Về Nội dung

- **Tạo nội dung bài học chất lượng**:
  - 26 bài học với hơn 180 bài tập là khối lượng công việc rất lớn
  - Phải đảm bảo nội dung ngữ pháp và đáp án 100% chính xác
  - Tạo bài tập vừa sức cho người mới học (không quá khó)
  - Viết giải thích dễ hiểu cho từng câu hỏi

- **Cân bằng lý thuyết và thực hành**: Làm sao để bài học đủ kiến thức nhưng không quá dài và nhàm chán.

### Về Hiệu năng

- **Đo lường và cải thiện tốc độ ứng dụng**:
  - Chưa biết cách kiểm tra xem ứng dụng chạy nhanh hay chậm
  - Tải dữ liệu từng phần chưa thực sự hiệu quả
  - Xử lý hình ảnh và file âm thanh lớn làm chậm ứng dụng

### Về Thời gian

- **Sắp xếp công việc**: Phải cân đối giữa học công nghệ mới, viết code, thiết kế giao diện, tạo nội dung và viết báo cáo.

---

## 4. Hướng giải quyết

### Về Kỹ thuật

- **Học Flutter và Dart hiệu quả hơn**:
  - Đọc tài liệu hướng dẫn chính thức
  - Xem các bài hướng dẫn và mã nguồn mẫu từ cộng đồng
  - Làm các dự án nhỏ để thực hành
  - Dùng tính năng hot reload để thử nghiệm nhanh

- **Tối ưu việc sử dụng Firebase**:
  - Thiết kế cách tổ chức dữ liệu hợp lý để giảm số lần truy vấn
  - Sử dụng công cụ đánh chỉ mục để tăng tốc độ
  - Tải dữ liệu từng trang nhỏ thay vì tải hết
  - Lưu dữ liệu vào điện thoại để giảm truy vấn
  - Dùng công cụ mô phỏng Firebase để test không tốn tiền

- **Xử lý tốt hơn các tác vụ chờ đợi**:
  - Luôn bắt và xử lý lỗi khi gọi dữ liệu
  - Hiển thị biểu tượng loading khi đang chờ
  - Kiểm tra trạng thái trước khi cập nhật giao diện
  - Dùng các công cụ có sẵn để tự động cập nhật giao diện

### Về Thiết kế

- **Cải thiện kỹ năng thiết kế**:
  - Nghiên cứu các nguyên tắc thiết kế Material Design
  - Tham khảo các ứng dụng nổi tiếng như Duolingo, Busuu
  - Sử dụng công cụ debug để sửa lỗi giao diện
  - Test trên nhiều điện thoại khác nhau
  - Nhờ người dùng thật góp ý để cải thiện

- **Làm tốt chế độ tối**:
  - Định nghĩa rõ ràng màu sắc cho từng chế độ
  - Sử dụng màu động thay vì màu cố định
  - Tạo biểu tượng riêng cho từng chế độ

### Về Nội dung

- **Tạo bài học nhanh hơn**:
  - Dùng mẫu chuẩn cho mỗi loại bài học
  - Tái sử dụng cấu trúc bài tập (4 trắc nghiệm + 2 sắp xếp + 1 điền từ)
  - Tham khảo sách và website uy tín về ngữ pháp
  - Kiểm tra kỹ trước khi đưa vào ứng dụng

- **Quản lý nội dung hiệu quả**:
  - Lưu nội dung dạng file dễ chỉnh sửa
  - Tách riêng nội dung và code
  - Có thể tải nội dung mới từ server mà không cần cập nhật ứng dụng

### Về Hiệu năng

- **Làm ứng dụng chạy nhanh hơn**:
  - Sử dụng các kỹ thuật tối ưu để giảm số lần vẽ lại giao diện
  - Dùng danh sách thông minh cho dữ liệu nhiều
  - Nén và lưu tạm hình ảnh
  - Dùng công cụ phân tích để tìm điểm chậm
  - Chỉ tải những gì cần thiết ngay lập tức

### Về Triển khai

- **Chuẩn bị môi trường phát triển tốt**:
  - Dùng 2 hệ thống Firebase riêng cho phát triển và chính thức
  - Cấu hình phiên bản debug và release
  - Thiết lập quy trình tự động build và test
  - Viết test cho các chức năng quan trọng

- **Quản lý mã nguồn**:
  - Dùng Git để theo dõi các thay đổi
  - Chia nhánh rõ ràng cho từng tính năng
  - Kiểm tra code trước khi gộp vào nhánh chính

### Về Thời gian

- **Lập kế hoạch cụ thể**:
  - Chia nhỏ công việc thành từng việc nhỏ
  - Ưu tiên làm các chức năng quan trọng trước
  - Đặt deadline cho từng giai đoạn
  - Dành thời gian học và làm song song

---

## Tổng kết

Dự án đã hoàn thành được phần lớn các chức năng chính của ứng dụng học ngữ pháp tiếng Anh, bao gồm hệ thống đăng nhập, quản lý bài học, làm bài tập kiểu Duolingo, và theo dõi tiến độ. Hiện đang trong giai đoạn hoàn thiện nội dung, tăng tốc độ ứng dụng và làm cho trải nghiệm người dùng tốt hơn.

Các khó khăn chủ yếu là chưa quen với công nghệ mới (Flutter, Firebase), thiết kế giao diện, và khối lượng nội dung cần tạo rất lớn. Tuy nhiên, với việc chăm chỉ học hỏi, tham khảo tài liệu, và thực hành liên tục, dự án đang tiến triển tốt và hướng đến hoàn thành đầy đủ theo yêu cầu đề tài.
