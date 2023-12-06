
import 'dart:io';
import 'package:anime_adder/db/sql_helper.dart';
import 'package:anime_adder/model/animeinfos.dart';
import 'package:anime_adder/widget/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'mian_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _picker = ImagePicker();
  final _animeName = TextEditingController();
  final _animeEpisodes = TextEditingController();
  final _animeDesc = TextEditingController();
 XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Anime'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            _xFile == null ? _defaultImage() : _animeImage(),
            SizedBox(height: 20,),
            MyTextField(controller: _animeName, hint: 'Anime Name'),
            SizedBox(height: 20,),
            MyTextField(controller: _animeEpisodes, hint: 'Anime Episodes'),
            SizedBox(height: 20,),
            MyTextField(controller: _animeDesc, hint: 'Anime Desc'),
            ElevatedButton(onPressed: _saveNewAnimeInfo, child: Text('Save Anime'))
          ],
        ),
      ),
    );
  }
  Widget _defaultImage(){
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 2)
      ),
      child: InkWell(
        onTap: () async{
          _xFile = await _picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        child: const Center(
          child: Icon(CupertinoIcons.photo),
        ),
      ),
    );
  }
  _animeImage(){
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 2)
      ),
      child: Image.file(File(_xFile?.path ?? ""),fit: BoxFit.cover,),
    );
  }

  void _saveNewAnimeInfo(){
    final newAnime = Passport(id: null, animeName: _animeName.text, animeEpisodes: _animeEpisodes.text, animeDesc: _animeDesc.text, image: _xFile?.path);
    SqlHelper.saveNewAnime(newAnime).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('save')));
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=> MainPage()), (route) => false);
    });
  }
}
