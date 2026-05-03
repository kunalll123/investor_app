import 'package:flutter_bloc/flutter_bloc.dart';
import 'deal_event.dart';
import 'deal_state.dart';
import '../../../data/repositories/deal_repository.dart';
import '../../../data/models/deal_model.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepository repository;

  List<Deal> allDeals = [];

  DealBloc(this.repository) : super(DealInitial()) {
    /// 🔹 Load Deals
    on<LoadDeals>((event, emit) async {
      emit(DealLoading());

      try {
        final deals = await repository.getDeals();

        allDeals = deals; // ✅ IMPORTANT FIX

        emit(DealLoaded(deals));
      } catch (e) {
        emit(DealError(e.toString()));
      }
    });

    /// 🔹 Search Deals
    on<SearchDeals>((event, emit) {
      final filtered = allDeals.where((deal) {
        return deal.companyName.toLowerCase().contains(
          event.query.toLowerCase(),
        );
      }).toList();

      emit(DealLoaded(filtered));
    });

    /// 🔹 Filter Deals
    on<FilterDeals>((event, emit) {
      final filtered = allDeals.where((deal) {
        final matchRisk = event.risk == null || deal.risk == event.risk;

        final matchIndustry =
            event.industry == null || deal.industry == event.industry;

        final matchMinRoi = event.minRoi == null || deal.roi >= event.minRoi!;

        final matchMaxRoi = event.maxRoi == null || deal.roi <= event.maxRoi!;

        return matchRisk && matchIndustry && matchMinRoi && matchMaxRoi;
      }).toList();

      emit(DealLoaded(filtered));
    });
  }
}
