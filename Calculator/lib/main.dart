import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home:Calculator(),
    );
  }
}

class Calculator extends StatefulWidget{
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calculator>{
  int res=0;
  final TextEditingController _controller=TextEditingController();
  final TextEditingController _controller1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.green
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter first value',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            child: TextField(
              controller: _controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter a Number'),
              ),
            ),
          ),
          SizedBox(height: 40,),
          Text(
            'Enter second value',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter another Number'),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Text('Result :$res',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 40,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    int a=int.parse(_controller.text.trim());
                    int b=int.parse(_controller1.text.trim());
                    add(a,b); },
                  child: Text('+',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),
                ),
                SizedBox(width: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    int a=int.parse(_controller.text.trim());
                    int b=int.parse(_controller1.text.trim());
                    sub(a,b); },
                  child: Text('-',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),
                ),
                SizedBox(width: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    int a=int.parse(_controller.text.trim());
                    int b=int.parse(_controller1.text.trim());
                    mul(a,b); },
                  child: Text('*',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),
                ),
                SizedBox(width: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    int a=int.parse(_controller.text.trim());
                    int b=int.parse(_controller1.text.trim());
                    div(a,b); },
                  child: Text('/',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void add(int a, int b) {
    setState(() {
      res=a+b;
    });
  }
  void sub(int a, int b) {
    setState(() {
      res=b-a;
    });
  }
  void mul(int a, int b) {
    setState(() {
      res=a*b;
    });
  }
  void div(int a, int b) {
    setState(() {
      res=b~/a;
    });
  }
}