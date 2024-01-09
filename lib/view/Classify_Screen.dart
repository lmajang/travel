import 'package:dio/dio.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

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
    return MaterialApp(
        home: Scaffold(
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
            body:
              Column(
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
                          width: 120,
                          height: 40,
                          child:DropdownButtonFormField2<String>(
                            isExpanded: true,

                            decoration: InputDecoration(
                                icon: Icon(
                                    size:15,
                                    Icons.roller_skating
                                )

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
                  )


                  ],
                ),
              ),
    );
  }
}

