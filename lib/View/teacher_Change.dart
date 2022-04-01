import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'global.dart' as gl;
import 'package:flutter/material.dart';

class ChangeDatabase extends StatefulWidget {
  const ChangeDatabase({ Key? key }) : super(key: key);

  @override
  State<ChangeDatabase> createState() => _ChangeDatabaseState();
}

class _ChangeDatabaseState extends State<ChangeDatabase> {
  final _database = FirebaseDatabase.instance.ref();
  late final TextEditingController _tittle;
  late final TextEditingController _des;
  String dropdownvalue = 'Monday';
  String stats = 'None'; 
    var week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  @override
  void initState() {
    super.initState();
    _tittle = TextEditingController();
    _des = TextEditingController();
  }
  @override
  void dispose() {
    _tittle.dispose();
    _des.dispose();
    super.dispose();
  }
  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    _tittleMon() {
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Change Data"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Choose the day:',),
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),    
                  items: week.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) { 
                    if (!mounted) return;
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                if (dropdownvalue == 'Monday')
                  Column(
                    children: [
                      const Text('Tittle: '),
                      Text(_tittleMon()),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _tittle,
                        enableSuggestions: true,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Enter new tittle',
                        ),
                      ),
                      const Text('Description: '),
                      Text(_descriptionMon()),
                      TextField(
                        controller: _des,
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Edit the description',
                        ),
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_tittle.text.isNotEmpty) {
                            _database.child('Monday/tittle').set(_tittle.text);
                            _tittle.clear();
                          } else if (_des.text.isNotEmpty) {
                            _database.child('Monday/description').set(_des.text);
                            _des.clear();
                          } else {
                            print('Nothing to save');
                          }
                        },
                      ),
                    ],
                  ),
                if (dropdownvalue == 'Tuesday')
                  Column(
                    children: [
                      const Text('Tittle: '),
                      Text(_tittleTue()),
                      TextField(
                        controller: _tittle,
                        enableSuggestions: true,
                        autocorrect: true,
                        keyboardType: TextInputType.multiline,
                        maxLines:null,
                        decoration: const InputDecoration(
                          hintText: 'Enter new tittle',
                        ),
                      ),
                      const Text('Description: '),
                      Text(_descriptionTue()),
                      TextField(
                        controller: _des,
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Edit the description',
                        ),
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_tittle.text.isNotEmpty) {
                            _database.child('Tuesday/tittle').set(_tittle.text);
                            _tittle.clear();
                          } else if (_des.text.isNotEmpty) {
                            _database.child('Tuesday/description').set(_des.text);
                            _des.clear();
                          } else {
                            print('Nothing to save');
                          }
                        },
                      ),
                    ],
                  ),
                  if (dropdownvalue == 'Wednesday')
                  Column(
                    children: [
                      const Text('Tittle: '),
                      Text(_tittleWed()),
                      TextField(
                        controller: _tittle,
                        enableSuggestions: true,
                        autocorrect: true,
                        keyboardType: TextInputType.multiline,
                        maxLines:null,
                        decoration: const InputDecoration(
                          hintText: 'Enter new tittle',
                        ),
                      ),
                      const Text('Description: '),
                      Text(_descriptionWed()),
                      TextField(
                        controller: _des,
                        enableSuggestions: true,
                        autocorrect: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Edit the description',
                        ),
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_tittle.text.isNotEmpty) {
                            _database.child('Wednesday/tittle').set(_tittle.text);
                            _tittle.clear();
                          } else if (_des.text.isNotEmpty) {
                            _database.child('Wednesday/description').set(_des.text);
                            _des.clear();
                          } else {
                            print('Nothing to save');
                          }
                        },
                      ),
                    ],
                  ),
                if (dropdownvalue == 'Thursday')
                  Column(
                    children: [
                      const Text('Tittle: '),
                      Text(_tittleThur()),
                      TextField(
                        controller: _tittle,
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Enter new tittle',
                        ),
                      ),
                      const Text('Description: '),
                      Text(_descriptionThur()),
                      TextField(
                        controller: _des,
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Edit the description',
                        ),
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_tittle.text.isNotEmpty) {
                            _database.child('Thursday/tittle').set(_tittle.text);
                            _tittle.clear();
                          } else if (_des.text.isNotEmpty) {
                            _database.child('Thursday/description').set(_des.text);
                            _des.clear();
                          } else {
                            print('Nothing to save');
                          }
                        },
                      ),
                    ],
                  ),
                if (dropdownvalue == 'Friday')
                  Column(
                    children: [
                      const Text('Tittle: '),
                      Text(_tittleFri()),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _tittle,
                        enableSuggestions: true,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Enter new tittle',
                        ),
                      ),
                      const Text('Description: '),
                      Text(_descriptionFri()),
                      TextField(
                        controller: _des,
                        keyboardType: TextInputType.multiline,
                        enableSuggestions: true,
                        autocorrect: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Edit the description',
                        ),
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_tittle.text.isNotEmpty) {
                            _database.child('Friday/tittle').set(_tittle.text);
                            _tittle.clear();
                          } else if (_des.text.isNotEmpty) {
                            _database.child('Friday/description').set(_des.text);
                            _des.clear();
                          } else {
                            print('Nothing to save');
                          }
                        },
                      ),
                    ],
                  ),
                TextButton(
                  child: const Text('logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/teachersAuth', (route) => false);
                  },
                ),
              ],
            ),
        ),
      ),
    );
  }
}