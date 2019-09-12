class Api {
  String answer;
  String image;

  Api({this.answer, this.image});

factory Api.fromJSON(Map<String,dynamic>json){
  return Api(
    answer: json['answer'],
    image: json['image']
  );
}

}
  