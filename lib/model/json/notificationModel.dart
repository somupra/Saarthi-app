class CustomNotification{
  String notification;

  CustomNotification._(
      {this.notification,});

  factory CustomNotification.fromJson(Map<String, dynamic> json) {
    return new CustomNotification._(
      notification :json['notification'],
    );
  }
}
