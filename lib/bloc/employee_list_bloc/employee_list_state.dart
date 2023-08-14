part of 'employee_list_bloc.dart';

class EmployeeListState extends Equatable {
  final List<Employee> employees;

  EmployeeListState({required this.employees});

  factory EmployeeListState.initial() {
    return EmployeeListState(employees: []);
  }

  @override
  List<Object> get props => [employees];

  @override
  String toString() {
    return 'EmployeeListState{employees: $employees}';
  }

  EmployeeListState copyWith({
    List<Employee>? employees,
  }) {
    return EmployeeListState(
      employees: employees ?? this.employees,
    );
  }
}
