import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/data/repositories/deal_repository.dart';
import 'package:investor_app/logic/blocs/deals/deal_bloc.dart';
import 'package:investor_app/logic/blocs/deals/deal_event.dart';
import 'package:investor_app/logic/blocs/intrests/interest_bloc.dart';
import 'package:investor_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(const InvestorApp());
}

class InvestorApp extends StatelessWidget {
  const InvestorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DealBloc(DealRepository())..add(LoadDeals()),
        ),
        BlocProvider(create: (_) => InterestBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Investor App',
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
