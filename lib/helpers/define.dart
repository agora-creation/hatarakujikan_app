DateTime kMonthFirstDate = DateTime(DateTime.now().year - 1);
DateTime kMonthLastDate = DateTime(DateTime.now().year + 1);
DateTime kDayFirstDate = DateTime.now().subtract(Duration(days: 365));
DateTime kDayLastDate = DateTime.now().add(Duration(days: 365));
