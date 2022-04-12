class MeltingDataModel {
  int? id;
  String? weight;
  String? touch;
  String? output;
  // int? add;
  String? date;
  String? pal;
  String? finalweight;

  MeltingDataModel(this.weight, this.touch, this.output, this.date, this.pal,
      this.finalweight);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['weight'] = weight;
    map['touch'] = touch;
    map['output'] = output;
    // map['add'] = add;
    map['date'] = date;
    map['pal'] = pal;
    map['finalweight'] = finalweight;

    return map;
  }

  MeltingDataModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.weight = map['weight'];
    this.touch = map['touch'];
    this.output = map['output'];
    //  this.add = map['add'];
    this.date = map['date'];
    this.pal = map['pal'];
    this.finalweight = map['finalweight'];
  }
}
