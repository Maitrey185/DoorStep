import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/data/model/cart_item.dart';
import 'package:openflutterecommerce/presentation/widgets/data_driven/cart_tile.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

import '../profile_bloc.dart';
import '../profile_state.dart';

class MyOrderDetailsView extends StatefulWidget {
  final Function changeView;

  const MyOrderDetailsView({Key key, @required this.changeView})
      : super(key: key);

  @override
  _MyOrderDetailsViewState createState() => _MyOrderDetailsViewState();
}

class _MyOrderDetailsViewState extends State<MyOrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProfileMyOrderDetailsState) {
            return Padding(
                padding: EdgeInsets.all(AppSizes.sidePadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'Order: ',
                                  style: _theme.textTheme.display1,
                                ),
                                TextSpan(
                                  text:
                                  '#' + state.orderData.orderNumber.toString(),
                                  style: _theme.textTheme.display1
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ])),
                          Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(state.orderData.orderDate),
                              style: _theme.textTheme.display3
                                  .copyWith(color: AppColors.lightGray))
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: 'Tacking Number: ',
                                    style: _theme.textTheme.display1
                                        .copyWith(color: _theme.primaryColorLight),
                                  ),
                                  TextSpan(
                                    text: state.orderData.trackingNumber,
                                    style: _theme.textTheme.display1,
                                  ),
                                ])),
                            Text('Delivered',
                                style: _theme.textTheme.display1
                                    .copyWith(color: AppColors.green)),
                          ]),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                state.orderData.totalQuantity.toString(),
                                style: _theme.textTheme.display1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: AppSizes.linePadding),
                                child: Text(
                                  'items',
                                  style: _theme.textTheme.display1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      Column(
                        children: _buildCartProductItems(state),
                      ),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      buildSummaryLine(
                          'Shipping Address:',
                          state.orderData.shippingAddress.toString(),
                          _theme,
                          width),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      buildSummaryLine('Payment Methods:',
                          state.orderData.paymentMethod, _theme, width),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      buildSummaryLine('Discount:',
                          state.orderData.promo.toString(), _theme, width),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      buildSummaryLine(
                          'Total Amount:',
                          '\$' + state.orderData.totalPrice.toStringAsFixed(0),
                          _theme,
                          width),
                      SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      Row(children: <Widget>[
                        OpenFlutterButton(
                          backgroundColor: AppColors.white,
                          borderColor: _theme.primaryColor,
                          textColor: _theme.primaryColor,
                          height: 36,
                          width: (width - AppSizes.sidePadding * 3) / 2,
                          title: 'Reorder',
                          onPressed: (() => {
                            //TODO: reorder process
                          }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppSizes.sidePadding),
                        ),
                        OpenFlutterButton(
                          height: 36,
                          width: (width - AppSizes.sidePadding * 3) / 2,
                          title: 'Leave Feedback',
                          onPressed: (() => {
                            //TODO: leave feedback
                          }),
                        )
                      ])
                    ],
                  ),
                ));
          }
          return Container();
        });
  }

  Widget _buildCartProductItems(ProfileMyOrderDetailsState state) {
    return Padding(
        padding: EdgeInsets.only(bottom: AppSizes.sidePadding),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizes.linePadding * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.lightGray.withOpacity(0.3),
                      blurRadius: AppSizes.imageRadius,
                      offset: Offset(0.0, AppSizes.imageRadius))
                ],
                color: AppColors.white),
            child: Stack(children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 104,
                      child: widget.item.product.mainImage.isLocal
                          ? Image.asset(widget.item.product.mainImage.address)
                          : Image.network(
                          widget.item.product.mainImage.address)),
                  Container(
                      padding: EdgeInsets.only(left: AppSizes.sidePadding),
                      width: width - 134,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: width - 173,
                                    child: Text(widget.item.product.title,
                                        style: _theme.textTheme.display1
                                            .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _theme.primaryColor)),
                                  ),
                                ]),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: AppSizes.linePadding * 2)),
                            Wrap(
                                children: widget.item.selectedAttributes
                                    .map((key, value) => MapEntry(
                                    key,
                                    SelectedAttributeView(
                                      productAttribute: key,
                                      selectedValue: value,
                                    )))
                                    .values
                                    .toList()),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: AppSizes.linePadding * 2),
                            ),
                            Row(children: <Widget>[

                                    Container(
                                      alignment: Alignment.center,

                                  width: 110,
                                  child: Row(children: <Widget>[
                                    Text('Units: ',
                                        style: _theme.textTheme.body1),
                                    Text(widget.item.productQuantity.quantity.toString(),
                                        style: _theme.textTheme.body1
                                            .copyWith(
                                            color:
                                            _theme.primaryColor)),
                                  ])),
                              Container(
                                width: width - 280,
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '\$' +
                                        (widget.item.price).toStringAsFixed(0),
                                    style: _theme.textTheme.display1),
                              )
                            ])
                          ]))
                ],
              ),

            ])));
  }

  Row buildSummaryLine(
      String label, String text, ThemeData _theme, double width) {
    print(label + ' ' + text);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: _theme.textTheme.display1
                .copyWith(color: _theme.primaryColorLight),
          ),
          Container(
            width: width / 2,
            child: Text(
              text,
              style: _theme.textTheme.display1,
            ),
          )
        ]);
  }
}