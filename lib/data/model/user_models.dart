import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zentro/data/model/restaurant_ratings.dart';

import 'menu_item.dart';

@Entity()
class User {
  @Id()
  int obId = 0;
  @Unique()
  String phoneNumber;
  @Unique()
  String? uid;
  String? name;
  String? email;
  bool isEmailVerified;
  String? cartJson;
  String? currentOrderId;

  List<String> favRestaurants;
  List<String> ordersId;

  UserCart? get cart {
    if (cartJson == null) return null;
    return UserCart.fromJson(jsonDecode(cartJson!));
  }

  set cart(UserCart? val) {
    cartJson = val != null ? jsonEncode(val.toJson()) : null;
  }

  User({
    required this.phoneNumber,
    this.uid,
    this.name,
    this.email,
    this.isEmailVerified = false,
    this.favRestaurants = const [],
    this.ordersId = const [],
    UserCart? cart,
    this.currentOrderId,
  }) : cartJson = cart != null ? jsonEncode(cart.toJson()) : null;

  UserCart addCart(String restaurantId) {
    cart ??= UserCart(restId: restaurantId);
    return cart!;
  }

  void removeCart() {
    if (cart == null) return;
    cart = null;
  }

  User copyWith({
    int? obId,
    String? phoneNumber,
    String? uid,
    String? name,
    String? email,
    bool? isEmailVerified,
    List<String>? favRestaurants,
    List<String>? ordersId,
    UserCart? cart,
    String? currentOrderId,
  }) {
    return User(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      favRestaurants: favRestaurants ?? this.favRestaurants,
      ordersId: ordersId ?? this.ordersId,
      cart: cart,
      currentOrderId: currentOrderId ?? this.currentOrderId,
    )..obId = obId ?? this.obId;
  }

  @override
  String toString() {
    Map<String, dynamic> toMap = {
      'Phone': phoneNumber,
      'uid': uid,
      'Name': name,
      'Email': email,
      'EmailVerification':
          isEmailVerified ? 'Email Verified' : 'Email needs to be verified',
      'Favorite Restaurants': favRestaurants,
      'Orders': ordersId,
      'CurrentOrderID': currentOrderId,
      'Cart': cart
    };
    return toMap.toString();
  }
}

class UserCart {
  String restId;

  /// the MenuItem and its quantity
  Map<MenuItem, int> cartItems;

  UserCart({
    required this.restId,
    Map<MenuItem, int>? cartItems,
  }) : cartItems = cartItems ?? {};

  Map<String, dynamic> toJson() {
    return {
      'restId': restId,
      'cartItems': jsonEncode(cartItems.map((menuItem, quantity) {
        return MapEntry(jsonEncode(menuItem.toJson()), quantity);
      })),
    };
  }

  factory UserCart.fromJson(Map<String, dynamic> json) {
    final cartItemsJson = json['cartItems'] as String;
    final cartItemsMap = jsonDecode(cartItemsJson) as Map<String, dynamic>;
    final cartItems = cartItemsMap.map((menuItem, quantity) {
      return MapEntry(
        MenuItem.fromJson(jsonDecode(menuItem) as Map<String, dynamic>),
        quantity as int,
      );
    });

    return UserCart(restId: json['restId'] as String, cartItems: cartItems);
  }

  void addItem(MenuItem item) {
    if (cartItems.containsKey(item)) {
      incrementItem(item);
    } else {
      cartItems[item] = 1;
    }
  }

  void removeItem(MenuItem item) {
    if (cartItems.containsKey(item)) {
      cartItems.remove(item);
    }
  }

  Map<MenuItem, int> incrementItem(MenuItem item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    }
    return cartItems;
  }

  Map<MenuItem, int> decrementItem(MenuItem item) {
    if (cartItems.containsKey(item)) {
      if (cartItems[item]! > 1) {
        cartItems[item] = cartItems[item]! - 1;
      } else {
        cartItems.remove(item);
      }
    }
    return cartItems;
  }

  int get totalQuantity {
    return cartItems.values.reduce((a, b) => a + b);
  }

  double get priceWithoutTax {
    double value = cartItems.entries.fold(0, (total, entry) {
      return total + ((entry.key.price ?? 0.0) * entry.value);
    });
    return value;
  }

  double get priceWithTax {
    return cartItems.entries.fold(0, (total, entry) {
      var itemPrice = entry.key.price ?? 0.0;
      var itemTax = entry.key.tax ?? 0.0;
      return total + (itemPrice * entry.value * (1 + itemTax / 100));
    });
  }

  @override
  String toString() {
    return '{Restaurant: $restId, Cart: $cartItems}';
  }
}

class UserProfileItem {
  final String text;
  final IconData iconData;
  final VoidCallback? onTap;

  UserProfileItem({
    required this.text,
    required this.iconData,
    this.onTap,
  });
}

class UsersOrderItem {
  final String orderId;
  final bool isOrderPickedUp;
  final double totalPrice;
  final DateTime orderDate;
  final Map<MenuItem, int> orderItems;
  final String paymentType;

  final String restId;
  final String restName;
  final String? restOutlet;

  final RestaurantRatings? rating;

  UsersOrderItem({
    required this.orderId,
    required this.isOrderPickedUp,
    required this.totalPrice,
    required this.orderDate,
    required this.orderItems,
    required this.paymentType,
    required this.restId,
    required this.restName,
    this.restOutlet,
    this.rating,
  });

  UsersOrderItem copyWith({
    String? orderId,
    bool? isOrderPickedUp,
    double? totalPrice,
    DateTime? orderDate,
    Map<MenuItem, int>? orderItems,
    String? paymentType,
    String? restId,
    String? restName,
    String? restOutlet,
    RestaurantRatings? rating,
  }) {
    return UsersOrderItem(
      orderId: orderId ?? this.orderId,
      isOrderPickedUp: isOrderPickedUp ?? this.isOrderPickedUp,
      totalPrice: totalPrice ?? this.totalPrice,
      orderDate: orderDate ?? this.orderDate,
      orderItems: orderItems ?? this.orderItems,
      paymentType: paymentType ?? this.paymentType,
      restId: restId ?? this.restId,
      restName: restName ?? this.restName,
      restOutlet: restOutlet ?? this.restOutlet,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    Map<String, dynamic> toMap = {
      'orderId': orderId,
      'isOrderPickedUp': isOrderPickedUp,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'orderItems': orderItems,
      'paymentType': paymentType,
      'restId': restId,
      'restName': restName,
      'restOutlet': restOutlet,
      'rating': rating,
    };
    return toMap.toString();
  }
}
