class Complaint {
  String location;
  bool isVerified;
  bool isSettled;
  String complaintId;
  String filer;
  String dateFiled;
  String refImage;
  String description;
  String complaintStatus;

  Complaint._(
      {this.location,
      this.isVerified,
      this.isSettled,
      this.complaintId,
      this.filer,
      this.dateFiled,
      this.refImage,
      this.description,
      this.complaintStatus});

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return new Complaint._(
      location :json['location'],
      isVerified : json['is_verified'],
      isSettled : json['is_settled'],
      complaintId : json['complaint_id'],
      filer : json['filer'],
      dateFiled : json['date_filed'],
      refImage : json['ref_image'],
      description : json['description'],
      complaintStatus : json['complaint_status'],
    );
  }
}
