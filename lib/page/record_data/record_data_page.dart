import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smartbuilding/page/record_data/data.dart';

class RecordDataPage extends StatefulWidget {
  const RecordDataPage({super.key});

  @override
  State<RecordDataPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RecordDataPage> {
  // hive reference
  final _myBox = Hive.box('myBox');
  // database
  List datalist = [];
  final database = FirebaseDatabase.instance; //firebase
  final deviceNameController = TextEditingController();
  final recordTimeController = TextEditingController();

  void addData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Record New Data',
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.grey[800],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Device Name',
              ),
              controller: deviceNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Time (Minute)',
              ),
              controller: recordTimeController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            elevation: 0,
            color: Colors.grey[700],
            onPressed: () {
              saveData();
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            elevation: 0,
            color: Colors.grey[700],
            onPressed: () {
              cencel();
            },
            child: const Text(
              'Cencel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SAVE DATA
  void saveData() {
    // datalist.clear();
    String namaPerangkat = deviceNameController.text.trim();
    String waktuRecord = recordTimeController.text.trim();

    if (namaPerangkat.isNotEmpty && waktuRecord.isNotEmpty) {
      var waktuInt = int.parse(waktuRecord);
      final dbref = database.ref('buildings/recordData/deviceName/');
      dbref.set(namaPerangkat);
      final timeRef = database.ref('buildings/recordData/timeRecord/');
      timeRef.set(waktuInt);
      final trigref = database.ref('buildings/recordData/trig/');
      trigref.set(1);
    }

    Navigator.pop(context);
    deviceNameController.clear();
    recordTimeController.clear();
  }

  // CENCEL
  void cencel() {
    Navigator.pop(context);
    deviceNameController.clear();
    recordTimeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // get push data
    final dataPushRef = database.ref('buildings/recordData/data');

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addData();
        },
        backgroundColor: Colors.grey[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[700],
        title: Text(
          'Record Data',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: FirebaseAnimatedList(
        query: dataPushRef,
        itemBuilder: (context, snapshot, animation, index) {
          // String data = jsonEncode(snapshot.key);
          // List<dynamic> child = [];
          // child = data.toList();
          // print(child);
          Map delete = snapshot.value as Map;
          delete['key'] = snapshot.key;
          // print(delete['key']);
          String data = snapshot.key.toString();
          List<dynamic> list = [];
          list.add(data);
          // print(list);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(8),
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    onPressed: (contex) {
                      dataPushRef.child(delete['key']).remove();
                    },
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  title: Text(
                    data.toString(),
                    style: GoogleFonts.bebasNeue(fontSize: 19),
                  ),
                  subtitle: Text(
                    "Data length, ${snapshot.children.length}",
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                  onTap: () {
                    // print(delete['key']);
                    _myBox.put(1, delete['key']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DataSreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: list.length,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       color: Colors.amber,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(data.toString()),
          //           Icon(Icons.delete),
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
