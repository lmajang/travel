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
    Size scrSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: _StartData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 当Future还未完成时，显示加载中的UI
            return Center(
              child:CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            // 当Future发生错误时，显示错误提示的UI
            print('Error: ${snapshot.error}');

          }
          print('22222222222222222222');
          print(snapshot);
          for(int i =0 ;i<snapshot.data.length;i++) {
            PictruesEntity pictrueList= PictruesEntity.fromJson(snapshot.data[1]['main'][2]);
            addNonEmptyValueToList(showPictureList,pictrueList.pictrues);
          }
          print(showPictureList.length);
          print('222222222222222222222');

         return MaterialApp(
          home: Scaffold(
              appBar: EasySearchBar(
                  title: const Text(''),
                  onSearch: (value) => setState(() => searchValue = value),
                  // actions: [
                  //   IconButton(icon: const Icon(Icons.person), onPressed: () {})
                  // ],
                  asyncSuggestions: (value) async {

                    response = await dio.post(appConfig.ipconfig+'changeSearch',data: await createSearchChangeFormData(value));
                    List<String> suggestionsdata =[];
                    for(int i=0;i<response.data.length;i++) suggestionsdata.add(response.data[i]);
                    _suggestions = suggestionsdata;

                    return await _fetchSuggestions(value);
                  },

                  backgroundColor: Colors.white30,
              ),
              body:
                Column(
                  children: [
                    SizedBox(
                      child: Form(
                      key: _formKey,
                      child: Container(
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 0,
                            ),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child:DropdownButtonFormField2<String>(
                                isExpanded: true,

                                decoration: InputDecoration(
                                    icon: Icon(
                                        size:15,
                                        Icons.roller_skating
                                    ),


                                ),
                                hint: const Text(
                                  '距离我的位置',
                                  style: TextStyle(fontSize: 8),
                                ),
                                items: DistanceChoose.map((item)=>DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 7,
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
                              width: 120,
                              height: 40,
                              child: DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                      size:15,
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
                                    fontSize: 7,
                                    fontFamily: 'Microsoft YaHei',
                                  ),
                                ),
                                items: TimeChoose.map((item)=>DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 7,
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
                    ),
                  SizedBox(
                    height: scrSize.height*0.74,
                    child: EasyRefresh(
                      controller: _controller,
                      header: const ClassicHeader(),
                      footer: const ClassicFooter(),
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          _count = 2;
                        });
                        _controller.finishRefresh();
                        _controller.resetFooter();
                      },
                      onLoad: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          _count += 1;
                        });
                        // _controller.finishLoad(
                        //     _count >= ImagesList.length ? IndicatorResult.noMore : IndicatorResult.success);
                      },
                      child: Center(),//CardStyle.BuildCardStyle(ImagesList:showPictureList,itemCount: _count),
                    )
                    ),
                    ],
                  ),
                ),
          );
      }
    );
  }

  void addNonEmptyValueToList(List<List<dynamic>> myList, List<dynamic> data) {
    if (data.isNotEmpty) {
      myList.add(data);
    }
  }
}

