import 'dart:convert';

NamesResponse namesResponseFromJson(String str) =>
    NamesResponse.fromJson(json.decode(str));

String namesResponseToJson(NamesResponse data) => json.encode(data.toJson());

class NamesResponse {
  Data data;
  int status;
  String message;

  NamesResponse({
    this.data,
    this.status,
    this.message,
  });

  factory NamesResponse.fromJson(Map<String, dynamic> json) => NamesResponse(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  List<String> names;

  Data({
    this.names,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        names: List<String>.from(json["names"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "names": List<dynamic>.from(names.map((x) => x)),
      };
}
