

import 'package:floor/floor.dart';
import 'package:flutter_app/models/response/price_entity.dart';

@dao
abstract class BasisDao{

  @Query('SELECT * FROM PriceEntity')
  Future<List<PriceEntity>> findAllPrice();

  @insert
  Future<void> insertPrice(PriceEntity price);

}