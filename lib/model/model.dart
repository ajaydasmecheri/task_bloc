class Superhero {
  final String name;
  final String power;
  final String url;

  Superhero({
    required this.name,
    required this.power,
    required this.url,
  });

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      name: json['name'] as String,
      power: json['power'] as String,
      url: json['url'] as String,
    );
  }
}
