import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';
import 'package:micropolis_test/features/camera/domain/entity/incident_entity.dart';
import 'package:micropolis_test/features/camera/domain/repository/iIncidents_repository.dart';

class GetIncidentUseCase extends UseCase<IncidentEntity, IncidentParam> {
  final IIncidentsRepository incidentsRepository;

  GetIncidentUseCase(this.incidentsRepository);

  @override
  Future<Result<BaseError, IncidentEntity>> call(IncidentParam params) {
    return incidentsRepository.getIncident(params);
  }
}
