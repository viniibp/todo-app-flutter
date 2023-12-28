/* Descrição
      ontem: -1
      hoje:   0
      amanhã: 1
  */
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();

  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}
