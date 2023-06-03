class ColorSet{

  String color1;
  String color2;
  String color3;
  String color4;
  String color5;
  String colorsetstr;//"AAA,BBB,CCC,DDD,FFF"
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


   Map<String, dynamic> toJson() => {
     'color1' :color1,
     'color2' :color2,
     'color3' :color3,
     'color4' :color4,
     'color5' :color5,
     'colorsetstr':colorsetstr,
     'share':share,
     'keyword':keyword
  };

  factory ColorSet.fromJson(Map<String, dynamic> json) {
    return ColorSet(
        color1:json['color1'],
        color2:json['color2'],
        color3:json['color3'],
        color4:json['color4'],
        color5:json['color5'],
        colorsetstr: json['colorsetstr'],
        share:json['share'],
        keyword:json['keyword'],
    );
  }

}