abstract class DealEvent {}

class LoadDeals extends DealEvent {}

class SearchDeals extends DealEvent {
  final String query;
  SearchDeals(this.query);
}

class FilterDeals extends DealEvent {
  final String? industry;
  final String? risk;
  final int? minRoi;
  final int? maxRoi;

  FilterDeals({this.industry, this.risk, this.minRoi, this.maxRoi});
}
