import 'package:flutter/material.dart';
import 'package:shape_cam/cart/size_config.dart';
import 'package:shape_cam/top_product_card.dart';
import 'package:flutter_config/flutter_config.dart';

class TopProductCards extends StatelessWidget {
  const TopProductCards({
    Key key,
    @required this.id,
    @required this.token,
  }) : super(key: key);

  final String id;
  final String token;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0),
                vertical: getProportionateScreenHeight(10.0)),
            child: Text(
              "Top Products",
              style: TextStyle(
                  color: Color(0xFFC0392B),
                  fontSize: getProportionateScreenHeight(25.0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(12.0),
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
              id: id,
              token: token,
              img1:
                  "${FlutterConfig.get('SERVER_URL')}uploads/1622734842373space.PNG",
              img2:
                  "${FlutterConfig.get('SERVER_URL')}uploads/1622734818855s_1.PNG",
              category: "apparel",
              btnTitle: "Apparel",
              imgUrl:
                  "https://images.unsplash.com/photo-1445205170230-053b83016050?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80"),
          SizedBox(
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
            id: id,
            token: token,
            img1:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622729524696img.PNG",
            img2:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622609133634e_5.PNG",
            category: "comp_ele",
            btnTitle: "Computer and Electronics",
            imgUrl:
                "https://images.unsplash.com/photo-1588459460688-561668329db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1096&q=80",
          ),
          SizedBox(
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
            id: id,
            token: token,
            img1:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622609548666f_3.PNG",
            img2:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622609637770f_8.PNG",
            category: "furniture",
            btnTitle: "Furniture",
            imgUrl:
                "https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          ),
          SizedBox(
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
            id: id,
            token: token,
            img1:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622610167363s_1.PNG",
            img2:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622610231286s_4.PNG",
            category: "sports",
            btnTitle: "Sports",
            imgUrl:
                "https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          ),
          SizedBox(
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
            id: id,
            token: token,
            img1:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622609960167m_i_6.PNG",
            img2:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622610070499m_i_3.PNG",
            category: "music",
            btnTitle: "Musical Instruments",
            imgUrl:
                "https://images.unsplash.com/photo-1496293455970-f8581aae0e3b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80",
          ),
          SizedBox(
            child: Divider(
              color: Colors.black,
              indent: getProportionateScreenWidth(15.0),
              endIndent: getProportionateScreenWidth(15.0),
            ),
          ),
          TopProductCard(
            id: id,
            token: token,
            img1:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622610474817t_8.PNG",
            img2:
                "${FlutterConfig.get('SERVER_URL')}uploads/1622610606351t_6.PNG",
            category: "tools",
            btnTitle: "Tools",
            imgUrl:
                "https://images.unsplash.com/photo-1508873535684-277a3cbcc4e8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          ),
        ],
      ),
    );
  }
}
