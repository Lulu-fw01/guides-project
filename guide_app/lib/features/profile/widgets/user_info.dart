import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/dto/user_info_dto.dart';
import '../../../common/themes/main_theme.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userInfoDto});
  final UserInfoDto userInfoDto;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MainTheme>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            userInfoDto.login,
            style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E1A7E)),
          ),
          Text(
            'guides: ${userInfoDto.numberOfCreatedGuides}',
            style: theme.informationText,
          )
        ],
      ),
    );
  }
}
