class BotChat {
  String? response;
  List<Solutions>? solutions;

  BotChat({this.response, this.solutions});

  BotChat.fromJson(Map<String, dynamic> json) {
    response = json["response"];
    solutions = json["solutions"] == null ? null : (json["solutions"] as List).map((e) => Solutions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["response"] = response;
    if(solutions != null) {
      _data["solutions"] = solutions?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Solutions {
  String? response;
  List<Solutions1>? solutions;

  Solutions({this.response, this.solutions});

  Solutions.fromJson(Map<String, dynamic> json) {
    response = json["response"];
    solutions = json["solutions"] == null ? null : (json["solutions"] as List).map((e) => Solutions1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["response"] = response;
    if(solutions != null) {
      _data["solutions"] = solutions?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Solutions1 {
  String? response;

  Solutions1({this.response});

  Solutions1.fromJson(Map<String, dynamic> json) {
    response = json["response"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["response"] = response;
    return _data;
  }
}