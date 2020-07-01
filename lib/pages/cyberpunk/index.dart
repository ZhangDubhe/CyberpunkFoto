import 'dart:typed_data';
import 'dart:ui';
import 'package:cyberpunkphoto/pages/cyberpunk/breathe_light.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/filter_view_model.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/image_layer.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as imageLib;

import 'package:cyberpunkphoto/global/themes.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/image_layer_old.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:rxdart/rxdart.dart';

class CyberpunkFuture extends StatefulWidget {
  String url;

  CyberpunkFuture({this.url});

  @override
  _CyberpunkFutureState createState() => _CyberpunkFutureState();
}

class _CyberpunkFutureState extends State<CyberpunkFuture> {
  String _url = 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?ixlib=rb-1.2.1&auto=format&fit=crop&w=2013&q=80';
  BehaviorSubject<bool> _filterSwitcher = BehaviorSubject.seeded(true);
  String _localFile;
  TextStyle  _textStyle;
  TextStyle  _titleStyle;
  imageLib.Image image;
  ImagePicker _imagePicker = ImagePicker();
  FilterViewModel _vm = FilterViewModel();

  Future<Uint8List> pickImage() async {
    PickedFile imageFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (imageFile == null) throw Error();
    print(imageFile.path);
    return await imageFile.readAsBytes();
  }

  Future<Uint8List> webPickImage() async {
    Uint8List fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    return fromPicker;
  }
  Future getImage() async {
    Uint8List _data = (kIsWeb == true) ? await webPickImage() : await pickImage();
    imageLib.Image _image = imageLib.decodeImage(_data);
    _image = imageLib.copyResize(_image, height: 1080,);
    setState(() {
      image = _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _titleStyle = GoogleFonts.vt323(
        color: Colors.white,
        fontSize: 30
    );
    _textStyle = _titleStyle.merge(TextStyle(
        color: ThemeColor.kCyberPink,
        fontSize: 20,
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Color(0x9F000000), BlendMode.darken),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pic_bg.png')
          )
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              BreatheLight(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Cyberpunk You foto!',
                  style: _titleStyle, textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageLayer(
                  viewModel: _vm,
                  image: image,
                ),
              ),
//            ImageLayerOld(
//              url: _url,
//              isFilterOn: _filterSwitcher,
//            ),
              SizedBox(height: 10,),
              cyberpunkControl(),
              _bottomControl(),
              BreatheLight(),
            ],
          ),
        ),
      )
    );
  }

  Widget _bottomControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => getImage(),
          child: Container(
            width: 160,
            height: 90,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/btn_imp.png')
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => print('Export'),
          child: Container(
            width: 160,
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/btn_exp.png')
              ),
            ),
          ),
        ),

      ],
    );
  }
  Widget cyberpunkControl() {
    return StreamBuilder<bool>(
        stream: _filterSwitcher,
        initialData: true,
        builder: (context, snapshot) {
          return image != null ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Back now', style: _textStyle,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch.adaptive(
                  onChanged: (bool _isOn) {
                    _filterSwitcher.add(_isOn);
                    _vm.showFilter(isShow: _isOn);
                  },
                  value: snapshot.data,
                  activeColor: ThemeColor.kCyberPurple,
                ),
              ),
              Text('To Future!', style: _textStyle)
            ],
          ) : Center(
            child: Text('Import Photo, have a try!', style: _textStyle,),
          );
        }
    );
  }

  @override
  void initState() {
  }
}

