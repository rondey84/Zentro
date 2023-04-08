import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';

// Should be Food Rating or OrderRating
class RestaurantRatings {
  final String ratingId;
  final String orderId;
  final String userId;
  final String restId;
  final double rating;
  final String feedback;
  final DateTime createdAt;

  RestaurantRatings({
    required this.ratingId,
    required this.orderId,
    required this.userId,
    required this.restId,
    required this.rating,
    this.feedback = '',
    required this.createdAt,
  });

  factory RestaurantRatings.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    return RestaurantRatings(
      ratingId: doc.id,
      orderId: data?[RatingFields.orderId] ?? '',
      userId: data?[RatingFields.userId] ?? '',
      restId: data?[RatingFields.restId] ?? '',
      rating: (data?[RatingFields.rating] ?? 0).toDouble(),
      feedback: data?[RatingFields.feedback] ?? '',
      createdAt: (data?[RatingFields.createdAt] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      RatingFields.orderId: orderId,
      RatingFields.userId: userId,
      RatingFields.restId: restId,
      RatingFields.rating: rating,
      RatingFields.feedback: feedback,
      RatingFields.createdAt: createdAt,
    };
  }

  RestaurantRatings copyWith({
    String? ratingId,
    String? orderId,
    String? userId,
    String? restId,
    double? rating,
    String? feedback,
    DateTime? createdAt,
  }) {
    return RestaurantRatings(
      orderId: orderId ?? this.orderId,
      ratingId: ratingId ?? this.ratingId,
      userId: userId ?? this.userId,
      restId: restId ?? this.restId,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    var data = <String, dynamic>{RatingFields.restId: restId}
      ..addAll(toFirestore());
    return data.toString();
  }
}
