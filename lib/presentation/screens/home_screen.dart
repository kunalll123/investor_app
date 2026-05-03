import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/logic/blocs/deals/deal_bloc.dart';
import 'package:investor_app/logic/blocs/deals/deal_event.dart';
import 'package:investor_app/logic/blocs/deals/deal_state.dart';
import 'package:investor_app/presentation/screens/my_interests_screen.dart';
import 'package:investor_app/presentation/widgets/deal_card.dart';
import 'package:investor_app/presentation/widgets/filter_sheet.dart';
import 'package:investor_app/presentation/widgets/shimmer_card.dart';
import 'package:investor_app/utils/ui_utils.dart';

import '../../core/utils/session_manager.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkData();
  }

  void checkData() async {
    String? email = await SessionManager.getUserEmail();
    bool loggedIn = await SessionManager.isLoggedIn();

    print("Email: $email");
    print("LoggedIn: $loggedIn");
  }

  /// 🔥 Responsive Icon Button
  Widget _buildIconButton(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: UiUtils.responsiveWidth(context, 1.5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(UiUtils.responsiveWidth(context, 2.5)),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.15),
                blurRadius: UiUtils.responsiveWidth(context, 3),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: UiUtils.responsiveIconSize(context, 20),
          ),
        ),
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
        title: Text(
          "Hi there 👋",
          style: TextStyle(
            color: const Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
            fontSize: UiUtils.responsiveFontSize(context, 18),
          ),
        ),
        actions: [
          _buildIconButton(context, Icons.logout, () async {
            await SessionManager.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }),

          _buildIconButton(context, Icons.filter_list, () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (bottomContext) {
                return BlocProvider.value(
                  value: context.read<DealBloc>(),
                  child: const FilterSheet(),
                );
              },
            );
          }),

          _buildIconButton(context, Icons.favorite, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyInterestsScreen()),
            );
          }),
        ],
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
        child: Column(
          children: [
            SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

            /// 🔎 Search Box
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UiUtils.responsiveWidth(context, 4),
              ),
              child: Container(
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
                      color: Colors.green.withOpacity(0.1),
                      blurRadius: UiUtils.responsiveWidth(context, 4),
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(context, 14),
                  ),
                  decoration: InputDecoration(
                    hintText: "Search companies...",
                    prefixIcon: Icon(
                      Icons.search,
                      size: UiUtils.responsiveIconSize(context, 22),
                      color: const Color(0xFF2E7D32),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: UiUtils.responsiveHeight(context, 2),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<DealBloc>().add(SearchDeals(value));
                  },
                ),
              ),
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 2)),

            /// 📊 Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UiUtils.responsiveWidth(context, 4),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Investment Opportunities",
                  style: TextStyle(
                    fontSize: UiUtils.responsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ),
            ),

            SizedBox(height: UiUtils.responsiveHeight(context, 1.5)),

            /// 🔥 Deal List
            Expanded(
              child: BlocBuilder<DealBloc, DealState>(
                builder: (context, state) {
                  if (state is DealLoading) {
                    return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (_, __) => const ShimmerCard(),
                    );
                  }

                  if (state is DealError) {
                    return Center(
                      child: Text(
                        "Error: ${state.message}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: UiUtils.responsiveFontSize(context, 14),
                        ),
                      ),
                    );
                  }

                  if (state is DealLoaded) {
                    final deals = state.deals;

                    if (deals.isEmpty) {
                      return Center(
                        child: Text(
                          "No deals found",
                          style: TextStyle(
                            fontSize: UiUtils.responsiveFontSize(context, 16),
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: const Color(0xFF2E7D32),
                      onRefresh: () async {
                        context.read<DealBloc>().add(LoadDeals());
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: UiUtils.responsiveWidth(context, 2.5),
                          vertical: UiUtils.responsiveHeight(context, 1),
                        ),
                        itemCount: deals.length,
                        itemBuilder: (context, index) {
                          return DealCard(deal: deals[index]);
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
