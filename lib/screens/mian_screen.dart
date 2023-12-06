import 'package:anime_adder/db/sql_helper.dart';
import 'package:anime_adder/screens/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  SqlHelper.getAllAnimes(),
        builder: (context, snapshot){
          if(snapshot.data != null && snapshot.data?.isNotEmpty == true){
            final list = snapshot.data?.reversed.toList();
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                final a = list?[index];
                return ListTile(
                  onTap: (){},
                  leading: Text('${index +1}',style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  ),),
                  title: Text(a?.animeName ?? "",style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                  subtitle: Text(a?.animeEpisodes ?? "",style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                );
              },
            );
          } else if(snapshot.data?.isEmpty == true){
            return const Center(child: Icon(Icons.alarm),);
          }else{
            return CupertinoActivityIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>AddScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
