abstract class DocBookStates{}

class DocBookInitialState extends DocBookStates{}

class DocBookChangeBottomNavState extends DocBookStates{}

class DocBookLoadingHomeDataState extends DocBookStates{}

class DocBookSuccessHomeDataState extends DocBookStates{}

class DocBookErrorHomeDataState extends DocBookStates{}

class UploadImageSuccessState extends DocBookStates{
  final String image;
  UploadImageSuccessState(this.image);
}

class ReservationLoadingState extends DocBookStates{}

class ReservationSuccessState extends DocBookStates{}

class ReservationErrorState extends DocBookStates{}

class CreateReservationLoadingState extends DocBookStates{}

class CreateReservationSuccessState extends DocBookStates{}

class CreateReservationErrorState extends DocBookStates{}

class GetNotesLoadingState extends DocBookStates{}

class GetNotesSuccessState extends DocBookStates{}

class GetNotesErrorState extends DocBookStates{}

class AddMedicationLoadingState extends DocBookStates{}

class AddMedicationSuccessState extends DocBookStates{}

class AddMedicationErrorState extends DocBookStates{}

class GetMedicationLoadingState extends DocBookStates{}

class GetMedicationSuccessState extends DocBookStates{}

class GetMedicationErrorState extends DocBookStates{}

class GetResultLoadingState extends DocBookStates{}

class GetResultSuccessState extends DocBookStates{}

class GetResultErrorState extends DocBookStates{}





