
class NonProfitsData {
  NonProfitsData({this.address, this.category, this.cause, this.city,
  this.contactEmail, this.contactFirstName,this.contactNumber,this.ein,this.financials,
  this.founded,this.missionVision,this.orgName,this.orgSize,this.state,this.website,this.zipCode});

  String address;
  String category;
  String cause;
  String city;
  String contactEmail;
  String contactFirstName;
  String contactNumber;
  String ein;
  String financials;
  String founded;
  String missionVision;
  String orgName;
  String orgSize;
  String state;
  String website;
  String zipCode;

  factory NonProfitsData.fromMap(Map data){
    data = data ?? {};
    return NonProfitsData(
      address: data["Address"] ?? "",
      category: data["Category"] ?? "",
      cause: data["Cause"] ?? "",
      city: data["City"] ?? "",
      contactEmail: data["Contact Email"] ?? "",
      contactFirstName: data["Contact First Name"] ?? "",
      contactNumber: data["Contact Number"] ?? "",
      ein: data["EIN"] ?? "",
      financials: data["Financials"] ?? "",
      founded: data["Founded"] ?? "",
      missionVision: data["Mission/Vision"] ?? "",
      orgName: data["Name"] ?? "" ,
      orgSize: data["Org Size"] ?? "",
      state: data["State"] ?? "",
      website: data["Website"] ?? "",
      zipCode: data["Zip"] ?? "",

    );
  }


}