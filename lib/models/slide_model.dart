import 'package:Diagon/utility/onboarding_data.dart';

class SlideModel {
  final String title;
  final String content;
  final String imagePath;

  SlideModel(this.title, this.content, this.imagePath);

  static List<SlideModel> getModels (){
    List<SlideModel> nl = [];
     for (var element in slideData) {
      nl.add(SlideModel(element['title'], element['content'], element['imagePath']));
    }
     return nl;
  }
}


