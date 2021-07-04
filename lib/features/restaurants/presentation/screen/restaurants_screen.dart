
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/restaurants/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/restaurants/presentation/screen/restaurants_screen_content.dart';

class RestaurantsScreen extends StatefulWidget {

  static const routeName = '/restaurants';

  @override
  _RestaurantsScreenState createState() {

    return _RestaurantsScreenState();
  }
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {

  CancelToken _cancelToken = CancelToken();
  final RestaurantsBloc _restaurantsBloc = RestaurantsBloc();

  @override
  void initState() {

    _restaurantsBloc.add(GetRestaurants(_cancelToken));
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
      backgroundColor: CoreStyle.restaurantBackground,
      body: SafeArea(
        child: BlocBuilder<RestaurantsBloc,RestaurantsState>(
          bloc: _restaurantsBloc,
          builder: (context,state){
            if (state is GetRestaurantsWaitingState) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is GetRestaurantsFailureState) {
              return CustomErrorScreenWidget(message: state.error.toString());
            }
            else if (state is GetRestaurantsSuccessState) {
              return RestaurantsScreenContent(restaurants: state.restaurantsList,);
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );


  }

}