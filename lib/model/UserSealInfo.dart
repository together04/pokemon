/// seal_id : 1

class UserSealInfo {
  UserSealInfo({
    int? sealId,
  }) {
    _sealId = sealId;
  }

  UserSealInfo.fromJson(dynamic json) {
    _sealId = json['seal_id'];
  }
  int? _sealId;
  UserSealInfo copyWith({
    int? sealId,
  }) =>
      UserSealInfo(
        sealId: sealId ?? _sealId,
      );
  int? get sealId => _sealId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seal_id'] = _sealId;
    return map;
  }
}
