Flow FE của bạn giờ nên là:
RegisterScreen
nhập email, username, password
gọi POST /api/v1/auth/register
OtpVerifyScreen
nhập OTP 6 số
gọi POST /api/v1/auth/verify
nếu success: lưu JWT ngay
sau verify
đọc nextStep hoặc profileCompleted
nếu chưa đủ profile -> vào CompleteProfileScreen
nếu đủ rồi -> vào HomeScreen
LoginScreen
gọi POST /api/v1/auth/login
nếu backend trả 403 USER_NOT_VERIFIED -> điều hướng về lại OtpVerifyScreen
Đây là chỗ quan trọng nhất:
đừng để FE tự đoán flow, hãy bám response backend.

1. Lưu token đúng cách
   Đừng lưu JWT trong shared_preferences nếu app thật.
   Nên dùng:
   flutter_secure_storage
   Lưu ít nhất:
   accessToken
   có thể thêm userId, email, username nếu bạn cần cache nhẹ
   Khi logout:
   xóa sạch token
   clear profile cache
2. Dùng interceptor cho API
   Nếu bạn dùng dio, hãy làm:
   một AuthInterceptor
   tự add header:
   Authorization: Bearer <token>
   Và centralize xử lý lỗi:
   401 -> logout / về login
   403 USER_NOT_VERIFIED -> về OTP verify
   400 INVALID_OTP -> hiện lỗi dưới ô OTP
   400 OTP_EXPIRED -> hiện nút “Gửi lại OTP”
3. Tách model response ngay từ đầu
   Backend hiện trả khá rõ:
   JwtResponse
   UserResponse
   Ở Flutter, nên map thành model riêng:
   AuthResponse
   UserProfile
   Đừng dùng raw map khắp app.
   Nếu làm bài bản:
   freezed + json_serializable
   Nếu muốn nhanh:
   class model + fromJson
4. Tách state auth và profile
   Đừng nhét hết vào một bloc/provider duy nhất.
   Tối thiểu nên tách:
   AuthState
   unauthenticated
   otpPending
   authenticated
   ProfileState
   loading
   incomplete
   completed
   Cái này giúp app dễ điều hướng hơn nhiều.
5. Ở OTP screen, nhớ xử lý edge cases
   Những case FE hay quên:
   OTP sai
   OTP hết hạn
   user bấm verify nhiều lần
   user quay lại login khi chưa verify
   app bị kill giữa chừng, mở lại vẫn biết đang ở bước nào
   Gợi ý:
   giữ pendingEmail local sau bước register
   nếu login trả USER_NOT_VERIFIED, tự đẩy email hiện tại sang màn OTP
6. Đừng hardcode text lỗi từ backend vào logic
   Ví dụ đừng check:
   "Tài khoản chưa được xác thực email"
   Nên check:
   status code
   hoặc nếu sau này bạn thêm errorCode vào response thì dùng errorCode
   Hiện nếu backend mới chỉ trả message, FE vẫn nên map theo status + route hiện tại, không nên phụ thuộc tuyệt đối vào text.
7. Làm form validation ở FE giống backend
   Nên match với backend:
   email đúng format
   username không rỗng, max 50
   password tối thiểu 6
   OTP đúng 6 số
   firstName / lastName không blank nếu nhập
   avatarUrl hợp lệ nếu bạn cho nhập text
   Làm sớm sẽ giảm rất nhiều request lỗi.
8. Complete profile xong thì refresh user
   Sau khi gọi:
   PATCH /api/v1/users/me/profile
   Nên gọi lại:
   GET /api/v1/users/me
   để state trong app đồng bộ 100% với backend, thay vì tự merge tay.
9. Flutter structure mình khuyên
   Nếu bạn muốn vừa nhanh vừa không loạn:
   lib/
   core/
   network/
   dio_client.dart
   auth_interceptor.dart
   storage/
   secure_storage_service.dart
   error/
   features/
   auth/
   data/
   domain/
   presentation/
   login/
   register/
   verify_otp/
   profile/
   data/
   presentation/
   home/
   shared/
   Nếu dùng:
   go_router
   dio
   flutter_secure_storage
   riverpod hoặc bloc
   thì stack này khá ổn.
10. Một mẹo rất đáng tiền
    Trong FE, tạo một hàm điều hướng chung kiểu:
    nếu profileCompleted == false hoặc nextStep == COMPLETE_PROFILE -> vào CompleteProfileScreen
    ngược lại -> HomeScreen
    Đừng rải logic này ở 4-5 chỗ.
11. Thứ tự implement Flutter mình khuyên
    Làm theo thứ tự này sẽ ít rối nhất:
    model + API client
    register screen
    verify otp screen
    secure token storage
    login screen
    auth guard / splash decide route
    get current user
    complete profile screen
    home screen
12. Điều cuối cùng
    Khi nối FE với backend auth, bug thường không nằm ở UI đẹp hay xấu.
    Nó nằm ở:
    token lifecycle
    state sau app restart
    điều hướng khi user chưa verify
    refresh profile sau update