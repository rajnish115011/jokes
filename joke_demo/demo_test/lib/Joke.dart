

class Joke {

  String? joke;

  Joke(this.joke);

  Joke.fromJson(Map<String, dynamic> json) {

    joke = json['joke'];

  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["joke"] = joke;


    return map;
  }

  Joke.fromObject(dynamic o) {
    this.joke = o["joke"];

  }



}