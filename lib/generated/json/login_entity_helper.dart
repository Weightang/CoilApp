import 'package:flutter_app/models/response/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['employeeName'] != null) {
		data.employeeName = json['employeeName']?.toString();
	}
	if (json['photoUrl'] != null) {
		data.photoUrl = json['photoUrl']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['position'] != null) {
		data.position = json['position']?.toString();
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['employeeName'] = entity.employeeName;
	data['photoUrl'] = entity.photoUrl;
	data['token'] = entity.token;
	data['position'] = entity.position;
	return data;
}