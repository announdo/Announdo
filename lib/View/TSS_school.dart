
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'global.dart' as gl;


class thornhill_inf extends StatefulWidget {
  const thornhill_inf({ Key? key }) : super(key: key);

  @override
  State<thornhill_inf> createState() => _thornhill_infState();
}

class _thornhill_infState extends State<thornhill_inf> {
  List<bool> _isExpanded = List.generate(10, (_) => false);
  List week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    _tittleMon() {
    const _displayText = '';
    _database.child('Monday/tittle').onValue.listen((event) {
        final tittle = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$tittle';
          gl.monTittle = _displayText;
        });
      });
      return gl.monTittle;
    }
    _descriptionMon() {
    const _displayText = '';
    _database.child('Monday/description').onValue.listen((event) {
        final description = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$description';
          gl.monDes = _displayText;
        });
      });
      return gl.monDes;
    }
    _tittleTue() {
    const _displayText = '';
    _database.child('Tuesday/tittle').onValue.listen((event) {
        final tittle = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$tittle';
          gl.tueTittle = _displayText;
        });
      });
      return gl.tueTittle;
    }
    _descriptionTue() {
    const _displayText = '';
    _database.child('Tuesday/description').onValue.listen((event) {
        final description = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$description';
          gl.tueDes = _displayText;
        });
      });
      return gl.tueDes;
    }
    _tittleWed() {
    const _displayText = '';
    _database.child('Wednesday/tittle').onValue.listen((event) {
        final tittle = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$tittle';
          gl.wenTittle = _displayText;
        });
      });
      return gl.wenTittle;
    }
    _descriptionWed() {
    const _displayText = '';
    _database.child('Wednesday/description').onValue.listen((event) {
        final description = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$description';
          gl.wenDes = _displayText;
        });
      });
      return gl.wenDes;
    }
    _tittleThur() {
    const _displayText = '';
    _database.child('Thursday/tittle').onValue.listen((event) {
        final tittle = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$tittle';
          gl.thurTittle = _displayText;
        });
      });
      return gl.thurTittle;
    }
    _descriptionThur() {
    const _displayText = '';
    _database.child('Thursday/description').onValue.listen((event) {
        final description = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$description';
          gl.thurDes = _displayText;
        });
      });
      return gl.thurDes;
    }
    _tittleFri() {
    const _displayText = '';
    _database.child('Friday/tittle').onValue.listen((event) {
        final tittle = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$tittle';
          gl.friTittle = _displayText;
        });
      });
      return gl.friTittle;
    }
    _descriptionFri() {
    const _displayText = '';
    _database.child('Thursday/description').onValue.listen((event) {
        final description = event.snapshot.value;
        if (!mounted) return;
        setState(() {
          final _displayText = '$description';
          gl.friDes = _displayText;
        });
      });
      return gl.friDes;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Thornhill School"),
      ),
        body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Announcements:',),
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  if (!mounted) return;
                  setState(() {
                    _isExpanded[index] = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(week[0]),
                      );
                    },
                    body: ListTile(
                        title: Text(_tittleMon()),
                        subtitle: Text(_descriptionMon()),
                    ),
                    isExpanded: _isExpanded[0],
                    canTapOnHeader: true,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(week[1]),
                      );
                    },
                    body: ListTile(
                      title: Text(_tittleTue()),
                      subtitle: Text(_descriptionTue()),
                    ),
                    isExpanded: _isExpanded[1],
                    canTapOnHeader: true,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(week[2]),
                      );
                    },
                    body: ListTile(
                      title: Text(_tittleWed()),
                      subtitle: Text(_descriptionWed()),
                    ),
                    isExpanded: _isExpanded[2],
                    canTapOnHeader: true,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(week[3]),
                      );
                    },
                    body: ListTile(
                      title: Text(_tittleThur()),
                      subtitle: Text(_descriptionThur())
                    ),
                    isExpanded: _isExpanded[3],
                    canTapOnHeader: true,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(week[4]),
                      );
                    },
                    body: ListTile(
                      title: Text(_tittleFri()),
                      subtitle: Text(_descriptionFri())
                    ),
                    isExpanded: _isExpanded[4],
                    canTapOnHeader: true,
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.all(10.0),
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Are you a teacher?")),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/teachersAuth', (route) => false);
                },
              ),
            ],
          ),
        ),
      )
      );
  }
}