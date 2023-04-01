import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'guide_card_dto.g.dart';

/// Guide card dto.
/// For code generation run  flutter pub run build_runner build --delete-conflicting-outputs.
@JsonSerializable()
class GuideCardDto {
  GuideCardDto(this.id, this.author, this.guideName, this.editDate,
      this.addedToFavorites);

  final int id;

  /// Guide author login.
  @JsonKey(name: 'creatorLogin')
  final String author;

  /// Guide name.
  @JsonKey(name: 'title')
  final String guideName;

  /// Edit date of the guide.
  final DateTime editDate;

  // TODO: later make final and use another
  // class for adding (removing) to favorites.
  bool addedToFavorites;

  @override
  bool operator ==(Object other) {
    return other is GuideCardDto && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory GuideCardDto.fromJson(Map<String, dynamic> json) =>
      _$GuideCardDtoFromJson(json);

  String getEditDateAsText() {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(editDate);
  }
}
