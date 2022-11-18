import 'package:flutter/material.dart';

class BlockOrder{
  String groupName = '';
  String deliveryPartnerId = '';
  String customerId  = '';
  List customersOrders = [];

  BlockOrder (this.groupName, this.deliveryPartnerId,  this.customerId, this.customersOrders ){
}
}
