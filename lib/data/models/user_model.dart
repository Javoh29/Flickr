class UserModel {
  String? id;
  String? nsid;
  String? joinDate;
  String? occupation;
  String? hometown;
  String? showcaseSet;
  String? showcaseSetTitle;
  String? firstName;
  String? lastName;
  String? email;
  String? profileDescription;
  dynamic city;
  dynamic country;
  String? facebook;
  String? twitter;
  String? tumblr;
  String? instagram;
  String? pinterest;

  UserModel({
    this.id,
    this.nsid,
    this.joinDate,
    this.occupation,
    this.hometown,
    this.showcaseSet,
    this.showcaseSetTitle,
    this.firstName,
    this.lastName,
    this.email,
    this.profileDescription,
    this.city,
    this.country,
    this.facebook,
    this.twitter,
    this.tumblr,
    this.instagram,
    this.pinterest,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String?,
        nsid: json['nsid'] as String?,
        joinDate: json['join_date'] as String?,
        occupation: json['occupation'] as String?,
        hometown: json['hometown'] as String?,
        showcaseSet: json['showcase_set'] as String?,
        showcaseSetTitle: json['showcase_set_title'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        profileDescription: json['profile_description'] as String?,
        city: json['city'] as dynamic,
        country: json['country'] as dynamic,
        facebook: json['facebook'] as String?,
        twitter: json['twitter'] as String?,
        tumblr: json['tumblr'] as String?,
        instagram: json['instagram'] as String?,
        pinterest: json['pinterest'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nsid': nsid,
        'join_date': joinDate,
        'occupation': occupation,
        'hometown': hometown,
        'showcase_set': showcaseSet,
        'showcase_set_title': showcaseSetTitle,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'profile_description': profileDescription,
        'city': city,
        'country': country,
        'facebook': facebook,
        'twitter': twitter,
        'tumblr': tumblr,
        'instagram': instagram,
        'pinterest': pinterest,
      };

  UserModel copyWith({
    String? id,
    String? nsid,
    String? joinDate,
    String? occupation,
    String? hometown,
    String? showcaseSet,
    String? showcaseSetTitle,
    String? firstName,
    String? lastName,
    String? email,
    String? profileDescription,
    dynamic city,
    dynamic country,
    String? facebook,
    String? twitter,
    String? tumblr,
    String? instagram,
    String? pinterest,
  }) {
    return UserModel(
      id: id ?? this.id,
      nsid: nsid ?? this.nsid,
      joinDate: joinDate ?? this.joinDate,
      occupation: occupation ?? this.occupation,
      hometown: hometown ?? this.hometown,
      showcaseSet: showcaseSet ?? this.showcaseSet,
      showcaseSetTitle: showcaseSetTitle ?? this.showcaseSetTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profileDescription: profileDescription ?? this.profileDescription,
      city: city ?? this.city,
      country: country ?? this.country,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      tumblr: tumblr ?? this.tumblr,
      instagram: instagram ?? this.instagram,
      pinterest: pinterest ?? this.pinterest,
    );
  }
}
