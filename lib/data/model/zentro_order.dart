import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zentro/data/enums/order_enums.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import 'package:zentro/util/extensions/string_extension.dart';

class ZentroOrder {
  final String orderId;
  final String paymentType;
  OrderStatus orderStatus;
  final DateTime createdAt;
  final DocumentReference? userRef;
  final String restId;
  final Map<String, int> items;
  final double price;
  bool isPaid;
  String ratingId;
  String? outlet;

  ZentroOrder({
    required this.orderId,
    required this.paymentType,
    this.orderStatus = OrderStatus.initialized,
    required this.createdAt,
    required this.userRef,
    required this.restId,
    required this.items,
    required this.price,
    required this.isPaid,
    this.ratingId = '',
    this.outlet,
  });

  factory ZentroOrder.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    final Map<String, int> castedItems = {};
    if (data?[OrderFields.items] != null) {
      (data?[OrderFields.items] as Map<String, dynamic>).forEach((key, value) {
        castedItems[key] = value is String
            ? int.tryParse(value) ?? 0
            : value is double
                ? value.round()
                : value;
      });
    }

    return ZentroOrder(
      orderId: data?[OrderFields.orderId],
      paymentType: data?[OrderFields.paymentType] ?? '',
      orderStatus: OrderStatus.values.firstWhere((e) {
        return e.name ==
            (data?[OrderFields.orderStatus] as String? ??
                OrderStatus.initialized.name);
      }),
      createdAt: (data?[OrderFields.createdAt] as Timestamp).toDate(),
      userRef: data?[OrderFields.userRef] as DocumentReference?,
      restId: data?[OrderFields.restId] ?? '',
      items: castedItems,
      price: data?[OrderFields.price] ?? 0,
      isPaid: data?[OrderFields.isPaid] is bool
          ? data![OrderFields.isPaid]
          : data?[OrderFields.isPaid] is String
              ? (data?[OrderFields.isPaid] as String).parseBool()
              : false,
      ratingId: data?[OrderFields.ratingId] ?? '',
      outlet: data?[OrderFields.outlet],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      OrderFields.orderId: orderId,
      OrderFields.paymentType: paymentType,
      OrderFields.orderStatus: orderStatus.name,
      OrderFields.createdAt: Timestamp.fromDate(createdAt),
      OrderFields.userRef: userRef,
      OrderFields.restId: restId,
      OrderFields.items: items,
      OrderFields.price: price,
      OrderFields.isPaid: isPaid,
      OrderFields.ratingId: ratingId,
      if (outlet != null) OrderFields.outlet: outlet,
    };
  }

  ZentroOrder copyWith({
    String? orderId,
    String? paymentType,
    OrderStatus? orderStatus,
    DateTime? createdAt,
    DocumentReference? userRef,
    String? restId,
    Map<String, int>? items,
    double? price,
    bool? isPaid,
    String? ratingId,
    String? outlet,
  }) {
    return ZentroOrder(
      orderId: orderId ?? this.orderId,
      paymentType: paymentType ?? this.paymentType,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
      userRef: userRef ?? this.userRef,
      restId: restId ?? this.restId,
      items: items ?? this.items,
      price: price ?? this.price,
      isPaid: isPaid ?? this.isPaid,
      ratingId: ratingId ?? this.ratingId,
      outlet: outlet ?? this.outlet,
    );
  }

  @override
  String toString() {
    return toFirestore().toString();
  }
}
