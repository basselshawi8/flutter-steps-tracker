import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/camera/data/datasource/iIncidents_datasource.dart';
import 'package:micropolis_test/features/camera/data/model/incident_model.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';
import 'package:micropolis_test/features/camera/domain/entity/incident_entity.dart';
import 'package:micropolis_test/features/camera/domain/repository/iIncidents_repository.dart';

class IncidentRepository extends IIncidentsRepository {
  final IIncidentsRemoteDataSource iIncidentsRemoteDataSource;

  IncidentRepository(this.iIncidentsRemoteDataSource);

  @override
  Future<Result<BaseError, IncidentEntity>> getIncident(
      IncidentParam params) async {
    final remote = await iIncidentsRemoteDataSource.getIncidentById(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, IncidentModel>).value.toEntity());
    } else {
      return Result(error: (remote as Left<BaseError, IncidentModel>).value);
    }
  }
}
