import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rtinovations/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:rtinovations/screens/employee_details.dart';
import 'package:rtinovations/utility/snack_bar.dart';

class HomePage extends StatefulWidget {
  static const id = "HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<EmployeeListBloc, EmployeeListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              "Employee List",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state.employees.isEmpty) {
                return noDataBackground();
              } else if (state.employees.isNotEmpty) {
                return SizedBox(
                  height: screenSize.height,
                  child: Column(
                    children: [
                      Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        height: 50,
                        color: const Color(0xFFF2F2F2),
                        child: Text(
                          "Current Employees",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500, fontSize: 18, color: const Color(0xFF1DA1F2)),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.4,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            if (!isDateBeforeToday(state.employees[index].endDate)) {
                              return const Divider();
                            }
                            return const SizedBox();
                          },
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.employees.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (!isDateBeforeToday(state.employees[index].endDate)) {
                              return SwipeActionCell(
                                key: ObjectKey(state.employees[index].id),
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      title: "",
                                      icon: Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                      performsFirstActionWithFullSwipe: true,
                                      onTap: (_) async {
                                        context
                                            .read<EmployeeListBloc>()
                                            .add(DeleteEmployeeEvent(employee: state.employees[index]));
                                        showSnackbar(context, "Employee data has been Deleted");
                                      },
                                      color: Colors.red),
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<EmployeeListBloc>(),
                                          child: EmployeeDetails(
                                            key: UniqueKey(),
                                            employee: state.employees[index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      state.employees[index].name,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.employees[index].role,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: const Color(0xFF949C9E),
                                            )),
                                        Text("${state.employees[index].startDate} - ${state.employees[index].endDate}",
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: const Color(0xFF949C9E),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        height: 50,
                        color: const Color(0xFFF2F2F2),
                        child: Text(
                          "Previous Employees",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500, fontSize: 18, color: const Color(0xFF1DA1F2)),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.35,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            if (state.employees[index].endDate != "No date" ||
                                isDateBeforeToday(state.employees[index].endDate)) {
                              return const Divider();
                            }
                            return const SizedBox();
                          },
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.employees.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (isDateBeforeToday(state.employees[index].endDate)) {
                              //print(isDateBeforeToday(state.employees[index][3]));
                              return SwipeActionCell(
                                key: ObjectKey(state.employees[index].id),
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      title: "",
                                      icon: Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                      performsFirstActionWithFullSwipe: true,
                                      onTap: (_) async {
                                        context
                                            .read<EmployeeListBloc>()
                                            .add(DeleteEmployeeEvent(employee: state.employees[index]));
                                        showSnackbar(context, "Employee data has been Deleted");
                                      },
                                      color: Colors.red),
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EmployeeDetails(key: UniqueKey(), employee: state.employees[index]),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      state.employees[index].name,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.employees[index].role,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: const Color(0xFF949C9E),
                                            )),
                                        Text("${state.employees[index].startDate} - ${state.employees[index].endDate}",
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: const Color(0xFF949C9E),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Error"),
              );
            },
          ),
          floatingActionButton: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 0.0,
              highlightElevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<EmployeeListBloc>(),
                      child: const EmployeeDetails(
                        employee: null,
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  Center noDataBackground() {
    return Center(
        child: Image.asset(
      "assets/home_screen_background.png",
      height: 250,
      width: 250,
    ));
  }

  bool isDateBeforeToday(String dateString) {
    if (dateString == "No date") return false;
    DateTime currentDate = DateTime.now();
    DateTime date = DateFormat("dd MMM yyyy").parse(dateString);
    return date.isBefore(currentDate);
  }
}
