# ShippFR - Food Delivery App

Ứng dụng giao đồ ăn ShippFR được phát triển bằng Flutter với Firebase backend, cung cấp đầy đủ các tính năng đặt đồ ăn, thanh toán, quản lý đơn hàng và giao hàng.

## ✨ Tính năng chính

### 👤 Cho khách hàng
- **🔐 Xác thực người dùng**: Đăng ký, đăng nhập với email/password
- **🏠 Trang chủ**: Giao diện hiện đại với các dịch vụ và danh mục món ăn
- **🍽️ Menu đồ ăn**: Duyệt và tìm kiếm món ăn theo danh mục
- **🛒 Giỏ hàng**: Thêm, xóa, cập nhật số lượng món ăn
- **💳 Thanh toán**: Tích hợp Razorpay cho thanh toán an toàn
- **📱 Theo dõi đơn hàng**: Xem trạng thái đơn hàng real-time
- **📍 Địa chỉ giao hàng**: Quản lý nhiều địa chỉ giao hàng
- **⭐ Đánh giá**: Đánh giá món ăn và dịch vụ
- **🔔 Thông báo**: Nhận thông báo về trạng thái đơn hàng

### 👨‍💼 Cho quản trị viên
- **📊 Dashboard**: Thống kê doanh thu, đơn hàng
- **🍕 Quản lý món ăn**: Thêm, sửa, xóa món ăn
- **📋 Quản lý đơn hàng**: Xem và cập nhật trạng thái đơn hàng
- **🏍️ Quản lý giao hàng**: Phân công shipper cho đơn hàng
- **👥 Quản lý người dùng**: Xem danh sách khách hàng và shipper

### 🏍️ Cho người giao hàng
- **📦 Danh sách đơn hàng**: Xem đơn hàng được phân công
- **🗺️ Bản đồ**: Tích hợp Google Maps để dẫn đường
- **✅ Cập nhật trạng thái**: Cập nhật trạng thái giao hàng
- **📞 Liên hệ khách hàng**: Gọi điện trực tiếp cho khách hàng

## 🏗️ Kiến trúc ứng dụng

### Frontend (Flutter)
```
lib/
├── main.dart                 # Entry point
├── models/                   # Data models
│   ├── user_model.dart
│   ├── food_model.dart
│   ├── cart_item.dart
│   └── order_model.dart
├── services/                 # Business logic
│   ├── firebase_service.dart
│   ├── auth_service.dart
│   ├── food_service.dart
│   ├── order_service.dart
│   └── cart_service.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── home/
│       └── home_screen.dart
├── widgets/                  # Reusable widgets
│   ├── service_card.dart
│   ├── category_card.dart
│   ├── food_card.dart
│   └── promo_banner.dart
└── utils/                    # Utilities
    └── app_theme.dart
```

### Backend (Firebase)
- **🔥 Firebase Authentication**: Quản lý người dùng
- **☁️ Cloud Firestore**: Database NoSQL
- **📁 Firebase Storage**: Lưu trữ hình ảnh
- **📱 Firebase Messaging**: Push notifications
- **📊 Firebase Analytics**: Phân tích người dùng

### Database Schema

#### Users Collection
```firestore
users/{userId}
├── id: string
├── name: string
├── email: string
├── phone: string
├── profileImage: string?
├── addresses: array<string>
├── role: string (customer/admin/delivery)
├── isActive: boolean
└── createdAt: timestamp
```

#### Foods Collection
```firestore
foods/{foodId}
├── id: string
├── name: string
├── description: string
├── price: number
├── category: string
├── images: array<string>
├── isAvailable: boolean
├── rating: number
├── reviewCount: number
├── ingredients: array<string>
├── cookingTime: string?
├── isVegetarian: boolean
├── isSpicy: boolean
├── nutritionInfo: object?
└── createdAt: timestamp
```

