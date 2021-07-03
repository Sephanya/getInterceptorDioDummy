import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage>{


  Dio dio = new Dio();

  Future getData() async {
    final String pathUrl = 'https://jsonplaceholder.typicode.com/posts/1';
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions option, ) {
      var headers = {
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
         };
      option.headers.addAll(headers);
      return option.data;
    }));
    Response response = await dio.get(pathUrl);
    return response.data;

     // dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions option) async{
     //   var headers ={
     //     'Content-type': 'application/json; charset=UTF-8',
     //     'Accept': 'application/json'
     //     // 'Authorization': 'Bearer $token' for private api
     //   };
     //   option.headers.addAll(headers);
     //   return option.data;
     // }));
     // Response response = await dio.get(pathUrl);
     // return response.data;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //  resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.black,
          onPressed: () async{
            print('Posting data...');
            await getData().then((value) {
              print(value);
            });
          },
          child: Text(
            'Post',style: TextStyle(
            color: Colors.white,
          ),
          ),

        ),
      ),

    );
  }
}
