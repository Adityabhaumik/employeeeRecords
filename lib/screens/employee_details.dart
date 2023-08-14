import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rtinovations/bloc/employee_details_bloc/employee_details_bloc.dart';
import 'package:rtinovations/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:rtinovations/models/employee_data_model.dart';
import 'package:rtinovations/utility/name_selector_tile.dart';
import 'package:rtinovations/utility/ri_end_date_picker.dart';
import 'package:rtinovations/utility/ri_start_date_picker.dart';
import 'package:rtinovations/utility/role_selector_tile.dart';
import 'package:rtinovations/utility/snack_bar.dart';
import 'package:uuid/uuid.dart';

class EmployeeDetails extends StatefulWidget {
  static const id = "EmployeeDetails";
  final Employee? employee;

  const EmployeeDetails({Key? key, this.employee}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  String _startDateString = "";
  String _endDateString = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    if (widget.employee == null) {
      _startDateString = "Today";
      _endDateString = "No date";
    } else {
      _nameController.text = widget.employee!.name;
      _roleController.text = widget.employee!.role;
      _startDateString = widget.employee!.startDate;
      _endDateString = widget.employee!.endDate == "No date" ? "No date" : widget.employee!.endDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider<EmployeeDetailsBloc>(
      create: (context) => EmployeeDetailsBloc(initialEmployee: widget.employee),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 0.0,
            leading: const SizedBox(),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              "Add Employee Details",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    nameSelectorTile(context, _nameController),
                    const SizedBox(
                      height: 20,
                    ),
                    roleSelectorTile(context, _roleController),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 40.0, maxWidth: screenSize.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: startDateSelectorTile(context),
                          ),
                          SizedBox(
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: endDateSelectorTile(context),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 35,
                                  width: screenSize.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDF8FF),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Color(0xFF1DA1F2)),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (context.read<EmployeeDetailsBloc>().state.employee.name.isEmpty ||
                                      context.read<EmployeeDetailsBloc>().state.employee.role.isEmpty ||
                                      !checkEndDateValidity(_startDateString, _endDateString)) {
                                    showSnackbar(context, "Please Enter Correct Information");
                                    return;
                                  }
                                  if (widget.employee == null) {
                                    Employee newEmployee = Employee(
                                        id: const Uuid().v4(),
                                        name: context.read<EmployeeDetailsBloc>().state.employee.name,
                                        role: context.read<EmployeeDetailsBloc>().state.employee.role,
                                        startDate: context.read<EmployeeDetailsBloc>().state.employee.startDate,
                                        endDate: context.read<EmployeeDetailsBloc>().state.employee.endDate);
                                    context.read<EmployeeListBloc>().add(AddEmployeeEvent(employee: newEmployee));
                                  } else {
                                    Employee newEmployee = Employee(
                                        id: widget.employee!.id,
                                        name: context.read<EmployeeDetailsBloc>().state.employee.name,
                                        role: context.read<EmployeeDetailsBloc>().state.employee.role,
                                        startDate: context.read<EmployeeDetailsBloc>().state.employee.startDate,
                                        endDate: context.read<EmployeeDetailsBloc>().state.employee.endDate);
                                    context.read<EmployeeListBloc>().add(UpdateEmployeeEvent(employee: newEmployee));
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 35,
                                  width: screenSize.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1DA1F2),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  GestureDetector startDateSelectorTile(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? temp = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return StartDatePickerWithButtons(
              initialDate: _startDateString == "Today" ? null : _startDateString,
            );
          },
        );
        if (temp != null) {
          _startDateString = temp;
          context.read<EmployeeDetailsBloc>().add(StartDateChangeEvent(newStartDate: _startDateString));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              _startDateString,
              style: const TextStyle(
                color: Color(0xFF949C9E),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector endDateSelectorTile(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? selectedDate = await showDialog(
          context: context,
          builder: (BuildContext _) {
            return EndDatePickerWithButtons(initialDate: _endDateString == "No date" ? null : _endDateString);
          },
        );
        if (selectedDate != null) {
          _endDateString = selectedDate;
          context.read<EmployeeDetailsBloc>().add(EndDateChangeEvent(newEndDate: _endDateString));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              context.watch<EmployeeDetailsBloc>().state.employee.endDate,
              style: const TextStyle(
                color: Color(0xFF949C9E),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkEndDateValidity(String startDate, String endDate) {
    if (endDate == "No date") return true;
    DateTime startDateTime = DateFormat("dd MMM yyyy").parse(startDate);
    DateTime endDateTime = DateFormat("dd MMM yyyy").parse(endDate);
    return startDateTime.isBefore(endDateTime);
  }
}
