
import 'package:election_exit_poll_07610490/models/candidate.dart';
import 'package:election_exit_poll_07610490/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class poll extends StatefulWidget {
  const poll({Key? key}) : super(key: key);

  @override
  _pollState createState() => _pollState();
}

class _pollState extends State<poll> {
  var items;
  var _isLoading = false;
  var sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ))
          : Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fill,
                  )),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'EXIT POLL',
                                style: GoogleFonts.kanit(fontSize: 25, color: Colors.white70),
                              ),),
                        Center(
                            child: Text(
                          "เลือกตั้ง อบต",
                          style: TextStyle(color: Colors.white ,fontSize: 40),
                        )),
                        Center(
                          child: Text(
                              'รายชื่่อผู้สมัครรับเลือกตั้ง\nนายกองค์การบริหารส่วนตำบลเขาพระ\nอำเภอเมืองนครนายก จังหวัดนครนายก',
                              style:
                              GoogleFonts.fredokaOne(fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                        Column(children: [
                          for (var x in items)
                            InkWell(
                              onTap: () {
                                vote(x.id);
                              },
                              child: Card(
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
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          '${x}',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ]),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/result');
                            },
                            child: Text("ดูผล"))
                      ],
                    ),
                  ),
                ),
                if (sending)
                  Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ))
              ],
            ),
    );
  }

  Future<List> _send(Map<String, dynamic> send) async {
    List list = await Api().submit('exit_poll', send);
    return list;
  }

  Future<List<Candidate>> _load() async {
    List list = await Api().fetch('exit_poll');
    var CandidateList = list.map((item) => Candidate.fromJson(item)).toList();
    return CandidateList;
  }

  Future<void> vote(int num) async {
    sending = true;
    Map<String, dynamic> send = {'candidateNumber': num};
    var RESPONSE = _send(send);
    RESPONSE.then((value) {
      sending = false;
      _showMaterialDialog("SUCCESS", "บันทึกข้อมูลสำเร็จ$value");
    });
  }

  @override
  initState() {
    super.initState();

    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      items = value;
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
