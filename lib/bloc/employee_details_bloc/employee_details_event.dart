part of 'employee_details_bloc.dart';

abstract class EmployeeDetailsEvent extends Equatable {
  const EmployeeDetailsEvent();

  @override
  List<Object> get props => [];
}

class NameChangeEvent extends EmployeeDetailsEvent {
  final String newName;

  const NameChangeEvent({required this.newName});

  @override
  String toString() {
    return 'NameChangeEvent{newName: $newName}';
  }

  @override
  List<Object> get props => [newName];
}



class RoleChangeEvent extends EmployeeDetailsEvent {
  final String newRole;

  const RoleChangeEvent({required this.newRole});

  @override
  String toString() {
    return 'RoleChangeEvent{newName: $newRole}';
  }

  @override
  List<Object> get props => [newRole];
}

class StartDateChangeEvent extends EmployeeDetailsEvent {
  final String newStartDate;

  const StartDateChangeEvent({required this.newStartDate});

  @override
  String toString() {
    return 'StartDateChangeEvent{newName: $newStartDate}';
  }

  @override
  List<Object> get props => [newStartDate];
}

class EndDateChangeEvent extends EmployeeDetailsEvent {
  final String newEndDate;

  const EndDateChangeEvent({required this.newEndDate});

  @override
  String toString() {
    return 'EndDateChangeEvent{newName: $newEndDate}';
  }

  @override
  List<Object> get props => [newEndDate];
}
