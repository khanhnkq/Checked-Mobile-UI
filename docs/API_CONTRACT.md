# API Contract v2 - Locket Clone Backend (Flutter-ready)

Tai lieu nay mo ta contract API hien tai theo code backend da implement.

## 1) Tong quan

- Base URL local:

```text
http://localhost:8080
```

- Base URL tren dien thoai/emulator (vi du):

```text
http://192.168.1.60:8080
```

- Prefix API:

```text
/api/v1
```

- Kieu auth:

```http
Authorization: Bearer <JWT_TOKEN>
```

## 2) Security va pham vi endpoint

### Public endpoints (khong can token)
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/verify`
- `POST /api/v1/auth/login`

### Protected endpoints (can token)
- Tat ca endpoint con lai trong `users`, `photos`, `expense`.

---

## 3) Response models dung chung

### 3.1 `JwtResponse`

```json
{
  "token": "string",
  "type": "Bearer",
  "id": "uuid",
  "email": "string",
  "username": "string",
  "isVerified": true,
  "profileCompleted": false,
  "displayName": "string",
  "avatarUrl": "string | null",
  "nextStep": "COMPLETE_PROFILE | HOME"
}
```

### 3.2 `RegisterResponse`

```json
{
  "message": "Dang ky thanh cong, vui long kiem tra email de lay ma OTP",
  "email": "khanhnguyenkim30825@gmail.com",
  "nextStep": "VERIFY_OTP"
}
```

### 3.3 `UserResponse`

```json
{
  "id": "uuid",
  "email": "string",
  "username": "string",
  "firstName": "string | null",
  "lastName": "string | null",
  "displayName": "string",
  "avatarUrl": "string | null",
  "isVerified": true,
  "isGoldMember": false,
  "profileCompleted": true
}
```

### 3.4 `ErrorResponse`

```json
{
  "timestamp": "yyyy-MM-dd HH:mm:ss",
  "status": 400,
  "message": "string",
  "path": ""
}
```

---

## 4) Auth module

## `POST /api/v1/auth/register`

### Request

```json
{
  "email": "khanhnguyenkim30825@gmail.com",
  "username": "khanhnguyenkim30825",
  "password": "SnapWidget@123"
}
```

### Success
- `201 Created` -> `RegisterResponse`

### Loi thuong gap
- `400`: email/username da ton tai
- `400`: validate fail

---

## `POST /api/v1/auth/verify`

### Request

```json
{
  "email": "khanhnguyenkim30825@gmail.com",
  "otp": "482910"
}
```

### Success
- `200 OK` -> `JwtResponse`

### Loi thuong gap
- `400`: OTP sai hoac het han
- `404`: user khong ton tai

---

## `POST /api/v1/auth/login`

### Request

```json
{
  "emailOrUsername": "khanhnguyenkim30825@gmail.com",
  "password": "SnapWidget@123"
}
```

### Success
- `200 OK` -> `JwtResponse`

### Loi thuong gap
- `401`: sai thong tin dang nhap
- `403`: chua verify OTP
- `404`: user khong ton tai

---

## 5) User/Profile module

## `GET /api/v1/users/me`
- Tra user hien tai.
- `200 OK` -> `UserResponse`
- `401`: token thieu/sai/het han

---

## `PATCH /api/v1/users/me/profile`

### Request (tat ca field optional, nhung neu gui len thi khong duoc blank)

```json
{
  "username": "khanhnguyenkim30825",
  "firstName": "Khanh",
  "lastName": "Nguyen Kim",
  "avatarUrl": "https://example.com/avatar.jpg"
}
```

### Success
- `200 OK` -> `UserResponse`

### Loi thuong gap
- `400`: validate fail hoac username trung
- `401`: token khong hop le

> Ghi chu: endpoint nay duoc uu tien cho onboarding sau dang nhap lan dau.

---

## `GET /api/v1/users/{id}`
- Tra thong tin user theo id.
- `200 OK` -> `UserResponse`
- `404`: user khong ton tai

---

## `GET /api/v1/users/me/settings/personal-info`
- Endpoint cho man hinh Settings -> Personal info lay du lieu hien tai.
- `200 OK` -> `UserResponse`
- `401`: token thieu/sai/het han

---

## `PATCH /api/v1/users/me/settings/personal-info`

### Request (tat ca field optional, neu gui len thi khong duoc blank)

```json
{
  "username": "khanhnguyenkim30825",
  "firstName": "Khanh",
  "lastName": "Nguyen Kim"
}
```

### Success
- `200 OK` -> `UserResponse`

### Loi thuong gap
- `400`: validate fail hoac username trung
- `401`: token khong hop le

> Ghi chu: de cap nhat avatar, FE dung endpoint upload file ben duoi thay vi gui `avatarUrl`.

---

## `PATCH /api/v1/users/me/settings/avatar`

### Content-Type

```http
multipart/form-data
```

### Form fields
- `file` (bat buoc): `image/jpeg | image/png | image/webp`

### Success
- `200 OK` -> `UserResponse` (da cap nhat `avatarUrl` moi)

### Loi thuong gap
- `400`: file khong hop le
- `401`: token khong hop le
- `500`: upload storage that bai

---

## 6) Photo module

Tat ca endpoint photo deu la protected endpoint.

## `POST /api/v1/photos`

### Content-Type

```http
multipart/form-data
```

### Form fields
- `file` (bat buoc): `image/jpeg | image/png | image/webp`
- `caption` (optional)
- `amount` (optional, >= 0)
- `note` (optional)
- `categoryId` (optional, UUID)
- `recipientScope` (optional): `ALL_FRIENDS | SELECTED_FRIENDS`
- `audienceMode` (optional): alias cua `recipientScope` cho FE cu
- `recipientIds` (optional list UUID, bat buoc neu `SELECTED_FRIENDS`)
- `takenAt` (optional, ISO datetime)

### Rules
- Neu khong truyen `recipientScope`/`audienceMode` -> mac dinh `ALL_FRIENDS`.
- Sender luon duoc them vao recipients.
- `ALL_FRIENDS`: lay toan bo friend ACCEPTED, neu chua co ban thi van gui duoc (`recipientCount = 1`).
- `SELECTED_FRIENDS`: chi nhan `recipientIds` nam trong danh sach friend ACCEPTED.

### Success
- `201 Created` -> `PhotoResponse`

### Loi thuong gap
- `400`: file khong hop le
- `400`: amount < 0
- `400`: recipientIds khong hop le
- `401`: token khong hop le

---

## `GET /api/v1/photos/feed`
- Tra feed ma current user la recipient.
- **Pagination type: `Slice`** (da toi uu cho infinite scroll).

### Success
- `200 OK` -> `Slice<PhotoResponse>`

### Sample response (rut gon)

```json
{
  "content": [
    {
      "id": "photo-uuid",
      "senderId": "sender-uuid",
      "imageUrl": "https://...",
      "thumbnailUrl": "https://...",
      "caption": "Cafe sang",
      "amount": 45000,
      "recipientScope": "ALL_FRIENDS",
      "recipientCount": 3,
      "status": "READY",
      "takenAt": "2026-03-12T10:30:00",
      "createdAt": "2026-03-12T10:30:01"
    }
  ],
  "number": 0,
  "size": 20,
  "first": true,
  "last": false,
  "numberOfElements": 1,
  "empty": false
}
```

> Luu y: voi `Slice`, FE khong dua vao `totalElements/totalPages`.

---

## `GET /api/v1/photos/{photoId}`
- Tra chi tiet anh neu current user co quyen (sender hoac recipient).
- `200 OK` -> `PhotoResponse`
- `404`: khong ton tai/khong co quyen/xoa mem

---

## `GET /api/v1/photos/my-photos`
## `GET /api/v1/photos/me`
- Hai endpoint alias, cung tra lich su anh da gui.
- **Pagination type: `Page`**.
- `200 OK` -> `Page<PhotoResponse>`

---

## `PATCH /api/v1/photos/{photoId}/expense`
- Cap nhat metadata chi tieu cho anh (chi chu anh).

### Request

```json
{
  "amount": 65000,
  "note": "Lunch with team",
  "categoryId": "0f663a5a-9a62-45a8-9f48-afe8ed3ca5ec"
}
```

### Rules
- Chi sender moi duoc cap nhat.
- `amount` neu co phai >= 0.
- `categoryId` phai active va user co quyen dung.

### Success
- `200 OK` -> `PhotoResponse`

---

## 7) Expense module

Base path: `/api/v1/expense`

## `GET /api/v1/expense/categories`
- Tra danh sach category active (default + user own).
- `200 OK` -> `List<CategoryResponse>`

### `CategoryResponse`

```json
{
  "id": "uuid",
  "name": "Food",
  "icon": "restaurant",
  "color": "#FF8A65",
  "isDefault": true,
  "isActive": true
}
```

---

## `POST /api/v1/expense/categories`

### Request

```json
{
  "name": "Coffee",
  "icon": "coffee",
  "color": "#795548"
}
```

### Success
- `201 Created` -> `CategoryResponse`

---

## `PATCH /api/v1/expense/categories/{categoryId}`

### Request

```json
{
  "name": "Cafe",
  "icon": "coffee",
  "color": "#6D4C41",
  "isActive": true
}
```

### Success
- `200 OK` -> `CategoryResponse`

---

## `GET /api/v1/expense/budgets/{monthKey}`
- `monthKey` format: `yyyyMM` (vi du `202603`).
- `200 OK` -> `BudgetResponse`

### Sample

```json
{
  "monthKey": "202603",
  "amountLimit": 5000000,
  "alertThresholdPct": 80,
  "spent": 1250000,
  "remaining": 3750000,
  "exceeded": false
}
```

> Neu chua set budget thi mot so field co the `null`.

---

## `PUT /api/v1/expense/budgets/{monthKey}`

### Request

```json
{
  "amountLimit": 5000000,
  "alertThresholdPct": 80
}
```

### Success
- `200 OK` -> `BudgetResponse`

---

## `GET /api/v1/expense/entries?monthKey=202603`
- Tra page danh sach khoan chi trong thang.
- Du lieu nguon tu photo co `amount > 0`.
- `200 OK` -> `Page<ExpenseItemResponse>`

### Expense item sample

```json
{
  "photoId": "uuid",
  "imageUrl": "https://...",
  "thumbnailUrl": "https://...",
  "amount": 65000,
  "note": "Lunch with team",
  "categoryId": "uuid",
  "categoryName": "Food",
  "takenAt": "2026-03-16T12:30:00",
  "createdAt": "2026-03-16T12:30:02"
}
```

---

## `GET /api/v1/expense/summary?monthKey=202603`
- Tra tong quan chi tieu theo thang.
- `200 OK` -> `ExpenseSummaryResponse`

### Sample

```json
{
  "monthKey": "202603",
  "totalSpent": 1250000,
  "budgetLimit": 5000000,
  "remaining": 3750000,
  "budgetExceeded": false,
  "percentUsed": 25,
  "byCategory": [
    {
      "categoryId": "uuid",
      "categoryName": "Food",
      "totalAmount": 650000
    }
  ]
}
```

---

## 8) End-to-end flow de test nhanh

## Flow A - Onboarding
1. `POST /auth/register`
2. `POST /auth/verify`
3. `GET /users/me`
4. Neu `profileCompleted=false` -> `PATCH /users/me/profile`

## Flow A2 - Settings: Personal info
1. `GET /users/me/settings/personal-info`
2. User sua thong tin tren man hinh settings
3. `PATCH /users/me/settings/personal-info`
4. Neu user doi avatar -> `PATCH /users/me/settings/avatar` (multipart, chi gui file)
5. FE cap nhat state local tu `UserResponse`

## Flow B - Photo
1. `POST /photos` (multipart)
2. `GET /photos/feed` (Slice)
3. `GET /photos/{photoId}`
4. `PATCH /photos/{photoId}/expense` (optional)

## Flow C - Expense
1. `GET /expense/categories`
2. `PUT /expense/budgets/{monthKey}`
3. `GET /expense/entries?monthKey=yyyyMM`
4. `GET /expense/summary?monthKey=yyyyMM`

---

## 9) Flutter Dio mapping goi y

Public endpoints (khong gan token):
- `/api/v1/auth/register`
- `/api/v1/auth/verify`
- `/api/v1/auth/login`

Con lai phai gan:

```http
Authorization: Bearer <token>
```

Khuyen nghi FE cho pagination:
- Feed (`/photos/feed`): dung `Slice` theo `last=false` de load more.
- My Photos / Expense entries: dung `Page` neu can thong tin tong so trang.

---

## 10) Ghi chu version

- Ban nay da cap nhat dung implementation hien tai:
  - `GET /photos/feed` dung `Slice`
  - `GET /photos/my-photos` va `GET /photos/me` dung `Page`
  - Expense theo `monthKey=yyyyMM`
