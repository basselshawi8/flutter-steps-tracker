// To parse this JSON data, do
//
//     final menuSectionModel = menuSectionModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';

class RestaurantMenuModel extends BaseModel<RestaurantMenuEntity> {
  final List<MenuSectionModel>? sections;

  RestaurantMenuModel(this.sections);

  factory RestaurantMenuModel.fromJson(String str) =>
      RestaurantMenuModel.fromMap(json.decode(str));

  factory RestaurantMenuModel.fromMap(List<dynamic> json) =>
      RestaurantMenuModel(
        List<MenuSectionModel>.from(
            json.map((x) => MenuSectionModel.fromMap(x))),
      );

  @override
  RestaurantMenuEntity toEntity() {
    return RestaurantMenuEntity(sections?.map((e) => e.toEntity()).toList());
  }
}

class MenuSectionModel extends BaseModel<MenuSectionEntity> {
  MenuSectionModel({
    this.menu,
    this.items,
  });

  final String? menu;
  final List<MenuItemModel>? items;

  factory MenuSectionModel.fromJson(String str) =>
      MenuSectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuSectionModel.fromMap(Map<String, dynamic> json) =>
      MenuSectionModel(
        menu: json["menu"],
        items: List<MenuItemModel>.from(
            json["items"].map((x) => MenuItemModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "menu": menu,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };

  @override
  MenuSectionEntity toEntity() {
    return MenuSectionEntity(
        menu: this.menu, items: this.items?.map((e) => e.toEntity()).toList());
  }
}

class MenuItemModel extends BaseModel<MenuItemEntity> {
  MenuItemModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? price;

  factory MenuItemModel.fromJson(String str) =>
      MenuItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuItemModel.fromMap(Map<String, dynamic> json) => MenuItemModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
      };

  @override
  MenuItemEntity toEntity() {
    return MenuItemEntity(
        id: this.id,
        name: this.name,
        description: this.description,
        image: this.image,
        price: this.price);
  }
}
