import 'package:floor/floor.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';


@Entity(primaryKeys: ["id","name"])
class PriceEntity {
	int id;
	String name;
	String price;
}
