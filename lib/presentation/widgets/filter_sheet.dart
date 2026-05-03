import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:investor_app/logic/blocs/deals/deal_bloc.dart';
import 'package:investor_app/logic/blocs/deals/deal_event.dart';
import 'package:investor_app/utils/ui_utils.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String? selectedRisk;
  String? selectedIndustry;
  RangeValues roiRange = const RangeValues(0, 30);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UiUtils.responsivePadding(context),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F4),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(UiUtils.responsiveWidth(context, 6)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Drag Handle
          Center(
            child: Container(
              height: UiUtils.responsiveHeight(context, 0.6),
              width: UiUtils.responsiveWidth(context, 12),
              margin: EdgeInsets.only(
                bottom: UiUtils.responsiveHeight(context, 2),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(
                  UiUtils.responsiveWidth(context, 2),
                ),
              ),
            ),
          ),

          /// 🔹 Title
          Text(
            "Filter Deals",
            style: TextStyle(
              fontSize: UiUtils.responsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
            ),
          ),

          SizedBox(height: UiUtils.responsiveHeight(context, 2)),

          /// 🔹 Risk Dropdown
          _buildDropdown(
            context,
            hint: "Select Risk",
            value: selectedRisk,
            items: ["Low", "Medium", "High"],
            onChanged: (value) {
              setState(() => selectedRisk = value);
            },
          ),

          SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

          /// 🔹 Industry Dropdown
          _buildDropdown(
            context,
            hint: "Select Industry",
            value: selectedIndustry,
            items: ["Fintech", "Agriculture", "Healthcare"],
            onChanged: (value) {
              setState(() => selectedIndustry = value);
            },
          ),

          SizedBox(height: UiUtils.responsiveHeight(context, 2)),

          /// 🔹 ROI Label
          Text(
            "ROI Range",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
              fontSize: UiUtils.responsiveFontSize(context, 14),
            ),
          ),

          /// 🔹 Slider
          RangeSlider(
            activeColor: const Color(0xFF2E7D32),
            inactiveColor: Colors.green.shade100,
            values: roiRange,
            min: 0,
            max: 30,
            divisions: 6,
            labels: RangeLabels(
              roiRange.start.toString(),
              roiRange.end.toString(),
            ),
            onChanged: (values) {
              setState(() => roiRange = values);
            },
          ),

          SizedBox(height: UiUtils.responsiveHeight(context, 2)),

          /// 🔹 Apply Button
          SizedBox(
            width: double.infinity,
            height: UiUtils.responsiveHeight(context, 7),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    UiUtils.responsiveWidth(context, 6),
                  ),
                ),
                elevation: 5,
              ),
              onPressed: () {
                context.read<DealBloc>().add(
                  FilterDeals(
                    industry: selectedIndustry,
                    risk: selectedRisk,
                    minRoi: roiRange.start.toInt(),
                  ),
                );

                Navigator.pop(context); // 👈 close sheet
              },
              child: Text(
                "Apply Filter",
                style: TextStyle(
                  fontSize: UiUtils.responsiveFontSize(context, 15),
                  color: Colors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: UiUtils.responsiveHeight(context, 1)),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UiUtils.responsiveWidth(context, 3),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          UiUtils.responsiveWidth(context, 8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: UiUtils.responsiveWidth(context, 3),
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(
          hint,
          style: TextStyle(fontSize: UiUtils.responsiveFontSize(context, 14)),
        ),
        decoration: const InputDecoration(border: InputBorder.none),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(context, 14),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
