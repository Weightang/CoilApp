import 'package:floor/floor.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';


@Entity()
class PriceEntity {
	PriceEntity({this.id,this.name,this.price});
	@PrimaryKey(autoGenerate: true)
	int id;

	String name;
	String price;
}
