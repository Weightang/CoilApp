import 'dart:math';

import 'package:flutter_app/api/app_database.dart';
import 'package:flutter_app/models/response/price_entity.dart';
import 'package:flutter_app/provider/view_state_model.dart';
import 'package:flutter_app/utils/log_utils.dart';
import 'package:flutter_app/utils/platform_utils.dart';

class PriceModel extends ViewStateModel {
  List<PriceEntity> list = [];

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

  Future<List<PriceEntity>> findAllPrice() async {
    try {
      list.clear();
      var priceList = await DataBase.basisDatabase.basisDao.findAllPrice();
      list.addAll(priceList);
      if (list.isEmpty) {
        setEmpty();
        return list;
      } else {
        setIdle();
        return list;
      }
    } catch (e, s) {
      setError(e, s);
      return list;
    }
  }

  Future<bool> deletePrice(PriceEntity entity) async {
    try {
      setBusy();
      DataBase.basisDatabase.basisDao.deletePrice(entity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
