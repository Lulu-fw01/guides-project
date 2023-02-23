/// Guide card dto.
class GuideCardDto {
  GuideCardDto(this.author, this.guideName, this.editDate);

  /// Guide author login.
  final String author;

  /// Guide name.
  final String guideName;

  /// Edit date of the guide.
  final String editDate;
}
