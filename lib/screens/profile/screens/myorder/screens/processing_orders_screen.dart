import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/components/refresh_indicator.dart';
import 'package:flutter/material.dart';

class ProcessingOrders extends StatelessWidget {
  const ProcessingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CommonRefreshIndicator(
        child: _processingList(),
      ),
    );
  }

  ListView _processingList() => ListView.builder(
        physics: kPhysics,
        padding: kSymmetricPaddingHor,
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _listTile();
        },
      );

  Container _listTile() => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _detailColumn(),
          ),
        ),
      );

  Column _detailColumn() => Column(
        children: [
          _orderNumberAndDate(),
          const Divider(),
          _quantityAndAmount(),
          _detailButtonAndStatus(),
        ],
      );

  Padding _orderNumberAndDate() => Padding(
        padding: kAllPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Order No. 1234',
              style: kOrderBoldTextStyle,
            ),
            Text(
              '23/03/2001',
              style: kOrderTextStyle,
            ),
          ],
        ),
      );

  Padding _quantityAndAmount() => Padding(
        padding: kAllPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRichText('Quantity:', '03'),
            _buildRichText('Total Amount:', '\$150'),
          ],
        ),
      );

  RichText _buildRichText(String firstText, String secondText) => RichText(
        text: TextSpan(
          text: '$firstText ',
          style: kOrderTextStyle,
          children: <TextSpan>[
            TextSpan(
              text: secondText,
              style: kOrderBoldTextStyle,
            ),
          ],
        ),
      );

  Padding _detailButtonAndStatus() => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _button(),
            _status(),
          ],
        ),
      );

  Expanded _button() => Expanded(
        child: CustomButton(label: 'Details', onPressed: () {}),
        flex: 1,
      );

  Expanded _status() => const Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: kSymmetricPaddingHor,
              child: Text(
                'Processing',
                style: TextStyle(
                  color: Colors.lime,
                  fontSize: 18,
                ),
              ),
            )),
        flex: 2,
      );
}
