import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';

class RestaurantListModel extends BaseModel<RestaurantListEntity> {
  final List<RestaurantModel>? restaurants;

  RestaurantListModel(this.restaurants);

  factory RestaurantListModel.fromJson(String str) =>
      RestaurantListModel.fromMap(json.decode(str));

  factory RestaurantListModel.fromMap(List<dynamic> json) =>
      RestaurantListModel(
        List<RestaurantModel>.from(json.map((x) => RestaurantModel.fromMap(x))),
      );

  @override
  RestaurantListEntity toEntity() {
    return RestaurantListEntity(restaurants?.map((e) => e.toEntity()).toList());
  }
}

class RestaurantModel extends BaseModel<RestaurantEntity> {
  RestaurantModel({
    this.id,
    this.name,
    this.cuisine,
    this.rate,
    this.status,
    this.prices,
    this.topComments,
    this.images,
  });

  final int? id;
  final String? name;
  final String? cuisine;
  final int? rate;
  final String? status;
  final String? prices;
  final List<TopCommentModel>? topComments;
  final List<String>? images;

  factory RestaurantModel.fromJson(String str) =>
      RestaurantModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromMap(Map<String, dynamic> json) => RestaurantModel(
        id: json["id"],
        name: json["name"],
        cuisine: json["cuisine"],
        rate: json["rate"],
        status: json["status"],
        prices: json["prices"],
        topComments: List<TopCommentModel>.from(
            json["top_comments"].map((x) => TopCommentModel.fromMap(x))),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "cuisine": cuisine,
        "rate": rate,
        "status": status,
        "prices": prices,
        "top_comments": topComments == null
            ? null
            : List<dynamic>.from(topComments!.map((x) => x.toMap())),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };

  @override
  RestaurantEntity toEntity() {
    return RestaurantEntity(
        id: this.id,
        name: this.name,
        cuisine: this.cuisine,
        rate: this.rate,
        status: this.status,
        prices: this.prices,
        topComments: this.topComments?.map((e) => e.toEntity()).toList(),
        images: this.images);
  }
}

class TopCommentModel extends BaseModel<TopCommentEntity> {
  TopCommentModel({
    this.body,
  });

  final String? body;

  factory TopCommentModel.fromJson(String str) =>
      TopCommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCommentModel.fromMap(Map<String, dynamic> json) => TopCommentModel(
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "body": body,
      };

  @override
  TopCommentEntity toEntity() {
    return TopCommentEntity(body: this.body);
  }
}
