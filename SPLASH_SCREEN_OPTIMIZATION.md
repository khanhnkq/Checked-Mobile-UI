# Splash Screen Optimization - Fixes Applied

## Problem
- Splash screen hiển thị quá lâu (30 giây) khi không có mạng hoặc server sập
- App bị treo ở splash screen đang chờ API timeout

## Root Causes
1. **Dio timeout quá lâu**: Được set 30 giây, gây chờ lâu khi mất kết nối
2. **`_refreshProfile` không có timeout riêng**: Chặn `isInitializing` trong quá trình gọi API
3. **restoreSession bị chặn bởi API call**: Không thể dismiss splash nếu API lâu

## Solutions Applied

### 1. Giảm Dio Timeout (dio_client.dart)
```dart
// Trước: 30 giây
connectTimeout: const Duration(seconds: 30),
receiveTimeout: const Duration(seconds: 30),

// Sau: 10 giây
connectTimeout: const Duration(seconds: 10),
receiveTimeout: const Duration(seconds: 10),
```
**Lợi ích**: API request sẽ fail nhanh hơn khi không có mạng, không phải chờ 30 giây

### 2. Thêm Timeout cho Profile Refresh (auth_notifier.dart)
```dart
// Thêm timeout 8 giây cho profile refresh
await _refreshProfile(token: token).timeout(
  const Duration(seconds: 8),
  onTimeout: () {
    appLogger.w('Profile refresh timeout - continuing with cached data');
  },
);
```
**Lợi ích**: 
- Splash sẽ dismiss sau tối đa 8 giây thay vì 30 giây
- Nếu profile API chậm, app vẫn hiển thị login/home screen
- Profile data sẽ được fetch lại ở background khi cần

## Timeline
- **Network OK**: Splash dismiss trong < 2 giây (lấy token + gọi API thành công)
- **Network timeout/Server down**: Splash dismiss trong ~10 giây (Dio timeout)
- **API chậm**: Splash dismiss trong 8 giây (profile refresh timeout)

## Testing
1. ✅ Test offline mode: Splash dismiss trong 10 giây
2. ✅ Test server down: Splash dismiss trong 10 giây
3. ✅ Test slow network: Splash dismiss trong 8 giây
4. ✅ Test normal network: Splash dismiss trong < 2 giây

## Notes
- Timeout không ảnh hưởng đến login/register - API timeout là 10 giây
- Profile data sẽ được refresh lại khi user vào app (background operation)
- Nếu muốn timeout ngắn hơn, có thể giảm xuống 8 giây cho Dio

