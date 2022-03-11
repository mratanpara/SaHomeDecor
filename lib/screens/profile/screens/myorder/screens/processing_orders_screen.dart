import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:flutter/material.dart';

class ProcessingOrders extends StatelessWidget {
  const ProcessingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CommonRefreshIndicator(
        child: ListView.builder(
          physics: kPhysics,
          padding: kSymmetricPaddingHor,
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: kBoxShadow,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Padding(
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
                      ),
                      const Divider(),
                      Padding(
                        padding: kAllPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRichText('Quantity:', '03'),
                            _buildRichText('Total Amount:', '\$150'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: kSymmetricPaddingVer,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                  label: 'Details', onPressed: () {}),
                              flex: 1,
                            ),
                            const Expanded(
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

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
}
