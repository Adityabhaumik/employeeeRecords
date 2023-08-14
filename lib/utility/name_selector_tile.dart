
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtinovations/bloc/employee_details_bloc/employee_details_bloc.dart';

Container nameSelectorTile(BuildContext context,TextEditingController nameController) {
  return Container(
    constraints: const BoxConstraints(maxHeight: 40.0),
    child: TextField(
      controller: nameController,
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: (value) {
        if (value.isNotEmpty) {
          context.read<EmployeeDetailsBloc>().add(NameChangeEvent(newName: value));
        }
      },
      decoration: InputDecoration(
          enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFFE5E5E5))),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5E5))),
          prefixIcon:
          Icon(Icons.person_2_outlined, color: Theme.of(context).colorScheme.inversePrimary),
          hintText: 'Employee name',
          hintStyle: const TextStyle(color: Color(0xFF949C9E))),
    ),
  );
}
