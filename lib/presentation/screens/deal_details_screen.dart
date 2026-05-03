import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:investor_app/data/services/interest_service.dart';
import 'package:investor_app/utils/ui_utils.dart';
import '../../data/models/deal_model.dart';

class DealDetailsScreen extends StatelessWidget {
  final Deal deal;

  const DealDetailsScreen({super.key, required this.deal});

  Color getRiskColor() {
    switch (deal.risk.toLowerCase()) {
      case "low":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "high":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildHighlightRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: UiUtils.responsiveHeight(context, 0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: UiUtils.responsiveFontSize(context, 14)),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: UiUtils.responsiveFontSize(context, 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
        title: Text(
          deal.companyName,
          style: TextStyle(
            color: const Color(0xFF2E7D32),
            fontSize: UiUtils.responsiveFontSize(context, 18),
          ),
        ),
      ),

      body: Container(
        width: UiUtils.screenWidth(context),
        height: UiUtils.screenHeight(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA5D6A7), Color(0xFFF5F7F4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: UiUtils.responsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🟢 INDUSTRY
              Text(
                deal.industry,
                style: TextStyle(
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                  fontSize: UiUtils.responsiveFontSize(context, 14),
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 2)),

              /// 💰 MAIN CARD
              _buildCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Investment Required: ₹${deal.investment}",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 16),
                      ),
                    ),

                    SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

                    Text(
                      "Expected ROI: ${deal.roi}%",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),

                    SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

                    /// Status
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 14),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: UiUtils.responsiveWidth(context, 3),
                            vertical: UiUtils.responsiveHeight(context, 0.7),
                          ),
                          decoration: BoxDecoration(
                            color:
                                (deal.status == "Open"
                                        ? Colors.green
                                        : Colors.red)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              UiUtils.responsiveWidth(context, 5),
                            ),
                          ),
                          child: Text(
                            deal.status,
                            style: TextStyle(
                              color: deal.status == "Open"
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: UiUtils.responsiveFontSize(context, 13),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

                    /// Risk
                    Row(
                      children: [
                        Text(
                          "Risk Level: ",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 14),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: UiUtils.responsiveWidth(context, 3),
                            vertical: UiUtils.responsiveHeight(context, 0.7),
                          ),
                          decoration: BoxDecoration(
                            color: getRiskColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              UiUtils.responsiveWidth(context, 5),
                            ),
                          ),
                          child: Text(
                            deal.risk,
                            style: TextStyle(
                              color: getRiskColor(),
                              fontWeight: FontWeight.bold,
                              fontSize: UiUtils.responsiveFontSize(context, 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 2.5)),

              /// 📊 OVERVIEW
              _buildCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company Overview",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: UiUtils.responsiveHeight(context, 1)),
                    Text(
                      "This company is a fast-growing startup with strong market presence and scalable business model.",
                      style: TextStyle(
                        fontSize: UiUtils.responsiveFontSize(context, 14),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 2.5)),

              /// 📈 GRAPH
              _buildCard(
                context,
                child: SizedBox(
                  height: UiUtils.responsiveHeight(
                    context,
                    25,
                  ), // 👈 responsive
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: const Color(0xFF2E7D32),
                          spots: [
                            FlSpot(0, deal.roi * 0.5),
                            FlSpot(1, deal.roi * 0.7),
                            FlSpot(2, deal.roi.toDouble()),
                          ],
                          dotData: FlDotData(show: false),
                          isStrokeCapRound: true,
                          barWidth: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 2.5)),

              /// 📌 HIGHLIGHTS
              Text(
                "Financial Highlights",
                style: TextStyle(
                  fontSize: UiUtils.responsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

              _buildCard(
                context,
                child: Column(
                  children: [
                    _buildHighlightRow(
                      context,
                      "Investment",
                      "₹${deal.investment}",
                    ),
                    _buildHighlightRow(context, "ROI", "${deal.roi}%"),
                    _buildHighlightRow(context, "Risk", deal.risk),
                    _buildHighlightRow(context, "Status", deal.status),
                  ],
                ),
              ),

              SizedBox(height: UiUtils.responsiveHeight(context, 3)),

              /// 🚀 BUTTON
              SizedBox(
                width: double.infinity,
                height: UiUtils.responsiveHeight(context, 7),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        UiUtils.responsiveWidth(context, 8),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await InterestService.saveDeal(deal);

                    UiUtils.showSuccessSnackBar(
                      context,
                      "Added to My Interests!",
                    );
                  },
                  child: Text(
                    "I'm Interested",
                    style: TextStyle(
                      fontSize: UiUtils.responsiveFontSize(context, 16),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: UiUtils.responsivePadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          UiUtils.responsiveWidth(context, 5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: UiUtils.responsiveWidth(context, 4),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
