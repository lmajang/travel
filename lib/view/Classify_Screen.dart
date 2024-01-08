import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class ClassifyScreen extends StatefulWidget {
  const ClassifyScreen({super.key});

  @override
  State<ClassifyScreen> createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends State<ClassifyScreen> {
  List<String> suggestionList = ['风景', '风格', '风车', '风衣', '风'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  //controller.openView();
                },
                onChanged: (_) {
                  //controller.openView();
                },

                leading: const Icon(Icons.search),
                // trailing: <Widget>[
                //   Tooltip(
                //     message: 'Change brightness mode',
                //     child: IconButton(
                //       isSelected: isDark,
                //       onPressed: () {
                //         setState(() {
                //           isDark = !isDark;
                //         });
                //       },
                //       icon: const Icon(Icons.wb_sunny_outlined),
                //       selectedIcon: const Icon(Icons.brightness_2_outlined),
                //     ),
                //   )
                // ],
              );
            },
            suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
              },
            );
          });
        }
        ),
      ),
    );
  }
}
