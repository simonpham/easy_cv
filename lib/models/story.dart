class Story {
  String title;
  String label;
  String degree;
  String company;
  String location;
  int startDate;
  int endDate;
  bool isCurrent;

  Story({
    this.title,
    this.label,
    this.degree,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent,
  });

  Story.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    label = map['label'];
    degree = map['degree'];
    company = map['company'];
    location = map['location'];
    company = map['company'];
    isCurrent = map['is_current'];
    startDate = map['start_date'];
    endDate = map['end_date'];
  }
}
