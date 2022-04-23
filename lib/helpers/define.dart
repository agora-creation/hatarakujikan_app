const List<String> workStates = ['通常勤務', '直行/直帰', 'テレワーク'];
const List<String> workShiftStates = ['勤務予定', '欠勤', '特別休暇', '有給休暇', '代休'];

DateTime kMonthFirstDate = DateTime(DateTime.now().year - 1);
DateTime kMonthLastDate = DateTime(DateTime.now().year + 1);
DateTime kDayFirstDate = DateTime.now().subtract(Duration(days: 365));
DateTime kDayLastDate = DateTime.now().add(Duration(days: 365));
