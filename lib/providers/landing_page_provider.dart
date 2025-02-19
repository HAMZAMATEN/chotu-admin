import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPageProvider extends ChangeNotifier {

  PageController pageController = PageController(initialPage: 0, keepPage: true);
  int currentPage = 0 ;

  updatePageIndex(index){
    currentPage = index;
    notifyListeners();
  }
  PageController reviewPageController = PageController(initialPage: 0, keepPage: true);
  int currentReview = 0 ;

  updateReviewIndex(index){
    currentReview = index;
    notifyListeners();
  }

}