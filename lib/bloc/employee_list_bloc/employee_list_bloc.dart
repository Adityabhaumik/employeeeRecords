import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rtinovations/models/employee_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'employee_list_event.dart';

part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(EmployeeListState.initial()) {
    loadDataFromSharedPreferences();
    on<AddEmployeeEvent>((event, emit) {
      final newEmployeeList = [...state.employees, event.employee];
      emit(state.copyWith(employees: newEmployeeList));
      saveDataToSharedPreferences();
    });
    on<DeleteEmployeeEvent>((event, emit) {
      List<Employee> newEmployeeList = [];
      for (Employee employee in state.employees) {
        if (employee.id != event.employee.id) {
          newEmployeeList.add(employee);
        }
      }
      emit(state.copyWith(employees: newEmployeeList));
      saveDataToSharedPreferences();
    });
    on<UpdateEmployeeEvent>((event, emit) {
      List<Employee> newEmployeeList = [];
      for (Employee employee in state.employees) {
        if (employee.id == event.employee.id) {
          newEmployeeList.add(event.employee);
        } else {
          newEmployeeList.add(employee);
        }
      }
      emit(state.copyWith(employees: newEmployeeList));
      saveDataToSharedPreferences();
    });
  }

  void saveDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataToStore = [];
    for (int i = 0; i < state.employees.length; i++) {
      List<String> thisEmployee = [];
      thisEmployee.add(state.employees[i].id);
      thisEmployee.add(state.employees[i].name);
      thisEmployee.add(state.employees[i].role);
      thisEmployee.add(state.employees[i].startDate);
      thisEmployee.add(state.employees[i].endDate);
      String result = concatenateStrings(thisEmployee);
      dataToStore.add(result);
    }

    for (String str in dataToStore) {
      List<String> temp = (separateString(str));
      Employee newEmployee = Employee(id: temp[0], name: temp[1], role: temp[2], startDate: temp[3], endDate: temp[4]);
      print(newEmployee);
    }
    await prefs.setStringList('data', dataToStore);
  }

  void loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedData = prefs.getStringList('data') ?? [];
    List<Employee> fetchedEmployees = [];
    for (int i = 0; i < storedData.length; i++) {
      List<String> result = separateString(storedData[i]);
      Employee newEmployee =
          Employee(id: result[0], name: result[1], role: result[2], startDate: result[3], endDate: result[4]);
      fetchedEmployees.add(newEmployee);
    }
    emit(EmployeeListState(employees: fetchedEmployees));
  }
}

List<String> separateString(String inputString) {
  List<String> separatedList = inputString.split(',');
  return separatedList;
}

String concatenateStrings(List<String> strings) {
  String concatenatedString = strings.join(',');
  return concatenatedString;
}
