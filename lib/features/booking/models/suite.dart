class Suite {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final double pricePerNight;
  final int maxGuests;
  final List<String> amenities;
  final String imageUrl;
  final String location;

  Suite({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.pricePerNight,
    required this.maxGuests,
    required this.amenities,
    required this.imageUrl,
    required this.location,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      maxGuests: json['maxGuests'] as int,
      amenities: List<String>.from(json['amenities'] as List),
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'description': description,
    'pricePerNight': pricePerNight,
    'maxGuests': maxGuests,
    'amenities': amenities,
    'imageUrl': imageUrl,
    'location': location,
  };
}
