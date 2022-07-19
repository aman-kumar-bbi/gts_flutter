import 'dart:convert';

List<Models> modelsFromJson(String str) => List<Models>.from(json.decode(str).map((x) => Models.fromJson(x)));

String modelsToJson(List<Models> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Models {
    Models({
        this.page,
        this.text,
        this.chapterName,
        this.type,
    });

    String? page;
    String? text;
    String? chapterName;
    List<Type>? type;

    factory Models.fromJson(Map<String, dynamic> json) => Models(
        page: json["page"],
        text: json["text"],
        chapterName: json["chapterName"],
        type: List<Type>.from(json["type"].map((x) => typeValues.map[x])),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "text": text,
        "chapterName": chapterName,
        "type": List<dynamic>.from(type!.map((x) => typeValues.reverse![x])),
    };
}

enum Type { CONTENT, IMAGE, TABLE }

final typeValues = EnumValues({
    "content": Type.CONTENT,
    "image": Type.IMAGE,
    "table": Type.TABLE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
