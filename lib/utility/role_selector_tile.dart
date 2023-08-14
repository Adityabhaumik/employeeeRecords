


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtinovations/bloc/employee_details_bloc/employee_details_bloc.dart';
import 'package:rtinovations/utility/bottom_modal.dart';

GestureDetector roleSelectorTile(BuildContext context,TextEditingController roleController) {
  return GestureDetector(
    onTap: () {
      _showModalSheet(context,roleController);
    },
    child: Container(
      constraints: const BoxConstraints(maxHeight: 40.0),
      child: TextField(
        controller: roleController,
        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
        enabled: false,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5E5))),
            prefixIcon: Icon(
              Icons.work_outline,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            hintText: 'Select Role',
            hintStyle: const TextStyle(color: Color(0xFF949C9E)),
            suffixIcon: Icon(
              Icons.arrow_drop_down_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            )),
      ),
    ),
  );
}

_showModalSheet(BuildContext context,TextEditingController roleController) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BottomModalSheet();
    },
  ).then((value) {
    if (value != null) {
      roleController.text = value;
      context.read<EmployeeDetailsBloc>().add(RoleChangeEvent(newRole: value));
    }
  });
}