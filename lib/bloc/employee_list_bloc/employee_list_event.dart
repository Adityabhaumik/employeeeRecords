part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}
class FetchedDataEvent extends EmployeeListEvent {
  final List<Employee> savedEmployeeList;

  FetchedDataEvent({required this.savedEmployeeList});

  @override
  String toString() {
    return 'FetchedDataEvent{employeeList: $savedEmployeeList}';
  }

  @override
  List<Object> get props => [savedEmployeeList];
}
class AddEmployeeEvent extends EmployeeListEvent {
  final Employee employee;

  AddEmployeeEvent({required this.employee});

  @override
  List<Object> get props => [employee];

  @override
  String toString() {
    return 'AddEmployeeEvent{employee: $employee}';
  }
}

class DeleteEmployeeEvent extends EmployeeListEvent {
  final Employee employee;

  DeleteEmployeeEvent({required this.employee});

  @override
  List<Object> get props => [employee];

  @override
  String toString() {
    return 'DeleteEmployeeEvent{employee: $employee}';
  }
}
class UpdateEmployeeEvent extends EmployeeListEvent {
  final Employee employee;

  UpdateEmployeeEvent({required this.employee});

  @override
  List<Object> get props => [employee];

  @override
  String toString() {
    return 'UpdateEmployeeEvent{employee: $employee}';
  }
}
