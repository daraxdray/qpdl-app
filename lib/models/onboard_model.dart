import 'package:qpdl/utility/onboarding_data.dart';

class OnBoardModel {
  final String title;
  final String content;
  final String imagePath;

  OnBoardModel(this.title, this.content, this.imagePath);

  static List<OnBoardModel> getModels (){
    List<OnBoardModel> nl = [];
     for (var element in obData) {
      nl.add(OnBoardModel(element['title'], element['content'], element['imagePath']));
    }
     return nl;
  }
}


