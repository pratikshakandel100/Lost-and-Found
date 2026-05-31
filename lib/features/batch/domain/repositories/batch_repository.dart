import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<Either<Failure,List<BatchEntity>>> getAllBatches(); // parameterless
  Future<Either<Failure, bool>> getBatchById(String batchId); // parametrized
  Future<Either<Failure, bool>> createBatch(BatchEntity entity);
  Future<Either<Failure, bool>> updateBatch(BatchEntity entity);
  Future<Either<Failure, bool>> deleteBatch(String batchId);
}

//return type pani j panai huna sakao
// parameter j pani huna sakao

//init add(int a, int b)
// double add (double b)