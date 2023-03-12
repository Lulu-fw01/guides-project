import 'package:bloc/bloc.dart';
import 'package:guide_app/common/repository/guide/i_guide_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.guideRepository}) : super(ProfileInitial());
  final IGuideRepository guideRepository;

  void getNextPage(String email, int pageNum) {
    emit(ProfileLoadingState());
  }
}
