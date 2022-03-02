import 'package:micropolis_test/core/entities/base_entity.dart';

class RestaurantListEntity extends BaseEntity {
  final List<RestaurantEntity>? restaurants;

  RestaurantListEntity(this.restaurants);

  @override
  // TODO: implement props
  List<Object> get props => [if (this.restaurants != null) restaurants!];
}

class RestaurantEntity extends BaseEntity {
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

  final int? id;
  final String? name;
  final String? cuisine;
  final int? rate;
  final String? status;
  final String? prices;
  final List<TopCommentEntity>? topComments;
  final List<String>? images;

  @override
  // TODO: implement props
  List<Object> get props => [
        if (this.id != null) this.id!,
        if (this.name != null) this.name!,
        if (this.cuisine != null) this.cuisine!,
        if (this.rate != null) this.rate!,
        if (this.status != null) this.status!,
        if (this.prices != null) this.prices!,
        if (this.topComments != null) this.topComments!,
        if (this.images != null) this.images!
      ];
}

class TopCommentEntity extends BaseEntity {
  TopCommentEntity({
    this.body,
  });

  final String? body;

  @override
  // TODO: implement props
  List<Object> get props => [if (this.body != null) this.body!];
}
