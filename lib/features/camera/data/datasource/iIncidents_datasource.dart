import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/features/camera/data/model/incident_model.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';


abstract class IIncidentsRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, IncidentModel>> getIncidentById(
      IncidentParam params);



}
