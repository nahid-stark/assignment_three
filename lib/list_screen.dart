import 'dart:convert';
import 'package:assignment_three/details_screen.dart';
import 'package:assignment_three/pojo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Pojo> dataList = [];
  bool _getDataListInProgress = false;
  bool _isEverythingOkay = true;

  @override
  void initState() {
    getDataListFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo Gallery App",
        ),
      ),
      body: Visibility(
        visible: _isEverythingOkay,
        replacement: const Center(
          child: Wrap(
            children: [
              Text(
                "Something Wrong! Please try again",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        child: Visibility(
          visible: _getDataListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(index: index, data: dataList[index]),
                      ),
                    );
                  },
                  leading: Image.network(
                    dataList[index].url ?? "",
                  ),
                  title: Wrap(
                    children: [
                      Text(
                        dataList[index].title ?? "",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getDataListFromAPI() async {
    _getDataListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      for (Map<String, dynamic> item in decodedResponse) {
        Pojo data = Pojo.fromJson(item);
        dataList.add(data);
      }
      _getDataListInProgress = false;
    } else {
      _isEverythingOkay = false;
      setState(() {});
    }
    if (_isEverythingOkay) {
      setState(() {});
    }
  }
}
