class Employee {
  final String id;
  final String name;
  final String role;
  final String startDate;
  final String endDate;

  Employee({required this.id, required this.name, required this.role, required this.startDate, required this.endDate});

  @override
  String toString() {
    return 'Employee{id: $id, name: $name, role: $role, startDate: $startDate, endDate: $endDate}';
  }
}
