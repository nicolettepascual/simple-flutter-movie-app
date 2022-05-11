class Movie {
  late int id;
  late String title;
  late String overview;
  late String poster;
  late String releaseDate;
  late String backdrop;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.poster,
      required this.releaseDate,
      required this.backdrop
      });

  Movie.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    overview = json['overview'] as String;
    poster = json['poster_path'] as String;
    releaseDate = json['release_date'] as String;
    backdrop = json['backdrop_path'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['overview'] = overview;
    data['poster'] = poster;
    data['releaseDate'] = releaseDate;
    data['backdrop_path'] = backdrop;

    return data;
  }
}
