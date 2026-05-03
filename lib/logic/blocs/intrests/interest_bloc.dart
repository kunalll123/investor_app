import 'package:flutter_bloc/flutter_bloc.dart';
import 'interest_event.dart';
import 'interest_state.dart';
import '../../../data/models/deal_model.dart';
import '../../../data/services/interest_service.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  InterestBloc() : super(InterestInitial()) {
    /// 🔹 LOAD FROM LOCAL STORAGE
    on<LoadInterests>((event, emit) async {
      final deals = await InterestService.getDeals();
      emit(InterestLoaded(deals));
    });

    /// 🔹 ADD INTEREST
    on<AddInterest>((event, emit) async {
      await InterestService.saveDeal(event.deal);

      final updatedDeals = await InterestService.getDeals();
      emit(InterestLoaded(updatedDeals));
    });

    /// 🔹 REMOVE INTEREST
    on<RemoveInterest>((event, emit) async {
      await InterestService.removeDeal(event.deal);

      final updatedDeals = await InterestService.getDeals();
      emit(InterestLoaded(updatedDeals));
    });
  }
}
