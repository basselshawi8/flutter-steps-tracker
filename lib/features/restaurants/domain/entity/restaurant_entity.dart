import 'package:micropolis_test/core/entities/base_entity.dart';

class RestaurantListEntity extends BaseEntity {
  final List<RestaurantEntity> restaurants;

  RestaurantListEntity(this.restaurants);

  @override
  // TODO: implement props
  List<Object> get props => [restaurants];
}

class RestaurantEntity extends BaseEntity{
  RestaurantEntity({
    this.id,
    this.name,
    this.cuisine,
    this.rate,
    this.status,
    this.prices,
    this.topComments,
    this.images,
  });

  final int id;
  final String name;
  final String cuisine;
  final int rate;
  final String status;
  final String prices;
  final List<TopCommentEntity> topComments;
  final List<String> images;

  @override
  // TODO: implement props
  List<Object> get props => [this.id,
    this.name,
    this.cuisine,
    this.rate,
    this.status,
    this.prices,
    this.topComments,
    this.images];
}

class TopCommentEntity extends BaseEntity {
  TopCommentEntity({
    this.body,
  });

  final String body;

  @override
  // TODO: implement props
  List<Object> get props => [this.body];
}
