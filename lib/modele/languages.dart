class languages {
  var language;

  languages({this.language});

  languages.fromJson(Map<String, dynamic> json) {
    language = json['languages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languages'] = this.language;
    return data;
  }
}
