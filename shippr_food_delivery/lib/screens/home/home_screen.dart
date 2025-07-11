import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/cart_service.dart';
import '../../utils/app_theme.dart';
import '../../widgets/service_card.dart';
import '../../widgets/category_card.dart';
import '../../widgets/food_card.dart';
import '../../widgets/promo_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _currentLocation = "Nhà Huynh Y";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildWelcomeSection(),
              const SizedBox(height: 24),
              _buildServiceGrid(),
              const SizedBox(height: 24),
              _buildPromoBanner(),
              const SizedBox(height: 24),
              _buildCategoriesSection(),
              const SizedBox(height: 24),
              _buildPopularFoodsSection(),
              const SizedBox(height: 100), // Bottom padding for navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              // Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delivery_dining,
                  color: AppTheme.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              
              // Location and time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '13:06',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Chào buổi trưa, $_currentLocation',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Mở bản đồ địa chỉ của Shippr',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chào bạn,',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Bạn muốn đặt gì hôm nay?',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: AppTheme.textSecondaryColor),
                SizedBox(width: 12),
                Text(
                  'Tìm kiếm món ăn...',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid() {
    final services = [
      {'title': 'Menu thức ăn', 'icon': Icons.restaurant_menu, 'color': Colors.red},
      {'title': 'Giao hàng hộ', 'icon': Icons.delivery_dining, 'color': Colors.orange},
      {'title': 'Gọi xe ôm', 'icon': Icons.motorcycle, 'color': Colors.blue},
      {'title': 'Mua theo yêu cầu', 'icon': Icons.shopping_bag, 'color': Colors.green},
      {'title': 'Đi chợ hộ', 'icon': Icons.shopping_cart, 'color': Colors.purple},
      {'title': 'Tìm thạch sạn', 'icon': Icons.store, 'color': Colors.teal},
      {'title': 'Xem nhà đất', 'icon': Icons.home, 'color': Colors.brown},
      {'title': 'Zalo App', 'icon': Icons.chat, 'color': Colors.blue},
      {'title': 'Fanpage App', 'icon': Icons.facebook, 'color': Colors.indigo},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dịch vụ của chúng tôi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(
                title: service['title'] as String,
                icon: service['icon'] as IconData,
                color: service['color'] as Color,
                onTap: () {
                  // Handle service tap
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const PromoBanner(
        title: 'Miễn phí Ship',
        subtitle: 'NỮ 1999',
        description: 'Cho đơn từ 199k+ được vé xem thông tin',
        voucherCode: 'NU1999',
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'name': 'Cơm', 'image': '🍚'},
      {'name': 'Phở', 'image': '🍜'},
      {'name': 'Bánh mì', 'image': '🥖'},
      {'name': 'Pizza', 'image': '🍕'},
      {'name': 'Gà rán', 'image': '🍗'},
      {'name': 'Đồ uống', 'image': '🥤'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Danh mục món ăn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  name: category['name'] as String,
                  emoji: category['image'] as String,
                  onTap: () {
                    // Navigate to category
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularFoodsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Món ăn phổ biến',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all foods
                },
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Popular foods list
          Column(
            children: [
              FoodCard(
                name: 'Cơm tấm sườn nướng',
                description: 'Cơm tấm sườn nướng thơm ngon với trứng ốp la',
                price: 45000,
                rating: 4.5,
                image: 'https://via.placeholder.com/150',
                onTap: () {
                  // Navigate to food detail
                },
              ),
              const SizedBox(height: 12),
              FoodCard(
                name: 'Phở bò tái',
                description: 'Phở bò tái với nước dùng trong, thơm ngon',
                price: 40000,
                rating: 4.7,
                image: 'https://via.placeholder.com/150',
                onTap: () {
                  // Navigate to food detail
                },
              ),
              const SizedBox(height: 12),
              FoodCard(
                name: 'Bánh mì thịt nướng',
                description: 'Bánh mì thịt nướng giòn rụm, đầy đủ rau củ',
                price: 25000,
                rating: 4.3,
                image: 'https://via.placeholder.com/150',
                onTap: () {
                  // Navigate to food detail
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartService>(
              builder: (context, cart, child) {
                return Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppTheme.errorColor,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            label: 'Giỏ hàng',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Lịch sử',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}