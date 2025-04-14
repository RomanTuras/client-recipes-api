// const String recipesAPIBaseURL = 'http://0.0.0.0/api/v1';
// const String recipesAPIBaseAndroidURL = 'http://10.0.2.2/api/v1';
import 'dart:io';

const bool kDebugMode = false;
const String token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZDk1MDI3M2ZmMzY5NWJkY2UyMTlmYTZiNDc0MWJkZSIsIm5iZiI6MTczMzY1NDQ4OS4wNzksInN1YiI6IjY3NTU3N2Q5MjM3ODQ5NzY3NTc1NjE4MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.z1zuqOrCEvxQI7cq39NIfe4PolLReH8hnc95zaxg49M';
const accept = 'application/json';
const String language = 'en-US';
const String adult = 'false';

const pathToImg = "https://image.tmdb.org/t/p/w500/";

String get recipesAPIBaseURL {
  if (kDebugMode) {
    if (Platform.isAndroid) {
      return "http://10.0.2.2/api/v1"; // Android
    } else if (Platform.isIOS) {
      return "http://0.0.0.0/api/v1"; // iOS
    }
  }
  return "http://192.168.3.182/api/v1"; // Prod
}