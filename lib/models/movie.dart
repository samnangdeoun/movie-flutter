class Movie {
  late int id;
  late String title;
  late String overview;
  late String posterPath;
  late String name;
  late DateTime releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: DateTime.parse(json['release_date']),
      name: json['name'] ?? json['title'],
    );
  }
}
