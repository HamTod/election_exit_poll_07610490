import 'package:election_exit_poll_07610490/models/candidate_result.dart';
import 'package:election_exit_poll_07610490/services/api.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var result;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ))
          : Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            )),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/vote_hand.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Center(
                  child: Text(
                    "result",
                    style: TextStyle(color: Colors.white),
                  )),
              for (var x in result)
                Card(
                  color: Colors.white.withOpacity(0.5),
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            "${x.id}",
                            style: TextStyle(color: Colors.white ,fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            '${x} ',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${x.score}"),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<result_item>> _load() async {
    List list = await Api().fetch('exit_poll/result');
    print(list);
    var result_item_list =
    list.map((item) => result_item.fromJson(item)).toList();
    return result_item_list;
  }

  @override
  initState() {
    super.initState();

    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      result = value;
      setState(() {
        _isLoading = false;
      });
    });
  }
}
