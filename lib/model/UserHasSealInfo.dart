/// seal_id : [27,93]

class UserHasSealInfo {
  UserHasSealInfo({
    List<int>? sealId,}) {
    _sealId = sealId;
  }

  UserHasSealInfo.fromJson(dynamic json) {
    _sealId = json['seal_id'] != null ? json['seal_id'].cast<int>() : [];
  }

  List<int>? _sealId;

  UserHasSealInfo copyWith({ List<int>? sealId,
  }) =>
      UserHasSealInfo(sealId: sealId ?? _sealId,
      );

  List<int>? get sealId => _sealId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seal_id'] = _sealId;
    return map;
  }

}