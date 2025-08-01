import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  void changePage(int index) => emit(index);

  void nextPage(int length) {
    if (state < length - 1) emit(state + 1);
  }
}
