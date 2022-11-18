import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Iconstants.dart';

class Group {
  String id;
  String deliveryPartnerId;
  String groupName;
  String ids;
  String createdAt;
  List<Customers> customers;

  Group(
      {this.id,
        this.deliveryPartnerId,
        this.groupName,
        this.ids,
        this.createdAt,
        this.customers});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryPartnerId = json['delivery_partner_id'];
    groupName = json['group_name'];
    ids = json['ids'];
    createdAt = json['created_at'];
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_partner_id'] = this.deliveryPartnerId;
    data['group_name'] = this.groupName;
    data['ids'] = this.ids;
    data['created_at'] = this.createdAt;
    if (this.customers != null) {
      data['customers'] = this.customers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  String id;
  String username;
  String address;

  Customers({this.id, this.username, this.address});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['address'] = this.address;
    return data;
  }
}


class GroupProvider extends ChangeNotifier {
  List<Group> group = [];
  List<String> blocks = [];
  List<Customers> currentBlock = [];
  int isActiveBlockIndex = 0;
  bool isLoading = true;

  getByBlock() async {
    String url = IConstants.API_PATH + 'get-del-data-by-block';
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(
          url,
          body: {
            "user_id": prefs.get("id"),
          }
      );
      final responseJson = json.decode(response.body);
      if (responseJson.toString() == "[]") {
        isLoading = false;
        notifyListeners();
      } else {
        List data = [];
        blocks.clear();
        group.clear();
        currentBlock.clear();
        responseJson.asMap().forEach((index, value) =>
            data.add(responseJson[index] as Map<String, dynamic>));
        for (int i = 0; i < data.length; i++) {
          group.add(Group.fromJson(data[i]));
          blocks.add(data[i]['group_name']);
        }
        currentBlock = group[isActiveBlockIndex].customers;
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  setActiveBlock(int i) {
    isActiveBlockIndex = i;
    currentBlock = group[isActiveBlockIndex].customers;
    notifyListeners();
  }

  sortCustomerIds(String id, String sortedId) async {
    String url = IConstants.API_PATH + 'sort-del-customer-ids';
    print('sorted_id..........'+sortedId);
    try {
      final response = await http
          .post(url,
          body: {
            'id': id, 'sorted_ids': sortedId
          });
      print('sorted_id..........'+sortedId);
      final responseJson = json.decode(response.body);
      if (responseJson.toString() == "[]") {} else {
        print('....sortCustomerIds.... response.........');
        print(responseJson.toString());
        Fluttertoast.showToast(msg: 'Success' );
      }
    } catch (e) {
      throw e;
    }
  }
}
