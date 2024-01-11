import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:travel/common/Config.dart';


import '../const.dart';
import '../entity/pictrues_entity.dart';
import '../init_page/CardStyle.dart';
import 'package:timelines/timelines.dart';
import '../init_page/init_item.dart';


class ClassifyScreen extends StatefulWidget {
  const ClassifyScreen({super.key});

  @override
  State<ClassifyScreen> createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends State<ClassifyScreen> {
  Dio dio =Dio();
  late Response response;
  String searchValue = '';
  List<String> _suggestions = [];
  Future<dynamic>? _StartData;
  List<List<dynamic>> showPictureList = [];


  late int _count ;
  late EasyRefreshController _controller;

  Future<FormData> createFormData() async {
    return FormData.fromMap({
      'userid':'1' ,
      'date': DateTime.now().toIso8601String(),
      //'file': await MultipartFile.fromFile(''),
    });
  }

  Future<dynamic> StartfetchData() async {
    Response response = await dio.post(appConfig.ipconfig+'main',data: await createFormData());
    // Handle the response data as needed
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    _StartData = StartfetchData();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<FormData> createSearchChangeFormData(String value) async {
    return FormData.fromMap({
      'search':value,
      //'file': await MultipartFile.fromFile(''),
    });
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }
  final _formKey = GlobalKey<FormState>();
  String? selectedDistanceValue;
  String? selectedTimeValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text(''),
        onSearch: (value) => setState(() => searchValue = value),
        // actions: [
        //   IconButton(icon: const Icon(Icons.person), onPressed: () {})
        // ],
        asyncSuggestions: (value) async {
          response = await dio.post('',data: value);
          return await _fetchSuggestions(value);
        },

        backgroundColor: Colors.white30,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 0,
                      ),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child:DropdownButtonFormField2<String>(
                          isExpanded: true,

                          decoration: InputDecoration(
                              icon: Icon(
                                  size:30,
                                  Icons.roller_skating
                              )

                          ),
                          hint: const Text(
                            '距离我的位置',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                          ),
                          items: DistanceChoose.map((item)=>DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                          )
                          ).toList(),
                          onChanged: (value) {
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedDistanceValue = value.toString();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 10,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30,),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            icon: Icon(
                                size:30,
                                Icons.access_time_outlined
                            ),
                            // contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(15),
                            // ),

                          ),

                          hint: const Text(
                            '距离当天...',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Microsoft YaHei',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          items: TimeChoose.map((item)=>DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                          )
                          ).toList(),
                          onChanged: (value) {
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedTimeValue = value.toString();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 7,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(), // 占位元素
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(selectedDistanceValue);
                            print(selectedTimeValue);
                          }
                        },
                        child: const Text('选择'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  child:_buildTrackDiscover()
              )
            ],
          ),
        ),
      ),
    );
  }
}

const kTileHeight = 50.0;

Widget _buildTrackDiscover(){
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 15,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
      final data = _data(index + 1);
      return Container(
          width: 360.0,
          child: Card(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _OrderTitle(
                    orderInfo: data,
                  ),
                ),
                Divider(height: 1.0),
                _DeliveryProcesses(processes: data.deliveryProcesses),
                Divider(height: 1.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _OnTimeBar(driver: data.driverInfo),
                ),
              ],
            ),
          ),
        );
    },
  );
}


class PackageDeliveryTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TitleAppBar('Package Delivery Tracking'),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final data = _data(index + 1);
          return Center(
            child: Container(
              width: 360.0,
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _OrderTitle(
                        orderInfo: data,
                      ),
                    ),
                    Divider(height: 1.0),
                    _DeliveryProcesses(processes: data.deliveryProcesses),
                    Divider(height: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _OnTimeBar(driver: data.driverInfo),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void addNonEmptyValueToList(List<List<dynamic>> myList, List<dynamic> data) {
    if (data.isNotEmpty) {
      myList.add(data);
    }
  }
}

