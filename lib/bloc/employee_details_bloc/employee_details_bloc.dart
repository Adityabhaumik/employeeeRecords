import 'package:bloc/bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:equatable/equatable.dart';
import 'package:rtinovations/models/employee_data_model.dart';

part 'employee_details_event.dart';

part 'employee_details_state.dart';

class EmployeeDetailsBloc extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  final Employee? initialEmployee;

  EmployeeDetailsBloc({this.initialEmployee})
      : super(initialEmployee == null ? EmployeeDetailsState.initial() : EmployeeDetailsState(employee: initialEmployee)) {

    on<NameChangeEvent>((event, emit) {
      final Employee newEmployee = Employee(
          id: state.employee.id,
          name: event.newName,
          role: state.employee.role,
          startDate: state.employee.startDate,
          endDate: state.employee.endDate);
      emit(state.copyWith(employee: newEmployee));
    });

    on<RoleChangeEvent>((event, emit) {
      final Employee newEmployee = Employee(
          id: state.employee.id,
          name: state.employee.name,
          role: event.newRole,
          startDate: state.employee.startDate,
          endDate: state.employee.endDate);
      emit(state.copyWith(employee: newEmployee));
    });
    on<StartDateChangeEvent>((event, emit) {
      final Employee newEmployee = Employee(
          id: state.employee.id,
          name: state.employee.name,
          role: state.employee.role,
          startDate: event.newStartDate,
          endDate: state.employee.endDate);
      emit(state.copyWith(employee: newEmployee));
      print(state);
    });
    on<EndDateChangeEvent>((event, emit) {
      final Employee newEmployee = Employee(
          id: state.employee.id,
          name: state.employee.name,
          role: state.employee.role,
          startDate: state.employee.startDate,
          endDate: event.newEndDate);
      emit(state.copyWith(employee: newEmployee));
      print(state);
    });
  }
}
