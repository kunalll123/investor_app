class Deal {
  final String companyName;
  final String industry;
  final int investment;
  final int roi;
  final String risk;
  final String status;

  Deal({
    required this.companyName,
    required this.industry,
    required this.investment,
    required this.roi,
    required this.risk,
    required this.status,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      companyName: json['companyName'] ?? '',
      industry: json['industry'] ?? '',
      investment: json['investment'] ?? 0,
      roi: json['roi'] ?? 0,
      risk: json['risk'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "industry": industry,
      "investment": investment,
      "roi": roi,
      "risk": risk,
      "status": status,
    };
  }
}
