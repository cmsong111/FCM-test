import 'package:flutter/material.dart';
import 'package:receiver/src/data/datasources/firebase_datasource.dart';
import 'package:receiver/src/data/models/location_entity.dart';
import 'package:receiver/src/injector.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  late final FirebaseDataSource _firebaseDataSource;

  @override
  void initState() {
    super.initState();
    _firebaseDataSource = locator<FirebaseDataSource>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("새로운 위치 추가"),
      ),
      body: FutureBuilder(
        future: _firebaseDataSource.getAllLocationList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].uid),
                  onTap: () {
                    Navigator.pop(context, snapshot.data![index].uid);
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
