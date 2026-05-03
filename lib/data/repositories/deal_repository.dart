import '../models/deal_model.dart';
import '../services/mock_api_service.dart';

class DealRepository {
  final MockApiService apiService = MockApiService();

  Future<List<Deal>> getDeals() async {
    try {
      final data = await apiService.fetchDeals();

      return data.map<Deal>((json) {
        return Deal.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception("Failed to load deals: $e");
    }
  }
}
