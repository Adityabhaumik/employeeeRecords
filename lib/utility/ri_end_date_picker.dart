import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum optionSelected { today, noDate, none }

class EndDatePickerWithButtons extends StatefulWidget {
  final String? initialDate;

  const EndDatePickerWithButtons({super.key, this.initialDate});

  @override
  EndDatePickerWithButtonsState createState() => EndDatePickerWithButtonsState();
}

class EndDatePickerWithButtonsState extends State<EndDatePickerWithButtons> {
  DateTime _selectedDate = DateTime.now();
  String _selectedDateString = formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]);
  optionSelected _selectedOption = optionSelected.today;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.initialDate != null) {
      initialDateSetter();
    }
    super.initState();
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
                daySelectionOptionButton(screenSize, "No date", () {
                  DateTime noDateAndTime = DateTime(0, 1, 1, 0, 0, 0);
                  setNewDate(noDateAndTime, optionSelected.noDate);
                }, _selectedOption == optionSelected.noDate),
                daySelectionOptionButton(screenSize, "Today", () {
                  setNewDate(DateTime.now(), optionSelected.today);
                }, _selectedOption == optionSelected.today),
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
                if (selectDate == tday) {
                  setNewDate(DateTime.now(), optionSelected.today);
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
                            Navigator.pop(context, null);
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
                            Navigator.pop(context, _selectedDateString);
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

  void setNewDate(DateTime date, optionSelected selection) {
    setState(() {
      _selectedDate = date;
      _selectedDateString = formatDate(_selectedDate, [d, ' ', M, ' ', yyyy]);
      if (_selectedDateString == "1 Jan 0000") {
        _selectedDateString = "No date";
      }
      _selectedOption = selection;
    });
  }

  void initialDateSetter() {
    DateTime selectDate = DateFormat("dd MMM yyyy").parse(widget.initialDate!);
    String tday = (formatDate(DateTime.now(), [d, ' ', M, ' ', yyyy]));
    if (widget.initialDate == tday) {
      setNewDate(DateTime.now(), optionSelected.today);
    } else {
      setNewDate(selectDate, optionSelected.none);
    }
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
