import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/features/restaurants/presentation/bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/menu_app_bar.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/rate_widget.dart';

import 'menu_screen_content.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu';

  final RestaurantEntity? restaurant;

  const MenuScreen({Key? key, this.restaurant}) : super(key: key);

  @override
  _MenuScreenState createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {
  final RestaurantsBloc _restaurantsBloc = RestaurantsBloc();
  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    _restaurantsBloc
        .add(GetRestaurantMenu(_cancelToken, widget.restaurant?.id ?? 0));
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _restaurantsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          MenuAppBar(
            restaurant: widget.restaurant,
          ),
          Expanded(
            child: Container(
              color: CoreStyle.restaurantBackground,
              child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
                bloc: _restaurantsBloc,
                builder: (context, state) {
                  if (state is GetRestaurantsWaitingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetRestaurantsFailureState) {
                    return CustomErrorScreenWidget(
                        message: state.error.toString());
                  } else if (state is GetRestaurantMenuSuccessState) {
                    return MenuScreenContent(
                      menu: state.menu,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
