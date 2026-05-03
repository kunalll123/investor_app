import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:investor_app/utils/ui_utils.dart';

import '../../logic/blocs/intrests/interest_bloc.dart';
import '../../logic/blocs/intrests/interest_state.dart';
import '../../logic/blocs/intrests/interest_event.dart';

class MyInterestsScreen extends StatelessWidget {
  const MyInterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<InterestBloc>().add(LoadInterests());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
        title: Text(
          "My Interests",
          style: TextStyle(
            color: const Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
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

        child: BlocBuilder<InterestBloc, InterestState>(
          builder: (context, state) {
            /// 🔹 Empty State
            if (state is InterestInitial ||
                (state is InterestLoaded && state.deals.isEmpty)) {
              return Center(
                child: Text(
                  "No interested deals yet",
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(context, 16),
                    color: Colors.black54,
                  ),
                ),
              );
            }

            /// 🔹 Loaded
            if (state is InterestLoaded) {
              final deals = state.deals;

              return ListView.builder(
                padding: EdgeInsets.only(
                  top: UiUtils.responsiveHeight(context, 1.5),
                  bottom: UiUtils.responsiveHeight(context, 3),
                ),
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index];

                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: UiUtils.responsiveHeight(context, 1),
                      horizontal: UiUtils.responsiveWidth(context, 4),
                    ),
                    padding: UiUtils.responsivePadding(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.green.shade50],
                      ),
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

                    child: Row(
                      children: [
                        /// 📊 LEFT SIDE
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.companyName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: UiUtils.responsiveFontSize(
                                    context,
                                    16,
                                  ),
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),

                              SizedBox(
                                height: UiUtils.responsiveHeight(context, 0.8),
                              ),

                              Text(
                                deal.industry,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: UiUtils.responsiveFontSize(
                                    context,
                                    13,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: UiUtils.responsiveHeight(context, 1.5),
                              ),

                              /// ROI Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: UiUtils.responsiveWidth(
                                    context,
                                    3,
                                  ),
                                  vertical: UiUtils.responsiveHeight(
                                    context,
                                    0.6,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF2E7D32,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    UiUtils.responsiveWidth(context, 3),
                                  ),
                                ),
                                child: Text(
                                  "ROI: ${deal.roi}%",
                                  style: TextStyle(
                                    color: const Color(0xFF2E7D32),
                                    fontWeight: FontWeight.bold,
                                    fontSize: UiUtils.responsiveFontSize(
                                      context,
                                      12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 🗑️ DELETE BUTTON
                        GestureDetector(
                          onTap: () {
                            context.read<InterestBloc>().add(
                              RemoveInterest(deal),
                            );

                            UiUtils.showErrorSnackBar(
                              context,
                              "Removed from Interests",
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                              UiUtils.responsiveWidth(context, 2.5),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: UiUtils.responsiveIconSize(context, 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
