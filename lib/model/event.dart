class Event {
  static String EventNameCollection = "Event";
  String id;
  String image;
  String eventName;
  String title;
  String description;
  String Time;
  DateTime history;
  bool isfav ;

  Event(
      {this.id = "",
      required this.image,
      required this.eventName,
      required this.title,
      required this.description,
      required this.Time,
      required this.history,
      this.isfav= false });

  //json=>object
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data["id"],
            image: data["image"],
            history: DateTime.fromMillisecondsSinceEpoch(data["history"]),
            description: data["description"],
            eventName: data["eventName"],
            Time: data["time"]!,
            title: data["title"],
            isfav: data["isfav"]);

  //object=>json
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "image": image,
      "eventName": eventName,
      "title": title,
      "description": description,
      "time": Time,
      "history": history.millisecondsSinceEpoch,
      "isfav": isfav,
    };
  }
}
