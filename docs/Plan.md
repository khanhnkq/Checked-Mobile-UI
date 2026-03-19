# Plan FE - Locket (Cap Nhat 2026-03-19)

## 1) Muc tieu va nguyen tac

- Bam sat backend response, khong doan flow auth bang text loi.
- Migrate dan theo huong it rui ro (bridge), khong vo UX da chot.
- Tach ro trach nhiem theo MVVM: `data -> domain -> presentation`.
- Uu tien on dinh token lifecycle, session restart, dieu huong auth.

## 2) Trang thai da hoan thanh

- [x] Dung khung MVVM bridge cho `auth`.
  - Da co `repository/usecase/viewmodel`.
  - `AuthProvider` la compatibility alias sang `AuthViewModel`.
- [x] Dung khung MVVM bridge cho `home feed`.
  - Da co `photo_repository`, `fetch_feed/fetch_my_photos usecase`, `home_feed_view_model`.
- [x] Chuyen `camera` sang MVVM bridge.
  - Da co `camera_repository`, `initialize/capture/send usecase`, `camera_view_model`.
  - Upload tu preview da di qua ViewModel (khong goi service truc tiep trong UI).
- [x] Chuyen `expense` sang MVVM bridge day du.
  - Da co `expense_repository`, monthly data usecase, update budget/photo expense usecase, `expense_view_model`.
- [x] Tich hop thu vien theo huong thuc dung:
  - `logger`: central logger va thay `debugPrint` tai cac service/viewmodel chinh.
  - `equatable`: ap dung cho value object monthly expense result.
  - `google_fonts`: ap dung global text theme.
  - `flutter_svg`: logo da dung SVG asset.
  - `hive/hive_flutter`: luu app settings (`streaksEnabled`).
  - `flutter_riverpod`: app settings state notifier da duoc dung that.
  - `go_router`: da dung cho auth flow va nhieu route chinh.
  - `freezed/json_serializable`: da tao `AppSettingsModel` + generated files.

## 3) Dang lam va TODO uu tien

### Dang lam

- [~] Chuyen not `Navigator` sang `go_router` trong `profile/home`.

### TODO uu tien P0

- [ ] Chot migration `Navigator -> go_router` cho tat ca man hinh `profile/home` con lai.
- [ ] Chay lai full test sau batch route migration va fix regression neu co.
- [ ] Dung import thua sau khi route migration on dinh.

### TODO uu tien P1

- [ ] Chuan hoa central error mapping theo `statusCode + context route` (khong check raw message text).
- [ ] Hoan thien auth route guard trong `go_router` (redirect theo auth/profile state).
- [ ] Mo rong `equatable/freezed` cho cac model nghiep vu chinh (`auth/profile/photo/expense`).

### TODO uu tien P2

- [ ] Tien toi thay the provider bridge bang Riverpod Notifier theo tung feature.
- [ ] Chuan hoa DI (`core/di`) de bo khoi tao truc tiep trong ViewModel.

## 4) Flow Auth bat buoc bam backend

### Register

- Screen: `RegisterScreen`
- API: `POST /api/v1/auth/register`
- Ket qua: neu thanh cong -> chuyen OTP, giu `pendingEmail`.

### Verify OTP

- Screen: `OtpVerifyScreen`
- API: `POST /api/v1/auth/verify`
- Ket qua: neu thanh cong -> luu JWT ngay (secure storage).

### Sau Verify/Login

- Doc `nextStep` hoac `profileCompleted` tu response/profile.
- Neu chua complete profile -> `CompleteProfileScreen`.
- Neu da complete -> `HomeScreen`.

### Login

- Screen: `LoginScreen`
- API: `POST /api/v1/auth/login`
- Neu backend tra `403 USER_NOT_VERIFIED` -> dieu huong ve OTP.

## 5) Checklist ky thuat bat buoc

- [ ] Token chi luu trong `flutter_secure_storage`.
- [ ] Logout phai xoa token + clear profile/session cache.
- [ ] Interceptor tu add `Authorization: Bearer <token>` cho endpoint can auth.
- [ ] Xu ly trung tam:
  - [ ] `401` -> logout/ve login
  - [ ] `403 USER_NOT_VERIFIED` -> ve OTP
  - [ ] `400 INVALID_OTP` -> hien loi tai OTP field
  - [ ] `400 OTP_EXPIRED` -> cho resend OTP
- [ ] Khong hardcode text loi backend lam dieu kien logic.
- [ ] Validation FE dong bo voi backend (email, password >= 6, OTP 6 so, ...).
- [ ] Sau `PATCH /users/me/profile` phai refresh lai `GET /users/me`.

## 6) Ke hoach ngan han theo phase

### Phase A - Stabilize routing + auth guard (P0)

- Scope:
  - Hoan tat `go_router` cho profile/home.
  - Chot auth redirect va behavior khi app restart.
- Done criteria:
  - Khong con `Navigator.*` trong profile/home flow muc tieu.
  - Login/register/verify/complete profile/home di dung route.

### Phase B - Hardening auth/session (P0)

- Scope:
  - Chuan hoa error mapping + OTP edge cases.
  - Confirm token lifecycle on restart/logout/401.
- Done criteria:
  - Khong bi vang ve login sai khi token hop le.
  - OTP sai/het han/co mang yeu deu co UX ro rang.

### Phase C - MVVM clean-up + Riverpod migration tiep (P1)

- Scope:
  - Giam bridge, tang domain purity, bo khoi tao truc tiep trong ViewModel.
- Done criteria:
  - Feature moi khong goi service truc tiep trong UI.
  - Cau truc layer ro rang, import gon, test pass.

## 7) Rui ro chinh can theo doi

- Regression route khi replace Navigator trong cac flow co return value.
- State sai khi app resume/restart trong luc OTP pending.
- 401 callback logout xung dot voi redirect router.
- Drift giua state local va profile backend neu khong refresh sau update.

## 8) Ghi chu van hanh

- Uu tien merge theo feature nho, rollback theo tung phase.
- Moi dot chinh sua route/auth phai chay test va smoke test tay iOS/Android.
