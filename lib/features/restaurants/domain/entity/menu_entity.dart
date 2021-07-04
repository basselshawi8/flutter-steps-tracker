import 'package:micropolis_test/core/entities/base_entity.dart';

class RestaurantMenuEntity extends BaseEntity {
  final List<MenuSectionEntity> sections;

  RestaurantMenuEntity(this.sections);

  @override
  // TODO: implement props
  List<Object> get props => [this.sections];
}

class MenuSectionEntity extends BaseEntity {
  MenuSectionEntity({
    this.menu,
    this.items,
  });

  final String menu;
  final List<MenuItemEntity> items;

  @override
  // TODO: implement props
  List<Object> get props => [this.menu, this.items];
}

class MenuItemEntity extends BaseEntity {
  MenuItemEntity({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  final int id;
  final String name;
  final String description;
  final String image;
  final String price;

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.id, this.name, this.description, this.image, this.price];
}
