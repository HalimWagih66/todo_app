class Task{
  static String collectionName = "Task";
  String? desc;
  String? title;
  String? id;
  DateTime? date;
  DateTime? time;
  bool? isDone;
  Task({required this.title,required this.desc, this.id,required this.date,required this.time,this.isDone = false});
  Task.FromFireStore(Map<String, dynamic>? date)
      : this(id: date?['id'],title: date?['title'],date: DateTime.fromMillisecondsSinceEpoch(date?['date']),time: DateTime.fromMillisecondsSinceEpoch(date?['time']),desc: date?['desc'],isDone: date?['isDone']);
  Map<String ,dynamic>toFireStore(){
    return {
      'id':id,
      'desc':desc,
      'title':title,
      'date':date?.millisecondsSinceEpoch,
      'isDone':isDone,
      'time':time?.millisecondsSinceEpoch,
    };
  }
}