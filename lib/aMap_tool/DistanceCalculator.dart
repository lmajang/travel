import 'dart:math';

class DistanceCalculator {
  static const double earthRadius = 6371000.0; // 地球半径，单位为米

  // 根据经纬度计算两点之间的球面距离
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // 将经纬度转换为弧度
    double radiansLat1 = radians(lat1);
    double radiansLon1 = radians(lon1);
    double radiansLat2 = radians(lat2);
    double radiansLon2 = radians(lon2);

    // 计算经纬度差值
    double dLat = radiansLat2 - radiansLat1;
    double dLon = radiansLon2 - radiansLon1;

    // 使用Haversine公式计算球面距离
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radiansLat1) * cos(radiansLat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // 计算距离
    double distance = earthRadius * c;

    return distance;
  }

  // 将角度转换为弧度
  static double radians(double degrees) {
    return degrees * (pi / 180.0);
  }
}