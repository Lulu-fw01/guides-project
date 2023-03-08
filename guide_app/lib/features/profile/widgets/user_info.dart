import 'package:flutter/widgets.dart';
import 'package:guide_app/features/profile/dto/user_info_dto.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userInfoDto});
  final UserInfoDto userInfoDto;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(userInfoDto.login)],
    );
  }
}
