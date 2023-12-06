class Passport {
  int? id;
  String? animeName;
  String? animeEpisodes;
  String? animeDesc;
  String? image;

  Passport({
    required this.id,
    required this.animeName,
    required this.animeEpisodes,
    required this.animeDesc,
    required this.image
});

  Passport.fromJson(Map<String, dynamic> json):
      id = json['id'],
      animeName = json['anime_name'],
      animeDesc = json['anime_desc'],
      animeEpisodes = json['anime_episodes'],
      image = json['image'];

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'anime_name':animeName,
      'anime_desc':animeDesc,
      'anime_episodes':animeEpisodes,
      'image':image,
    };
  }
}