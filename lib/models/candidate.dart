class Candidate {
  final int number;
  final String title;
  final String firstName;
  final String lastName;

  Candidate(this.number, this.title, this.firstName, this.lastName);

  @override
  String toString() {
    var out = "$title$firstName $lastName";
    return out;
  }

  Candidate.fromJson2(Map<String, dynamic> json)
      : number = json['number'],
        title = json['title'],
        firstName = json['firstName'],
        lastName = json['lastName'];

  factory Candidate.fromJson(Map<String, dynamic> json) {
    var x = json['candidateName'].split(" ");
    return Candidate(
      json['candidateNumber'],
      json['candidateTitle'],
      x[0],
      x[1],
    );
  }
}