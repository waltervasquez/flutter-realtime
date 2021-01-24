class Band {
  String id;
  String name;
  int votes;

  Band({ this.id, this.name, this.votes });

  //CONVERSION JSON TO LIST
  factory Band.fromMap(Map<String,  dynamic> data ) =>
      Band(
        id:  data['id'],
        name:  data['name'],
        votes: data['votes']
      );
}