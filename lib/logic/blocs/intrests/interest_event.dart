import 'package:investor_app/data/models/deal_model.dart';

abstract class InterestEvent {}

class LoadInterests extends InterestEvent {}

class AddInterest extends InterestEvent {
  final Deal deal;
  AddInterest(this.deal);
}

class RemoveInterest extends InterestEvent {
  final Deal deal;
  RemoveInterest(this.deal);
}
