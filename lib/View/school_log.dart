
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginApp12 extends StatefulWidget {
  const loginApp12({ Key? key }) : super(key: key);

  @override
  State<loginApp12> createState() => _loginApp12State();
}

class _loginApp12State extends State<loginApp12> {
  String dropdownvalue = 'School';
  String stats = 'None'; 
  
  // List of items in our dropdown menu
  var items = [    
    'Thornhill Secondary School',
    'Your school is not available yet',
    'School',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose your school:',),
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),    
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                if (dropdownvalue == 'Thornhill Secondary School'){
                  print("YES");
                  Navigator.of(context).pushReplacementNamed('/TSS_school');
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}