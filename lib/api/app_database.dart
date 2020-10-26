




import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_app/api/service/basis_dao.dart';
import 'package:flutter_app/models/response/price_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

class DataBase{

   static var basisDatabase;


  static  initDatabase() async{
    basisDatabase=await $FloorBasisDatabase
        .databaseBuilder('basis_database.db')
        .build();

  }
}





@Database(version: 1, entities: [PriceEntity])
abstract class BasisDatabase extends FloorDatabase {
    BasisDao get basisDao;
}