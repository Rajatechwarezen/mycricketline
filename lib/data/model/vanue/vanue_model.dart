class VenueData {
  final bool status;
  final String msg;
  final Venue venue;

  VenueData({
    required this.status,
    required this.msg,
    required this.venue,
  });

  factory VenueData.fromJson(Map<String, dynamic> json) {
    return VenueData(
      status: json['status'],
      msg: json['msg'],
      venue: Venue.fromJson(json['data']),
    );
  }
}

class Venue {
  final int venueId;
  final String name;
  final String place;
  final String opened;
  final String capacity;
  final String knownAs;
  final String ends;
  final String location;
  final String timeZone;
  final String homeTo;
  final String floodlights;
  final String curator;
  final String profile;
  final String image;

  Venue({
    required this.venueId,
    required this.name,
    required this.place,
    required this.opened,
    required this.capacity,
    required this.knownAs,
    required this.ends,
    required this.location,
    required this.timeZone,
    required this.homeTo,
    required this.floodlights,
    required this.curator,
    required this.profile,
    required this.image,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      venueId: json['venue_id'],
      name: json['name'],
      place: json['place'],
      opened: json['opened'],
      capacity: json['capacity'],
      knownAs: json['known_as'],
      ends: json['ends'],
      location: json['location'],
      timeZone: json['time_zone'],
      homeTo: json['home_to'],
      floodlights: json['floodlights'],
      curator: json['curator'],
      profile: json['profile'],
      image: json['image'],
    );
  }
}
