import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum optionSelected { today, nextMonday, nextTuesday, after1Week, none }

class StartDatePickerWithButtons extends StatefulWidget {
  final String? initialDate;
  const StartDatePickerWithButtons({super.key,this.initialDate});

  @override
  StartDatePickerWithButtonsState createState() => StartDatePickerWithButtonsState();
}

class StartDatePickerWithButtonsState extends State<StartDatePickerWithButtons> {
  DateTime _selectedDate = DateTime.now();
  String _selectedDateString = formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]);
  optionSelected _selectedOption = optionSelected.today;
  late DateTime _nextMonday;
  late DateTime _nextTuesday;
  late DateTime _after1Week;

  @override
  void initState() {
    // TODO: implement initState
    DateTime currentDate = DateTime.now();

    //monday
    int daysUntilNextMonday = DateTime.monday - currentDate.weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    _nextMonday = currentDate.add(Duration(days: daysUntilNextMonday));
    //tuesday
    int daysUntilNextTuesday = DateTime.tuesday - currentDate.weekday;
    if (daysUntilNextTuesday <= 0) {
      daysUntilNextTuesday += 7;
    }
    _nextTuesday = currentDate.add(Duration(days: daysUntilNextTuesday));

    //after1Week
    _after1Week = currentDate.add(const Duration(days: 7));
    //
    if(widget.initialDate!=null){
      initialDateSetter();
    }
    super.initState();
  }

  void initialDateSetter(){
    DateTime selectDate = DateFormat("dd MMM yyyy").parse(widget.initialDate!);
    String tday = (formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]));
    String nextMondayString = (formatDate(_nextMonday, [d, ' ', M, ' ', yyyy]));
    String nextTuesdayString = (formatDate(_nextTuesday, [d, ' ', M, ' ', yyyy]));
    String after1WeekString = (formatDate(_after1Week, [d, ' ', M, ' ', yyyy]));

    if (widget.initialDate == tday) {
      setNewDate(DateTime.now(), optionSelected.today);
    } else if (widget.initialDate == nextMondayString) {
      setNewDate(_nextMonday, optionSelected.nextMonday);
    } else if (widget.initialDate == nextTuesdayString) {
      setNewDate(_nextTuesday, optionSelected.nextTuesday);
    } else if (widget.initialDate == after1WeekString) {
      setNewDate(_after1Week, optionSelected.after1Week);
    } else {
      setNewDate(selectDate, optionSelected.none);
    }
  }
  void setNewDate(DateTime date, optionSelected selection) {
    setState(() {
      _selectedDate = date;
      _selectedDateString = formatDate(_selectedDate, [d, ' ', M, ' ', yyyy]);
      _selectedOption = selection;
      //print("in function $_selectedDateString $selection");
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: screenSize.height * 0.65,
        width: screenSize.width,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                daySelectionOptionButton(screenSize, "Today", () {
                  setNewDate(DateTime.now(), optionSelected.today);
                }, _selectedOption == optionSelected.today),
                daySelectionOptionButton(screenSize, "Next Monday", () {
                  setNewDate(_nextMonday, optionSelected.nextMonday);
                }, _selectedOption == optionSelected.nextMonday),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                daySelectionOptionButton(screenSize, "Next Tuesdays", () {
                  setNewDate(_nextTuesday, optionSelected.nextTuesday);
                }, _selectedOption == optionSelected.nextTuesday),
                daySelectionOptionButton(screenSize, "After 1 Week", () {
                  setNewDate(_after1Week, optionSelected.after1Week);
                }, _selectedOption == optionSelected.after1Week),
              ],
            ),
            const SizedBox(height: 5),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                  customModePickerIcon: const SizedBox(),
                  lastMonthIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: screenSize.width * 0.3,
                          child: const Icon(
                            Icons.arrow_left_rounded,
                            size: 40,
                          )),
                    ],
                  ),
                  nextMonthIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: screenSize.width * 0.3,
                          child: const Icon(
                            Icons.arrow_right_rounded,
                            size: 40,
                          ))
                    ],
                  ),
                  calendarType: CalendarDatePicker2Type.single,
                  centerAlignModePicker: true),
              onValueChanged: (date) {
                String selectDate = (formatDate(date[0]!, [d, ' ', M, ' ', yyyy]));
                String tday = (formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]));
                String nextMondayString = (formatDate(_nextMonday, [d, ' ', M, ' ', yyyy]));
                String nextTuesdayString = (formatDate(_nextTuesday, [d, ' ', M, ' ', yyyy]));
                String after1WeekString = (formatDate(_after1Week, [d, ' ', M, ' ', yyyy]));

                if (selectDate == tday) {
                  setNewDate(DateTime.now(), optionSelected.today);
                } else if (selectDate == nextMondayString) {
                  setNewDate(_nextMonday, optionSelected.nextMonday);
                } else if (selectDate == nextTuesdayString) {
                  setNewDate(_nextTuesday, optionSelected.nextTuesday);
                } else if (selectDate == after1WeekString) {
                  setNewDate(_after1Week, optionSelected.after1Week);
                } else {
                  setNewDate(date[0]!, optionSelected.none);
                }
              },
              value: [
                _selectedDate,
              ],
            ),
            const Divider(
              height: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF1DA1F2),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          _selectedDateString,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context,null);
                          },
                          child: Container(
                            height: 35,
                            width: screenSize.width * 0.15,
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF8FF),
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
                            Navigator.pop(context,_selectedDateString);
                          },
                          child: Container(
                            height: 35,
                            width: screenSize.width * 0.15,
                            decoration: BoxDecoration(
                              color: Color(0xFF1DA1F2),
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
            )
          ],
        ),
      ),
    );
  }

  GestureDetector daySelectionOptionButton(Size screenSize, String label, Function handler, bool isSelected) {
    return GestureDetector(
      onTap: () {
        handler();
      },
      child: Container(
        height: 35,
        width: screenSize.width * 0.4,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1DA1F2) : const Color(0xFFEDF8FF),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1DA1F2)),
        )),
      ),
    );
  }
}
