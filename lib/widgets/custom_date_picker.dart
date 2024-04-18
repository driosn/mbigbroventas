import 'package:flutter/material.dart';

class CustomDatePicker {
  static show({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showModalBottomSheet<DateTime?>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      builder: (context) {
        return _CustomDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
      },
    );
  }
}

class _CustomDatePicker extends StatefulWidget {
  const _CustomDatePicker({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    super.key,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<_CustomDatePicker> {
  late ValueNotifier<int> monthNotifierIndex;
  late ValueNotifier<int> dayNotifierIndex;
  late ValueNotifier<int> yearNotifierIndex;

  late ValueNotifier<List<String>> monthValuesNotifier;
  late ValueNotifier<List<int>> dayValuesNotifier;
  late ValueNotifier<List<int>> yearValuesNotifier;

  final FixedExtentScrollController _monthController =
      FixedExtentScrollController();
  final FixedExtentScrollController _dayController =
      FixedExtentScrollController();
  final FixedExtentScrollController _yearController =
      FixedExtentScrollController();

  @override
  void initState() {
    //
    // Month
    //
    monthValuesNotifier = ValueNotifier<List<String>>([
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic'
    ]);

    //
    // Year
    //
    final yearFirstDate = widget.firstDate.year;
    final yearLastDate = widget.lastDate.year;
    final yearIterations = yearLastDate - yearFirstDate;
    final yearValues =
        List.generate(yearIterations + 1, (index) => index + yearFirstDate);
    yearValuesNotifier = ValueNotifier<List<int>>(yearValues);

    // ============================================================
    monthNotifierIndex = ValueNotifier<int>(widget.initialDate.month - 1);

    int daysInMonth = DateTimeRange(
      start: DateTime(widget.initialDate.year, widget.initialDate.month),
      end: DateTime(
        widget.initialDate.year,
        widget.initialDate.month + 1,
      ),
    ).duration.inDays;
    print(daysInMonth);

    // =============================================================
    //
    // Day
    //
    final dayValues = List.generate(daysInMonth, (index) => index + 1);
    dayValuesNotifier = ValueNotifier<List<int>>(dayValues);

    super.initState();

    dayNotifierIndex = ValueNotifier<int>(
        dayValues.indexWhere((element) => element == widget.initialDate.day));

    yearNotifierIndex = ValueNotifier<int>(
        yearValues.indexWhere((year) => year == widget.initialDate.year));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _monthController.animateToItem(
        monthNotifierIndex.value,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
      _dayController.animateToItem(
        dayNotifierIndex.value,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
      _yearController.animateToItem(
        yearNotifierIndex.value,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(
        horizontal: 34,
      ),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 44,
          ),
          Text(
            'Ingresa tu\nFecha de Nacimiento',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(child: _monthSelector()),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: _daySelector()),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: _yearSelector()),
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                DateTime(
                  yearNotifierIndex.value + widget.firstDate.year,
                  monthNotifierIndex.value + 1,
                  dayNotifierIndex.value + 1,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Continuar",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, null);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Color(0xff979797),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _monthSelector() {
    return ValueListenableBuilder<List<String>>(
        valueListenable: monthValuesNotifier,
        builder: (context, months, child) {
          return ValueListenableBuilder<int>(
            valueListenable: monthNotifierIndex,
            builder: (context, monthIndex, child) {
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1.5),
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: _monthController,
                  childDelegate: ListWheelChildLoopingListDelegate(
                      children: months.map((month) {
                    return Text(
                      month,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: months[monthIndex] == month ? 16 : 14,
                          color: months[monthIndex] == month
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3)),
                    );
                  }).toList()),
                  onSelectedItemChanged: (index) {
                    final currentYear =
                        yearValuesNotifier.value[yearNotifierIndex.value];
                    final currentMonth = index + 1;

                    int daysInMonth = DateTimeRange(
                      start: DateTime(currentYear, currentMonth),
                      end: DateTime(
                        currentYear,
                        currentMonth + 1,
                      ),
                    ).duration.inDays;

                    print(daysInMonth);

                    if ((daysInMonth == 31 &&
                            (dayNotifierIndex.value + 1) == 30) ||
                        (daysInMonth == 30 &&
                            (dayNotifierIndex.value + 1) == 31) ||
                        (daysInMonth == 28 &&
                            (dayNotifierIndex.value + 1) > 28) ||
                        daysInMonth == 29 &&
                            (dayNotifierIndex.value + 1) == 29) {
                      dayNotifierIndex.value = 0;
                      _dayController.animateToItem(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    }

                    final dayValues =
                        List.generate(daysInMonth, (index) => index + 1);
                    dayValuesNotifier.value = dayValues;

                    monthNotifierIndex.value = index;
                  },
                  magnification: 3.0,
                  itemExtent: 28,
                  diameterRatio: 10,
                  // onSelectedItemChanged: (value) {
                  // print('value: $value');
                  // },
                ),
              );
            },
          );
        });
  }

  Widget _daySelector() {
    return ValueListenableBuilder<List<int>>(
      valueListenable: dayValuesNotifier,
      builder: (context, days, child) {
        return ValueListenableBuilder<int>(
          valueListenable: dayNotifierIndex,
          builder: (context, dayIndex, child) {
            return Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 1.5),
              ),
              child: ListWheelScrollView.useDelegate(
                controller: _dayController,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: days.map((day) {
                  return Text(
                    '$day',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: days[dayIndex] == day ? 16 : 14,
                        color: days[dayIndex] == day
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.3)),
                  );
                }).toList()),
                onSelectedItemChanged: (index) {
                  dayNotifierIndex.value = index;
                },
                magnification: 3.0,
                itemExtent: 28,
                diameterRatio: 10,
              ),
            );
          },
        );
      },
    );
  }

  Widget _yearSelector() {
    return ValueListenableBuilder<List<int>>(
      valueListenable: yearValuesNotifier,
      builder: (context, years, child) {
        return ValueListenableBuilder<int>(
          valueListenable: yearNotifierIndex,
          builder: (context, yearIndex, child) {
            return Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 1.5),
              ),
              child: ListWheelScrollView.useDelegate(
                controller: _yearController,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: years.map((year) {
                  return Text(
                    '$year',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: years[yearIndex] == year ? 16 : 14,
                        color: years[yearIndex] == year
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.3)),
                  );
                }).toList()),
                onSelectedItemChanged: (index) {
                  final currentMonth = monthNotifierIndex.value + 1;
                  final currentYear = index + widget.firstDate.year;

                  int daysInMonth = DateTimeRange(
                    start: DateTime(currentYear, currentMonth),
                    end: DateTime(
                      currentYear,
                      currentMonth + 1,
                    ),
                  ).duration.inDays;

                  print(daysInMonth);

                  if ((daysInMonth == 31 &&
                          (dayNotifierIndex.value + 1) == 30) ||
                      (daysInMonth == 30 &&
                          (dayNotifierIndex.value + 1) == 31) ||
                      (daysInMonth == 28 &&
                          (dayNotifierIndex.value + 1) > 28) ||
                      daysInMonth == 29 && (dayNotifierIndex.value + 1) == 29) {
                    dayNotifierIndex.value = 0;
                    _dayController.animateToItem(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  }

                  final dayValues =
                      List.generate(daysInMonth, (index) => index + 1);
                  dayValuesNotifier.value = dayValues;

                  yearNotifierIndex.value = index;
                },
                magnification: 3.0,
                itemExtent: 28,
                diameterRatio: 10,
              ),
            );
          },
        );
      },
    );
  }
}
