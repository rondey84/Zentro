import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

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

  List<String> favRestaurants;

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
    UserCart? cart,
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
    UserCart? cart,
  }) {
    return User(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      favRestaurants: favRestaurants ?? this.favRestaurants,
      cart: cart,
    )..obId = obId ?? this.obId;
  }

  @override
  String toString() {
    return '''{ phone: $phoneNumber,
  uid: $uid,
  name: $name, 
  email: $email, 
  EmailVerification: ${isEmailVerified ? 'Email Verified' : 'Email needs to be verified'},
  Favorite Restaurants: $favRestaurants,
  Cart: $cart }''';
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
