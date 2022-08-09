class DataTimeUtils {
  static _isoStringToDateTime(String iso){
    return DateTime.parse(iso);
  }

  static _dateTimeToIsoString(DateTime date){
    return date.toIso8601String();
  }
}