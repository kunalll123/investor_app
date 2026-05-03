import 'package:flutter/material.dart';
import 'package:investor_app/utils/ui_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.green.shade100,
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: UiUtils.responsiveHeight(context, 1.2),
          horizontal: UiUtils.responsiveWidth(context, 3),
        ),
        padding: UiUtils.responsivePadding(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade50],
          ),
          borderRadius: BorderRadius.circular(
            UiUtils.responsiveWidth(context, 5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 Title + status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(
                  context,
                  width: UiUtils.responsiveWidth(context, 35),
                  height: UiUtils.responsiveHeight(context, 1.5),
                ),
                _box(
                  context,
                  width: UiUtils.responsiveWidth(context, 18),
                  height: UiUtils.responsiveHeight(context, 1.5),
                ),
              ],
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 1.2)),

            /// Industry
            _box(
              context,
              width: UiUtils.responsiveWidth(context, 25),
              height: UiUtils.responsiveHeight(context, 1.2),
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 2)),

            /// ROI + Risk
            Row(
              children: [
                Expanded(
                  child: _box(
                    context,
                    height: UiUtils.responsiveHeight(context, 6),
                  ),
                ),
                SizedBox(width: UiUtils.responsiveWidth(context, 3)),
                Expanded(
                  child: _box(
                    context,
                    height: UiUtils.responsiveHeight(context, 6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(
    BuildContext context, {
    double width = double.infinity,
    double height = 10,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          UiUtils.responsiveWidth(context, 3),
        ),
      ),
    );
  }
}
