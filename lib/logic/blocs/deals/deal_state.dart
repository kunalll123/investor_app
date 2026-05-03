abstract class DealState {}

class DealInitial extends DealState {}

class DealLoading extends DealState {}

class DealLoaded extends DealState {
  final List deals;
  DealLoaded(this.deals);
}

class DealError extends DealState {
  final String message;
  DealError(this.message);
}
