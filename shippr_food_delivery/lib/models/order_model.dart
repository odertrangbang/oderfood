import 'cart_item.dart';
import 'user_model.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  pickedUp,
  outForDelivery,
  delivered,
  cancelled
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded
}

class OrderModel {
  final String id;
  final String customerId;
  final UserModel? customer;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double total;
  final String deliveryAddress;
  final Map<String, double> deliveryLocation; // lat, lng
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final String paymentMethod;
  final String? paymentTransactionId;
  final String? assignedDeliveryPersonId;
  final UserModel? assignedDeliveryPerson;
  final DateTime orderTime;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final String? specialInstructions;
  final String? cancellationReason;
  final List<String> statusHistory;

  OrderModel({
    required this.id,
    required this.customerId,
    this.customer,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.total,
    required this.deliveryAddress,
    required this.deliveryLocation,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    this.paymentTransactionId,
    this.assignedDeliveryPersonId,
    this.assignedDeliveryPerson,
    required this.orderTime,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    this.specialInstructions,
    this.cancellationReason,
    required this.statusHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customer': customer?.toMap(),
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'discount': discount,
      'total': total,
      'deliveryAddress': deliveryAddress,
      'deliveryLocation': deliveryLocation,
      'status': status.toString(),
      'paymentStatus': paymentStatus.toString(),
      'paymentMethod': paymentMethod,
      'paymentTransactionId': paymentTransactionId,
      'assignedDeliveryPersonId': assignedDeliveryPersonId,
      'assignedDeliveryPerson': assignedDeliveryPerson?.toMap(),
      'orderTime': orderTime.millisecondsSinceEpoch,
      'estimatedDeliveryTime': estimatedDeliveryTime?.millisecondsSinceEpoch,
      'actualDeliveryTime': actualDeliveryTime?.millisecondsSinceEpoch,
      'specialInstructions': specialInstructions,
      'cancellationReason': cancellationReason,
      'statusHistory': statusHistory,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      customer: map['customer'] != null ? UserModel.fromMap(map['customer']) : null,
      items: (map['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromMap(item))
          .toList() ?? [],
      subtotal: (map['subtotal'] ?? 0.0).toDouble(),
      deliveryFee: (map['deliveryFee'] ?? 0.0).toDouble(),
      tax: (map['tax'] ?? 0.0).toDouble(),
      discount: (map['discount'] ?? 0.0).toDouble(),
      total: (map['total'] ?? 0.0).toDouble(),
      deliveryAddress: map['deliveryAddress'] ?? '',
      deliveryLocation: Map<String, double>.from(map['deliveryLocation'] ?? {}),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == map['status'],
        orElse: () => OrderStatus.pending,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString() == map['paymentStatus'],
        orElse: () => PaymentStatus.pending,
      ),
      paymentMethod: map['paymentMethod'] ?? '',
      paymentTransactionId: map['paymentTransactionId'],
      assignedDeliveryPersonId: map['assignedDeliveryPersonId'],
      assignedDeliveryPerson: map['assignedDeliveryPerson'] != null 
          ? UserModel.fromMap(map['assignedDeliveryPerson']) : null,
      orderTime: DateTime.fromMillisecondsSinceEpoch(map['orderTime'] ?? 0),
      estimatedDeliveryTime: map['estimatedDeliveryTime'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['estimatedDeliveryTime']) : null,
      actualDeliveryTime: map['actualDeliveryTime'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['actualDeliveryTime']) : null,
      specialInstructions: map['specialInstructions'],
      cancellationReason: map['cancellationReason'],
      statusHistory: List<String>.from(map['statusHistory'] ?? []),
    );
  }

  OrderModel copyWith({
    String? id,
    String? customerId,
    UserModel? customer,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? discount,
    double? total,
    String? deliveryAddress,
    Map<String, double>? deliveryLocation,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    String? paymentTransactionId,
    String? assignedDeliveryPersonId,
    UserModel? assignedDeliveryPerson,
    DateTime? orderTime,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    String? specialInstructions,
    String? cancellationReason,
    List<String>? statusHistory,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customer: customer ?? this.customer,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
      assignedDeliveryPersonId: assignedDeliveryPersonId ?? this.assignedDeliveryPersonId,
      assignedDeliveryPerson: assignedDeliveryPerson ?? this.assignedDeliveryPerson,
      orderTime: orderTime ?? this.orderTime,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      actualDeliveryTime: actualDeliveryTime ?? this.actualDeliveryTime,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }
}