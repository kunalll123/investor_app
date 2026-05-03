import '../../../data/models/deal_model.dart';

abstract class InterestState {}

class InterestInitial extends InterestState {}

class InterestLoaded extends InterestState {
  final List<Deal> deals;

  InterestLoaded(this.deals);
}
