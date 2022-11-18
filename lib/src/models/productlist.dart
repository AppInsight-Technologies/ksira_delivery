
import '../../constants/Iconstants.dart';

class productList {
  int status;
  List<Data> data;

  productList({this.status, this.data});

  productList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Datas> datas;

  Data({this.datas});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['datas'] != null) {
      datas = <Datas>[];
      json['datas'].forEach((v) {
        datas.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  String type;
  String id;
  String oderItemIds;
  String item;
  String tstatus;
  String orderId;
  String priceVariavtion;
  String image;
  String quantity;
  String unit;

  Datas(
      {this.type,
        this.id,
        this.oderItemIds,
        this.item,
        this.tstatus,
        this.orderId,
        this.priceVariavtion,
        this.image,
        this.quantity,
        this.unit});

  Datas.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    oderItemIds = json['oder_item_ids'];
    item = json['item'];
    tstatus = json['tstatus'];
    orderId = json['order_id'];
    priceVariavtion = json['priceVariavtion'];
    image = IConstants.IMG_PATH+json['image'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['oder_item_ids'] = this.oderItemIds;
    data['item'] = this.item;
    data['tstatus'] = this.tstatus;
    data['order_id'] = this.orderId;
    data['priceVariavtion'] = this.priceVariavtion;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}