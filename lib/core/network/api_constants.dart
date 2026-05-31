abstract class ApiConstants {
  // بريفات كونستركتور علشان تمنع الـ Instantiation تماماً (named constructor) ==> سميته : _
  const ApiConstants._();

  static const String baseUrl = 'https://rickandmortyapi.com/api';
  static const String character = '/character';
}
