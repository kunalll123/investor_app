import 'package:flutter/material.dart';

import 'package:investor_app/utils/ui_utils.dart';
import '../../data/models/deal_model.dart';
import '../screens/deal_details_screen.dart';

class DealCard extends StatelessWidget {
  final Deal deal;

  const DealCard({super.key, required this.deal});

  Color getRiskColor(String risk) {
    switch (risk) {
      case "Low":
        return Colors.green;
      case "Medium":
        return Colors.orange;
      case "High":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getStatusColor(String status) {
    return status == "Open" ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DealDetailsScreen(deal: deal)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: UiUtils.responsiveHeight(context, 1.2),
          horizontal: UiUtils.responsiveWidth(context, 3),
        ),
        padding: UiUtils.responsivePadding(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            UiUtils.responsiveWidth(context, 5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.08),
              blurRadius: UiUtils.responsiveWidth(context, 4),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    deal.companyName,
                    style: TextStyle(
                      fontSize: UiUtils.responsiveFontSize(context, 17),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),

                /// Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: UiUtils.responsiveWidth(context, 3),
                    vertical: UiUtils.responsiveHeight(context, 0.7),
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(deal.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      UiUtils.responsiveWidth(context, 5),
                    ),
                  ),
                  child: Text(
                    deal.status,
                    style: TextStyle(
                      color: getStatusColor(deal.status),
                      fontWeight: FontWeight.bold,
                      fontSize: UiUtils.responsiveFontSize(context, 12),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 0.8)),

            /// Industry
            Text(
              deal.industry,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: UiUtils.responsiveFontSize(context, 13),
              ),
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 2)),

            /// 📊 ROI + Risk
            Row(
              children: [
                /// ROI
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: UiUtils.responsiveHeight(context, 1.5),
                      horizontal: UiUtils.responsiveWidth(context, 2.5),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        UiUtils.responsiveWidth(context, 4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Return",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 12),
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: UiUtils.responsiveHeight(context, 0.5),
                        ),
                        Text(
                          "${deal.roi}%",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: UiUtils.responsiveWidth(context, 3)),

                /// Risk
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: UiUtils.responsiveHeight(context, 1.5),
                    ),
                    decoration: BoxDecoration(
                      color: getRiskColor(deal.risk).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        UiUtils.responsiveWidth(context, 4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Risk",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 12),
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: UiUtils.responsiveHeight(context, 0.5),
                        ),
                        Text(
                          deal.risk,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: getRiskColor(deal.risk),
                            fontSize: UiUtils.responsiveFontSize(context, 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
