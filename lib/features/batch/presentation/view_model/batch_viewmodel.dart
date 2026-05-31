import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/batch/domain/usecases/create_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/get_all_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/update_batch_usecase.dart';
import 'package:lost_n_found/features/batch/presentation/state/batch_state.dart';

final batchViewmodelProvider = NotifierProvider<BatchViewmodel, BatchState>((){
  return BatchViewmodel();
});

class BatchViewmodel extends Notifier<BatchState> {
  late final GetAllBatchUsecase _getAllBatchUsecase;
  late final UpdateBatchUsecase _updateBatchUsecase;
  late final CreateBatchUsecase _createBatchUsecase;
  @override
  BatchState build() {
    _getAllBatchUsecase = ref.read(getAllBatchUsecaseProvider);
    _updateBatchUsecase = ref.read(updateBatchUsecaseProvider);
    _createBatchUsecase = ref.read(createBatchUsecaseProvider);
    return BatchState();
  }
  
  Future<void> getAllBatches() async{
    state = state.copyWith(status: BatchStatus.loading);
    //wait
    Future.delayed(Duration(seconds: 2));
    final result = await _getAllBatchUsecase();

    result.fold((left){
      state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: left.message,
      );
    }, 
    (batches){
      state = state.copyWith(status: BatchStatus.loaded, batches: batches);
    },
    );
  }



  //Create Batch
  Future<void> createBatch(String batchName) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _createBatchUsecase(
      CreateBatchUsecaseParams(batchName: batchName),
    );

    result.fold(
      (left) {
        state = state.copyWith(
          status: BatchStatus.error,
          errorMessage: left.message,
        );
      },
      (right) {
        state = state.copyWith(status: BatchStatus.loaded);
      },
    );
  }
}
