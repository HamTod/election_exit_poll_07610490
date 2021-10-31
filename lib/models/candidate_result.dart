class result_item {
  int id;
  String title;
  String firstName;
  String lastName;
  int score;

  result_item(this.id, this.title, this.firstName, this.lastName,this.score);

  @override
  String toString() {
    var out = "$title $firstName $lastName";
    return out;
  }

  result_item.fromJson2(Map<String, dynamic> json)
      : id = json['number'],
        title = json['title'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        score = json['score'];

  factory result_item.fromJson(Map<String, dynamic> json) {
    var x = json['candidateName'].split(" ");
    return result_item(
      json['candidateNumber'],
      json['candidateTitle'],
      x[0],
      x[1],
      json['score'],
    );
  }
}
