import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtinovations/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:rtinovations/screens/employee_details.dart';
import 'package:rtinovations/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeListBloc>(create: (context) => EmployeeListBloc()),
        //BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Real Time Innovations',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1DA1F2)),
          useMaterial3: true,
        ),
        home: HomePage(),
        routes: {
          HomePage.id: (context) => const HomePage(),
          EmployeeDetails.id: (context) => EmployeeDetails(),
        },
      ),
    );
  }
}
