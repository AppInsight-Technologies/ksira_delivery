class RouteArgument {
  String id;
  String heroTag;
  dynamic param;
  String orderstatus;
  String payment_type;
  String order_amount;
  String fix_date;
  String fix_time;
  String customer_name;
  String customerNo;
  String totalBottles;
  String address;
  String actual_amount;
  String delivery_charge;
  int index;
  String date;
  String otp;
  String fromScreen;

  RouteArgument({
    this.id,
    this.heroTag,
    this.param,
    this.orderstatus,
    this.payment_type,
    this.order_amount,
    this.fix_date,
    this.fix_time,
    this.customer_name,
    this.customerNo,
    this.totalBottles,
    this.address,
    this.actual_amount,
    this.delivery_charge,
    this.index,
    this.date,
    this.fromScreen,
    this.otp,
  });

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
