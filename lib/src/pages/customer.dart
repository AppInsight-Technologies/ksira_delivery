import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../providers/group_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';
import '../models/route_argument.dart';
import '../../config/app_config.dart' as config;

class Customer extends StatefulWidget {
  final RouteArgument routeArgument;

  Customer({Key key, this.routeArgument}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    final double blockHeight = 50;
    final double spacerHeight = 5;
    final double applyBtnHeight = 50;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        //automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: /*Theme.of(context).hintColor*/ Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Customer',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Provider.of<GroupProvider>(context).isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor))
          : Provider.of<GroupProvider>(context).currentBlock.length > 0
              ? Column(
                  children: [
                    Container(
                        color: Colors.white,
                        height: blockHeight,
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: BlockPage()),
                    Container(color: Colors.white, height: spacerHeight),
                    SizedBox(
                        height: MediaQuery.of(context).size.height -
                            blockHeight -
                            spacerHeight -
                            applyBtnHeight -
                            AppBar().preferredSize.height -
                            MediaQuery.of(context).viewPadding.top,
                        child: CreateListWidget()),
                    Container(
                        height: applyBtnHeight,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom().copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).accentColor)),
                            onPressed: () async {
                              String customerIdList = '';
                              Provider.of<GroupProvider>(context, listen: false)
                                  .currentBlock
                                  .forEach((element) {
                                customerIdList += element.id + ',';
                              });
                              // print('++++++++++++++++++++customerIdList+++++++++++++++++++++++++++');
                              // print(Provider.of<GroupProvider>(context, listen: false).isActiveBlockIndex+1);
                              // print(customerIdList.substring(0, customerIdList.length-1 ));
                              Provider.of<GroupProvider>(context, listen: false)
                                  .sortCustomerIds(
                                      (Provider.of<GroupProvider>(context,
                                                      listen: false)
                                                  .isActiveBlockIndex +
                                              1)
                                          .toString(),
                                      customerIdList.substring(
                                          0, customerIdList.length - 1));
                            },
                            child: Text('Apply')))
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 80.0, right: 80.0, top: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        child: /*new Image.asset('assets/img/nointernet.png')*/ SvgPicture
                            .asset(
                          "assets/img/no order.svg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "NO CUSTOMERS FOUND",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
    );
  }
}

class CreateListWidget extends StatefulWidget {
  const CreateListWidget({Key key, this.testList}) : super(key: key);
  final List<Map<String, String>> testList;

  @override
  State<CreateListWidget> createState() => _CreateListWidgetState();
}

class _CreateListWidgetState extends State<CreateListWidget> {
  @override
  Widget build(BuildContext context) {
    final BlockList = Provider.of<GroupProvider>(context).currentBlock;
    return BlockList == null
        ? Container()
        : ReorderableListView.builder(
            proxyDecorator: (widget, index, Animation) {
              return CreateTileListCard(
                  isProxy: true,
                  child: CustomerTile(
                    name: BlockList[index].username,
                    address: BlockList[index].address,
                    index: index,
                  ));
            },
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              return CreateTileListCard(
                  key: ValueKey(index),
                  child: CustomerTile(
                    name: BlockList[index].username,
                    address: BlockList[index].address,
                    index: index,
                  ));
            },
            itemCount: BlockList.length,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Customers item = BlockList.removeAt(oldIndex);
                BlockList.insert(newIndex, item);
              });
            });
  }
}

class CreateTileListCard extends StatelessWidget {
  const CreateTileListCard(
      {Key key, this.child, this.index, this.isProxy = false})
      : super(key: key);
  final int index;
  final Widget child;
  final bool isProxy;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.all(isProxy ? 0 : 8),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        key: ValueKey(index),
        child: child);
  }
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({Key key, this.name, this.address, this.index})
      : super(key: key);
  final String name;
  final String address;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
            horizontalTitleGap: 20,
            //contentPadding :EdgeInsets.all(16),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  // radius: 70.0,
                  foregroundColor: Colors.red,
                  backgroundColor: config.Colors().blockSelectionColor,
                  child: Text(
                    index < 9
                        ? '0' + (index + 1).toString()
                        : (index + 1).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).accentColor),
                  ),
                  // child: Image.asset("assets/img/profile.png",
                  //   color: Colors.white ,
                  //   width: 100,
                  //   height: 100,),
                ),
              ],
            ),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(address, style: TextStyle(fontSize: 12))
                ]),
            trailing: SizedBox(
              width: 50,
              child: Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.up_down_arrow,
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      color: Theme.of(context).accentColor),
                ],
              ),
            )),
      ],
    );
  }
}

class BlockPage extends StatefulWidget {
  const BlockPage({Key key}) : super(key: key);

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  @override
  Widget build(BuildContext context) {
    List<String> blocks = [];
    blocks = Provider.of<GroupProvider>(context).blocks;
    return blocks == []
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Provider.of<GroupProvider>(context, listen: false)
                        .setActiveBlock(index);
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Provider.of<GroupProvider>(context)
                                      .isActiveBlockIndex ==
                                  index
                              ? config.Colors().blockSelectionColor
                              : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        blocks[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ))));
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 20);
            },
            itemCount: blocks.length);
  }
}
