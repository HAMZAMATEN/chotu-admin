class LocationIQPlace {
  final String? placeId;
  final String? osmId;
  final String? osmType;
  final String? licence;
  final String? lat;
  final String? lon;
  final List<String>? boundingBox;
  final String? placeClass;
  final String? type;
  final String? displayName;
  final String? displayPlace;
  final String? displayAddress;
  final LocationIQAddress? address;

  LocationIQPlace({
    this.placeId,
    this.osmId,
    this.osmType,
    this.licence,
    this.lat,
    this.lon,
    this.boundingBox,
    this.placeClass,
    this.type,
    this.displayName,
    this.displayPlace,
    this.displayAddress,
    this.address,
  });

  factory LocationIQPlace.fromJson(Map<String, dynamic> json) {
    return LocationIQPlace(
      placeId: json['place_id']?.toString(),
      osmId: json['osm_id']?.toString(),
      osmType: json['osm_type'],
      licence: json['licence'],
      lat: json['lat'],
      lon: json['lon'],
      boundingBox: (json['boundingbox'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      placeClass: json['class'],
      type: json['type'],
      displayName: json['display_name'],
      displayPlace: json['display_place'],
      displayAddress: json['display_address'],
      address: json['address'] != null
          ? LocationIQAddress.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'osm_id': osmId,
      'osm_type': osmType,
      'licence': licence,
      'lat': lat,
      'lon': lon,
      'boundingbox': boundingBox,
      'class': placeClass,
      'type': type,
      'display_name': displayName,
      'display_place': displayPlace,
      'display_address': displayAddress,
      'address': address?.toJson(),
    };
  }
}

class LocationIQAddress {
  final String? name;
  final String? city;
  final String? county;
  final String? state;
  final String? postcode;
  final String? country;
  final String? countryCode;

  LocationIQAddress({
    this.name,
    this.city,
    this.county,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory LocationIQAddress.fromJson(Map<String, dynamic> json) {
    return LocationIQAddress(
      name: json['name'],
      city: json['city'],
      county: json['county'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city,
      'county': county,
      'state': state,
      'postcode': postcode,
      'country': country,
      'country_code': countryCode,
    };
  }
}
