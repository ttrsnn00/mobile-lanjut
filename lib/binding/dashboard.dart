class DashboardModel {
  final int totalUser;
  final int totalRuangan;
  final int totalBooking;
  final int ruanganTersedia;

  DashboardModel({
    required this.totalUser,
    required this.totalRuangan,
    required this.totalBooking,
    required this.ruanganTersedia,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalUser: _toInt(json['totalUser'] ?? json['total_user']),
      totalRuangan: _toInt(json['totalRuangan'] ?? json['total_ruangan']),
      totalBooking: _toInt(json['totalBooking'] ?? json['total_booking']),
      ruanganTersedia: _toInt(
        json['ruanganTersedia'] ?? json['ruangan_tersedia'],
      ),
    );
  }

  static int _toInt(dynamic value) =>
      value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? 0;
}
