part of 'employee_details_bloc.dart';

class EmployeeDetailsState extends Equatable {
  final Employee employee;

  const EmployeeDetailsState({required this.employee});

  factory EmployeeDetailsState.initial() {
    return EmployeeDetailsState(employee: Employee(name: "", endDate: "No date", startDate: formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]), role: "", id: "-1"));
  }

  @override
  List<Object> get props => [employee];

  @override
  String toString() {
    return 'EmployeeDetailsState{employee name: ${employee.name}, role : ${employee.role}, startDate :${employee.startDate} endDate:${employee.endDate}';
  }

  EmployeeDetailsState copyWith({
    Employee? employee,
  }) {
    return EmployeeDetailsState(
      employee: employee ?? this.employee,
    );
  }
}
