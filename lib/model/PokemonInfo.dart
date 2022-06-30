/// rarity : "HYPER"
/// price : 5000
/// no : "001"
/// name : "이상해씨"
/// description : "태어날 때부터 등에 있는 이상한 씨앗과 함께 성장하며 자란다. 이상해씨는 며칠 동안 굶어도 이상이 없는데, 그 이유는 씨앗에 영양분이 가득해 진화하기 전까지 등에 자라는 씨앗에서 영양분을 얻을 수 있기 때문이다. 몸이 자라는 만큼 씨앗도 같이 자라며, 이 씨앗은 광합성을 통해 자라기도 한다. 일정 시간이 지나 씨앗이 꽃봉오리가 되면 이상해풀로 진화한다."
/// image_url : "https://static.wikia.nocookie.net/pokemon/images/5/57/%EC%9D%B4%EC%83%81%ED%95%B4%EC%94%A8_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest/scale-to-width-down/250?cb=20170404232618&path-prefix=ko"
/// kind : "씨앗포켓몬"

class PokemonInfo {
  PokemonInfo({
    String? rarity,
    int? price,
    String? no,
    String? name,
    String? description,
    String? imageUrl,
    String? kind,
  }) {
    _rarity = rarity;
    _price = price;
    _no = no;
    _name = name;
    _description = description;
    _imageUrl = imageUrl;
    _kind = kind;
  }

  PokemonInfo.fromJson(dynamic json) {
    _rarity = json['rarity'];
    _price = json['price'];
    _no = json['no'];
    _name = json['name'];
    _description = json['description'];
    _imageUrl = json['image_url'];
    _kind = json['kind'];
  }
  String? _rarity;
  int? _price;
  String? _no;
  String? _name;
  String? _description;
  String? _imageUrl;
  String? _kind;
  PokemonInfo copyWith({
    String? rarity,
    int? price,
    String? no,
    String? name,
    String? description,
    String? imageUrl,
    String? kind,
  }) =>
      PokemonInfo(
        rarity: rarity ?? _rarity,
        price: price ?? _price,
        no: no ?? _no,
        name: name ?? _name,
        description: description ?? _description,
        imageUrl: imageUrl ?? _imageUrl,
        kind: kind ?? _kind,
      );
  String? get rarity => _rarity;
  int? get price => _price;
  String? get no => _no;
  String? get name => _name;
  String? get description => _description;
  String? get imageUrl => _imageUrl;
  String? get kind => _kind;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rarity'] = _rarity;
    map['price'] = _price;
    map['no'] = _no;
    map['name'] = _name;
    map['description'] = _description;
    map['image_url'] = _imageUrl;
    map['kind'] = _kind;
    return map;
  }
}
