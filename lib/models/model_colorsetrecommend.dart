class ColorSet{
  String color1;
  String color2;
  String color3;
  String color4;
  String color5;
  String colorsetstr;
  bool share;
  String keyword;
  ColorSet({
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
    required this.colorsetstr,
    required this.share,
    required this.keyword,
  });

  Map<String,dynamic> toJson(){
    return {
      'color1': color1,
      'color1': color2,
      'color1': color3,
      'color1': color4,
      'color1': color5,
      'colorsetstr': colorsetstr,
      'share': share,
      'keyword': keyword
    };
  }
}