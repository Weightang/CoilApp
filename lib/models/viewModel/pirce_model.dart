import 'package:flutter_app/api/app_database.dart';
import 'package:flutter_app/models/response/price_entity.dart';
import 'package:flutter_app/provider/view_state_model.dart';
import 'package:flutter_app/utils/platform_utils.dart';

class PriceModel extends ViewStateModel {


  Future addPrice(entity) async {
    setBusy();
    try {
        DataBase.basisDatabase.basisDao.insertPrice(entity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<List<PriceEntity>> findAllPrice() async{
    try{
     var list=  await DataBase.basisDatabase.basisDao.findAllPrice();
      if(list.isEmpty){
        setEmpty();
        return list;
      }else{
        setIdle();
        return list;
     }
    }catch(e,s){
      setError(e, s);
      return null;
    }




  }


}