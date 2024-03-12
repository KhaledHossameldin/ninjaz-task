import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post_entity.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

@freezed
class Owner with _$Owner {
  const Owner._();

  const factory Owner({
    required String id,
    required String title,
    required String firstName,
    required String lastName,
    required String picture,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  OwnerEntity toEntity() =>
      OwnerEntity(id, title, firstName, lastName, picture);
}
