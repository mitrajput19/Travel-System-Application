import 'package:flutter/material.dart';

import 'orientation.dart';

class Images {

  Images._();
  static const String loginimage = "assets/images/login.jpg";
  static const String splash = "assets/images/splashimg.jpg";
}

BoxFit imagefitting(){
  if(SizeConfig.isMobilePortrait){
    return BoxFit.cover;
  }else{
    return BoxFit.fitHeight;
  }
}