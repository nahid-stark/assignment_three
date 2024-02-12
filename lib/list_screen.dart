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
  String _errorMessage = "Something Wrong";

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
        replacement: Center(
          child: Wrap(
            children: [
              Text(
                _errorMessage,
                style: const TextStyle(
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
      setState(() {});
    } else if(response.statusCode == 400){
      _errorMessage = "Bad Request: The server cannot process the request due to a client error, such as malformed syntax or invalid parameters.";
      _isEverythingOkay = false;
      setState(() {});
    } else if(response.statusCode == 401){
      _errorMessage = "Unauthorized: The request requires user authentication. The client must provide credentials to access the resource.";
      _isEverythingOkay = false;
      setState(() {});
    } else if(response.statusCode == 403){
      _errorMessage = "Forbidden: The server understood the request, but refuses to authorize it. No authentication will help.";
      _isEverythingOkay = false;
      setState(() {});
    } else if(response.statusCode == 404){
      _errorMessage = "Not Found: The server cannot find the requested resource. This status code is commonly used when a resource does not exist or when a route is not found.";
      _isEverythingOkay = false;
      setState(() {});
    } else if(response.statusCode == 500){
      _errorMessage = "Internal Server Error: The server encountered an unexpected condition that prevented it from fulfilling the request.";
      _isEverythingOkay = false;
      setState(() {});
    } else {
      _errorMessage = "Something Wrong";
      _isEverythingOkay = false;
      setState(() {});
    }
  }
}