#### Orders Collection
```firestore
orders/{orderId}
├── id: string
├── customerId: string
├── items: array<CartItem>
├── subtotal: number
├── deliveryFee: number
├── tax: number
├── discount: number
├── total: number
├── deliveryAddress: string
├── deliveryLocation: object {lat, lng}
├── status: string (pending/confirmed/preparing/ready/pickedUp/outForDelivery/delivered/cancelled)
├── paymentStatus: string (pending/paid/failed/refunded)
├── paymentMethod: string
├── paymentTransactionId: string?
├── assignedDeliveryPersonId: string?
├── orderTime: timestamp
├── estimatedDeliveryTime: timestamp?
├── actualDeliveryTime: timestamp?
├── specialInstructions: string?
├── cancellationReason: string?
└── statusHistory: array<string>
```

## 🚀 Cài đặt và chạy

### Yêu cầu hệ thống
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- Firebase project

### Bước 1: Clone repository
```bash
git clone <repository-url>
cd shippr_food_delivery
```

### Bước 2: Cài đặt dependencies
```bash
flutter pub get
```

### Bước 3: Cấu hình Firebase
1. Tạo Firebase project tại [Firebase Console](https://console.firebase.google.com)
2. Thêm Android/iOS app vào project
3. Tải file `google-services.json` (Android) và `GoogleService-Info.plist` (iOS)
4. Đặt file vào thư mục tương ứng:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### Bước 4: Kích hoạt Firebase services
- Authentication (Email/Password)
- Cloud Firestore
- Firebase Storage
- Firebase Messaging

### Bước 5: Chạy ứng dụng
```bash
flutter run
```

## 🎨 Giao diện người dùng

### Màu sắc chính
- **Primary**: `#FF6B35` (Orange/Red giống ShippFR)
- **Secondary**: `#FFA726` (Light Orange)
- **Background**: `#F5F5F5` (Light Gray)
- **Success**: `#4CAF50` (Green)
- **Error**: `#E53935` (Red)

### Typography
- **Font chính**: Roboto
- **Heading**: Bold, 24-32px
- **Body**: Regular, 14-16px
- **Caption**: Light, 12px

## 📱 Screenshots

### Màn hình chính
- Header với logo ShippFR và thông tin vị trí
- Grid dịch vụ (Menu thức ăn, Giao hàng hộ, Gọi xe ôm, v.v.)
- Banner khuyến mãi
- Danh mục món ăn
- Món ăn phổ biến

### Các tính năng khác
- Đăng nhập/Đăng ký với validation
- Giỏ hàng với tính toán tự động
- Thanh toán an toàn
- Theo dõi đơn hàng real-time
- Profile management

## 🔧 Công nghệ sử dụng

### Frontend
- **Flutter**: Framework UI cross-platform
- **Provider**: State management
- **GetX**: Navigation và utilities
- **Cached Network Image**: Image caching
- **Flutter Rating Bar**: Rating widget
- **Shimmer**: Loading effects

### Backend & Services
- **Firebase**: Backend-as-a-Service
- **Razorpay**: Payment gateway
- **Google Maps**: Maps và navigation
- **Local Notifications**: Thông báo local

### Development Tools
- **Dart**: Programming language
- **Firebase CLI**: Firebase tools
- **Android Studio**: IDE
- **Git**: Version control

## 📊 Tính năng nâng cao

### Real-time Updates
- Trạng thái đơn hàng được cập nhật real-time
- Thông báo push khi có thay đổi
- Live tracking vị trí shipper

### Performance Optimization
- Image caching và lazy loading
- Pagination cho danh sách món ăn
- Efficient Firebase queries
- Background sync

### Security
- Firebase Security Rules
- Input validation
- Secure payment integration
- User role-based access control

## 🤝 Đóng góp

1. Fork repository
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 📞 Liên hệ

- **Email**: support@shippfr.com
- **Website**: https://shippfr.com
- **Phone**: +84 123 456 789

## 🚧 Roadmap

### Phase 1 (Completed)
- ✅ Basic UI/UX
- ✅ Authentication
- ✅ Food catalog
- ✅ Cart functionality
- ✅ Order management

### Phase 2 (In Progress)
- 🔄 Payment integration
- 🔄 Real-time tracking
- 🔄 Push notifications
- 🔄 Admin dashboard

### Phase 3 (Planned)
- 📅 Advanced analytics
- 📅 Loyalty program
- 📅 Multi-language support
- 📅 Voice ordering
- 📅 AI recommendations

---

**Phát triển bởi Team Sâu với ❤️ từ Việt Nam**