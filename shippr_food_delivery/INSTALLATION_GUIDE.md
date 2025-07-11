# 🚀 Hướng dẫn cài đặt ShippFR Food Delivery App

## 📦 Files có sẵn để tải về

Bạn có thể tải về dự án hoàn chỉnh qua 2 format:

1. **shippr_food_delivery_complete.zip** (37KB) - File ZIP thông thường
2. **shippr_food_delivery_complete.tar.gz** (23KB) - File TAR.GZ nén tốt hơn

## 🛠️ Hướng dẫn cài đặt nhanh

### Bước 1: Tải và giải nén
```bash
# Nếu tải file .zip
unzip shippr_food_delivery_complete.zip

# Nếu tải file .tar.gz  
tar -xzf shippr_food_delivery_complete.tar.gz
```

### Bước 2: Di chuyển vào thư mục
```bash
cd shippr_food_delivery
```

### Bước 3: Cài đặt Flutter dependencies
```bash
flutter pub get
```

### Bước 4: Cấu hình Firebase

1. **Tạo Firebase project**:
   - Truy cập [Firebase Console](https://console.firebase.google.com)
   - Tạo project mới tên "ShippFR"

2. **Thêm Android app**:
   - Package name: `com.shippr.food_delivery`
   - Tải file `google-services.json`
   - Đặt vào: `android/app/google-services.json`

3. **Kích hoạt services**:
   - Authentication > Sign-in method > Email/Password
   - Firestore Database > Create database
   - Storage > Get started
   - Cloud Messaging

### Bước 5: Cấu hình Google Maps (Optional)
```xml
<!-- Trong android/app/src/main/AndroidManifest.xml -->
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
```

### Bước 6: Chạy ứng dụng
```bash
flutter run
```

## 🎯 Cấu trúc dự án đã có

```
shippr_food_delivery/
├── lib/
│   ├── main.dart                   ✅ Entry point
│   ├── models/                     ✅ Data models
│   │   ├── user_model.dart
│   │   ├── food_model.dart
│   │   ├── cart_item.dart
│   │   └── order_model.dart
│   ├── services/                   ✅ Business logic
│   │   ├── firebase_service.dart
│   │   ├── auth_service.dart
│   │   ├── food_service.dart
│   │   ├── order_service.dart
│   │   └── cart_service.dart
│   ├── screens/                    ✅ UI Screens
│   │   ├── splash_screen.dart
│   │   ├── auth/
│   │   └── home/
│   ├── widgets/                    ✅ Components
│   └── utils/                      ✅ Theme & utilities
├── pubspec.yaml                    ✅ Dependencies
├── README.md                       ✅ Full documentation
└── android/                        ✅ Android config
```

## ✨ Tính năng đã implement

- ✅ **Splash Screen** với animation
- ✅ **Authentication** (Login/Register)
- ✅ **Home Screen** giống ShippFR
- ✅ **Cart Management** với Provider
- ✅ **Firebase Integration** đầy đủ
- ✅ **Order Management** system
- ✅ **User Management** (roles)
- ✅ **Payment Integration** ready
- ✅ **Notification System** setup

## 🚀 Chạy thử ngay

Sau khi hoàn thành các bước trên, ứng dụng sẽ có:

1. **Màn hình Splash** đẹp mắt
2. **Đăng nhập/Đăng ký** hoạt động
3. **Trang chủ** giống hệt ShippFR
4. **Navigation** với 5 tabs
5. **Cart counter** real-time

## 🔧 Troubleshooting

### Lỗi Firebase
```bash
# Nếu thiếu google-services.json
flutter pub get
flutter clean
flutter pub get
```

### Lỗi Dependencies
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### Lỗi Android Build
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## 📞 Hỗ trợ

Nếu gặp vấn đề, kiểm tra:
1. Flutter version >= 3.0.0
2. Dart version >= 3.0.0  
3. Android SDK đã cài đặt
4. Firebase project đã setup đúng

## 🎉 Next Steps

Sau khi chạy thành công, bạn có thể:
1. Thêm màn hình Cart, Orders, Profile
2. Implement payment gateway
3. Thêm real-time tracking
4. Deploy lên Play Store

---
**Happy Coding! 🚀**