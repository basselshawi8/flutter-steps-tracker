import 'package:micropolis_test/core/entities/base_entity.dart';

class RestaurantMenuEntity extends BaseEntity {
  final List<MenuSectionEntity>? sections;

  RestaurantMenuEntity(this.sections);

  @override
  // TODO: implement props
  List<Object> get props => [if (this.sections != null) this.sections!];
}

class MenuSectionEntity extends BaseEntity {
  MenuSectionEntity({
    this.menu,
    this.items,
  });

  final String? menu;
  final List<MenuItemEntity>? items;

  @override
  // TODO: implement props
  List<Object> get props =>
      [if (this.menu != null) this.menu!, if (this.items != null) this.items!];
}

class MenuItemEntity extends BaseEntity {
  MenuItemEntity({
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

  @override
  // TODO: implement props
  List<Object> get props => [
        if (this.id != null) this.id!,
        if (this.name != null) this.name!,
        if (this.description != null) this.description!,
        if (this.image != null) this.image!,
        if (this.price != null) this.price!
      ];
}
