class PhotoModel {
  String? id;
  String? owner;
  String? secret;
  String? server;
  int? farm;
  String? title;
  int? ispublic;
  int? isfriend;
  int? isfamily;
  String? dateFaved;

  PhotoModel({
    this.id,
    this.owner,
    this.secret,
    this.server,
    this.farm,
    this.title,
    this.ispublic,
    this.isfriend,
    this.isfamily,
    this.dateFaved,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json['id'] as String?,
        owner: json['owner'] as String?,
        secret: json['secret'] as String?,
        server: json['server'] as String?,
        farm: json['farm'] as int?,
        title: json['title'] as String?,
        ispublic: json['ispublic'] as int?,
        isfriend: json['isfriend'] as int?,
        isfamily: json['isfamily'] as int?,
        dateFaved: json['date_faved'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        'secret': secret,
        'server': server,
        'farm': farm,
        'title': title,
        'ispublic': ispublic,
        'isfriend': isfriend,
        'isfamily': isfamily,
        'date_faved': dateFaved,
      };

  PhotoModel copyWith({
    String? id,
    String? owner,
    String? secret,
    String? server,
    int? farm,
    String? title,
    int? ispublic,
    int? isfriend,
    int? isfamily,
    String? dateFaved,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      secret: secret ?? this.secret,
      server: server ?? this.server,
      farm: farm ?? this.farm,
      title: title ?? this.title,
      ispublic: ispublic ?? this.ispublic,
      isfriend: isfriend ?? this.isfriend,
      isfamily: isfamily ?? this.isfamily,
      dateFaved: dateFaved ?? this.dateFaved,
    );
  }
}
