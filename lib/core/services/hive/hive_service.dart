import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref){
  return HiveService();
});

class HiveService {
  //init
  Future<void> init() async{
    final directory = await getApplicationDocumentsDirectory();
    final path = '$directory.path/${HiveTableConstant.dbName}';
    Hive.init(path);
    _registerAdapter();
    await openBoxes();
    await insertDummybatches();
  }

  Future<void> insertDummybatches() async{
    final box = await Hive.openBox<BatchHiveModel>(
      HiveTableConstant.batchTable,
    );
    if(box.isEmpty) return;
    final dummyBatches = [
      BatchHiveModel(batchName: "35-A"),
      BatchHiveModel(batchName: "35-B"),
      BatchHiveModel(batchName: "35-C"),
      BatchHiveModel(batchName: "36-A"),
      BatchHiveModel(batchName: "36-B"),
      BatchHiveModel(batchName: "36-C"),
    ];
    for(var batch in dummyBatches){
      await box.put(batch.batchId, batch);
    }
    await box.close();
  }




 //Register Adapters
  void _registerAdapter(){
    if(!Hive.isAdapterRegistered(HiveTableConstant.batchTypeId)){
      Hive.registerAdapter(BatchHiveModelAdapter());
    }
  }

  //open boxes
  Future<void> openBoxes() async{
    await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchTable);
  }

  //close boxes
  Future<void> close() async{
    await Hive.close();
  }
  

  //Batch Queries
  Box<BatchHiveModel> get _batchBox =>
  Hive.box<BatchHiveModel>(HiveTableConstant.batchTable);

  //create
  Future<BatchHiveModel> createBatch(BatchHiveModel model) async {
    await _batchBox.put(model.batchId, model);
    return model;
  }

  //getallbatch
  List<BatchHiveModel> getAllBatches(){
    return _batchBox.values.toList();
  }

  //update
  Future<void> updateBatch(BatchHiveModel model) async{
    await _batchBox.put(model.batchId, model);
  }


  //delete
}