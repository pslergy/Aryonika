// lib/services/location_service.dart


import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  // Запрашивает разрешение и возвращает текущую геолокацию
  Future<LocationData?> requestLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 1. Проверяем, включен ли GPS на устройстве
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null; // Пользователь отказался включить GPS
      }
    }

    // 2. Проверяем, дано ли разрешение приложению
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null; // Пользователь не дал разрешение
      }
    }

    // 3. Если все хорошо, получаем геолокацию
    return await _location.getLocation();
  }
}