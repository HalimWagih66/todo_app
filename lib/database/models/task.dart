class Task{
  static String collectionName = "Task";
  String? desc;
  String? title;
  String? id;
  DateTime? dateTime;
  bool? isDone;
  Task({required this.title,required this.desc, this.id,required this.dateTime,this.isDone = false});
  Task.FromFireStore(Map<String, dynamic>? date)
      : this(id: date?['id'],title: date?['title'],dateTime: DateTime.fromMillisecondsSinceEpoch(date?['dateTime']),desc: date?['desc'],isDone: date?['isDone']);
  Map<String ,dynamic>toFireStore(){
    return {
      'id':id,
      'desc':desc,
      'title':title,
      'dateTime':dateTime?.millisecondsSinceEpoch,
      'isDone':isDone,
    };
  }
}