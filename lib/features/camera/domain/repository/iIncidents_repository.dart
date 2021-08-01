import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/repositories/repository.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';
import 'package:micropolis_test/features/camera/domain/entity/incident_entity.dart';

abstract class IIncidentsRepository extends Repository {
  Future<Result<BaseError, IncidentEntity>> getIncident(IncidentParam params);
}
