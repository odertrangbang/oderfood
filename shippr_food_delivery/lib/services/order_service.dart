import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../models/cart_item.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<String> createOrder({
    required List<CartItem> items,
    required String deliveryAddress,
    required Map<String, double> deliveryLocation,
    required String paymentMethod,
    String? specialInstructions,
  }) async {
    try {
      final user = _authService.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final orderId = _firestore.collection('orders').doc().id;
      final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
      final deliveryFee = 25000.0; // 25k VND
      final tax = subtotal * 0.1; // 10% tax
      const discount = 0.0;
      final total = subtotal + deliveryFee + tax - discount;

      final order = OrderModel(
        id: orderId,
        customerId: user.uid,
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        tax: tax,
        discount: discount,
        total: total,
        deliveryAddress: deliveryAddress,
        deliveryLocation: deliveryLocation,
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: paymentMethod,
        orderTime: DateTime.now(),
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
        specialInstructions: specialInstructions,
        statusHistory: ['Order placed at ${DateTime.now().toIso8601String()}'],
      );

      await _firestore.collection('orders').doc(orderId).set(order.toMap());
      return orderId;
    } catch (e) {
      print('Create order error: $e');
      rethrow;
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final order = await getOrderById(orderId);
      if (order == null) throw Exception('Order not found');

      final updatedStatusHistory = [...order.statusHistory];
      updatedStatusHistory.add('${newStatus.toString().split('.').last} at ${DateTime.now().toIso8601String()}');

      final updates = {
        'status': newStatus.toString(),
        'statusHistory': updatedStatusHistory,
      };

      if (newStatus == OrderStatus.delivered) {
        updates['actualDeliveryTime'] = DateTime.now().millisecondsSinceEpoch;
      }

      await _firestore.collection('orders').doc(orderId).update(updates);
    } catch (e) {
      print('Update order status error: $e');
      rethrow;
    }
  }

  Future<void> updatePaymentStatus(String orderId, PaymentStatus newStatus, {String? transactionId}) async {
    try {
      final updates = {
        'paymentStatus': newStatus.toString(),
      };

      if (transactionId != null) {
        updates['paymentTransactionId'] = transactionId;
      }

      await _firestore.collection('orders').doc(orderId).update(updates);

      if (newStatus == PaymentStatus.paid) {
        await updateOrderStatus(orderId, OrderStatus.confirmed);
      }
    } catch (e) {
      print('Update payment status error: $e');
      rethrow;
    }
  }

  Future<void> assignDeliveryPerson(String orderId, String deliveryPersonId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'assignedDeliveryPersonId': deliveryPersonId,
      });

      await updateOrderStatus(orderId, OrderStatus.pickedUp);
    } catch (e) {
      print('Assign delivery person error: $e');
      rethrow;
    }
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return OrderModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Get order by ID error: $e');
      return null;
    }
  }

  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('orders')
          .where('customerId', isEqualTo: userId)
          .orderBy('orderTime', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get user orders error: $e');
      return [];
    }
  }

  Future<List<OrderModel>> getActiveOrders() async {
    try {
      final querySnapshot = await _firestore
          .collection('orders')
          .where('status', whereIn: [
            OrderStatus.pending.toString(),
            OrderStatus.confirmed.toString(),
            OrderStatus.preparing.toString(),
            OrderStatus.ready.toString(),
            OrderStatus.pickedUp.toString(),
            OrderStatus.outForDelivery.toString(),
          ])
          .orderBy('orderTime', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get active orders error: $e');
      return [];
    }
  }

  Future<List<OrderModel>> getDeliveryPersonOrders(String deliveryPersonId) async {
    try {
      final querySnapshot = await _firestore
          .collection('orders')
          .where('assignedDeliveryPersonId', isEqualTo: deliveryPersonId)
          .where('status', whereIn: [
            OrderStatus.pickedUp.toString(),
            OrderStatus.outForDelivery.toString(),
          ])
          .orderBy('orderTime', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Get delivery person orders error: $e');
      return [];
    }
  }

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    return _firestore
        .collection('orders')
        .where('customerId', isEqualTo: userId)
        .orderBy('orderTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  Stream<List<OrderModel>> getActiveOrdersStream() {
    return _firestore
        .collection('orders')
        .where('status', whereIn: [
          OrderStatus.pending.toString(),
          OrderStatus.confirmed.toString(),
          OrderStatus.preparing.toString(),
          OrderStatus.ready.toString(),
          OrderStatus.pickedUp.toString(),
          OrderStatus.outForDelivery.toString(),
        ])
        .orderBy('orderTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> cancelOrder(String orderId, String reason) async {
    try {
      final order = await getOrderById(orderId);
      if (order == null) throw Exception('Order not found');

      if (order.status == OrderStatus.delivered || order.status == OrderStatus.cancelled) {
        throw Exception('Cannot cancel order in current status');
      }

      final updatedStatusHistory = [...order.statusHistory];
      updatedStatusHistory.add('Cancelled: $reason at ${DateTime.now().toIso8601String()}');

      await _firestore.collection('orders').doc(orderId).update({
        'status': OrderStatus.cancelled.toString(),
        'cancellationReason': reason,
        'statusHistory': updatedStatusHistory,
      });

      // If payment was made, initiate refund
      if (order.paymentStatus == PaymentStatus.paid) {
        await updatePaymentStatus(orderId, PaymentStatus.refunded);
      }
    } catch (e) {
      print('Cancel order error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getOrderStatistics() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final todayOrders = await _firestore
          .collection('orders')
          .where('orderTime', isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch)
          .where('orderTime', isLessThan: endOfDay.millisecondsSinceEpoch)
          .get();

      final totalOrders = await _firestore.collection('orders').get();
      final activeOrders = await getActiveOrders();

      double todayRevenue = 0.0;
      double totalRevenue = 0.0;

      for (var doc in todayOrders.docs) {
        final order = OrderModel.fromMap(doc.data());
        if (order.paymentStatus == PaymentStatus.paid) {
          todayRevenue += order.total;
        }
      }

      for (var doc in totalOrders.docs) {
        final order = OrderModel.fromMap(doc.data());
        if (order.paymentStatus == PaymentStatus.paid) {
          totalRevenue += order.total;
        }
      }

      return {
        'todayOrders': todayOrders.docs.length,
        'totalOrders': totalOrders.docs.length,
        'activeOrders': activeOrders.length,
        'todayRevenue': todayRevenue,
        'totalRevenue': totalRevenue,
      };
    } catch (e) {
      print('Get order statistics error: $e');
      return {};
    }
  }
}