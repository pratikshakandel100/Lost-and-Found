import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<List<BatchHiveModel>>getAllBatches();
  Future<BatchHiveModel> getBatchById(String batchId);
  Future<bool> createBatch(BatchEntity entity);
  Future<bool> updateBatch(BatchEntity entity);
  Future<bool> deleteBatch(String batchId);
}
