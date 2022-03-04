import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQsScreen extends StatefulWidget {
  static const String id = 'faqs_screen';
  @override
  _FAQsScreenState createState() => new _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FAQs',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        itemCount: _question.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: kSymmetricPaddingHor,
            child: Container(
              decoration: kBoxShadow,
              child: Card(
                elevation: 0,
                child: ExpansionTile(
                  title: Text(
                    _question[i].que,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    Column(
                      children: _buildExpandableContent(_question[i]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildExpandableContent(Question question) {
    List<Widget> columnContent = [];
    columnContent.add(
      Padding(
        padding: kAllPadding,
        child: Text(
          question.ans,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );

    return columnContent;
  }
}

class Question {
  final String que;
  final String ans;

  Question({required this.que, required this.ans});
}

List<Question> _question = [
  Question(
    que: 'How do I track the progress of an order?',
    ans:
        'Once your order has been shipped, you will receive an email and an SMS notification with details of the order. You can track the shipment by clicking on the link provided in the email.',
  ),
  Question(
    que:
        'What happens after the order gets shipped? Does it directly get delivered?',
    ans:
        'Often items are procured from various vendors across the country and sometimes have to be transported from far-flung parts of your own city or neighbouring areas. In such cases, the item gets shipped from the vendor to our warehouse and then to you. We send regular email updates about the whereabouts of your order to keep you informed of where your item is in the shipping process.',
  ),
  Question(
    que: 'What are my payment options?',
    ans:
        'HomeDecor offers a wide range of payment options to accommodate every need and offer maximum flexibility. The following payment options are currently available: \n\n\t-Internet Banking. We have partnered with 57 leading banks in India. \n\t-Visa, Master, American Express and Diners Credit Cards. \n\t-Debit Cards issued by all leading banks in India. \n\t-HomeDecor Gift cards \n\t-Google Pay and UPI \n\t-No Cost EMI \n\t-Easy EMI Options by American Express, Citi, HDFC, Axis, HSBC, Kotak, Standard Chartered, ICICI bank,Yes bank, RBL, State Bank of India, and Induslnd credit card holders. \n\t-Bajaj Finserv \n\t-Cash On Delivery (This service is currently unavailable) \n\t-Online Wallets such as Mobikwik, Paytm & Payzapp \n\t-PayPal (Available only on Website & Mobile Site)',
  ),
  Question(
    que:
        'Will I get complete refund amount, if I cancel/return the items purchased by No Cost EMI?',
    ans:
        'Yes, you will get a complete refund of the Amount paid by you, post the EMI Discount. \n\nHowever the banks may charge some cancellation/refund, or pre-closure charges. Kindly check with your respective banks policy for Cancellations and Refunds.',
  ),
  Question(
    que:
        'I am unable to track my order after receiving the tracking number (AWB)?',
    ans:
        'HomeDecor generates and sends the tracking number (AWB Number) as soon as our courier partners collect the package from the warehouse. However, the courier partners may take between 24 to 48 hours to update the tracking details on their website and hence, your order may not be tracked during this period. If your package was recently shipped, try using the AWB number after 24 hours.',
  ),
  Question(
    que:
        'My shipment shows delivered but I have not received the order. What should I do?',
    ans:
        'All orders delivered by us have a proof of delivery with signatures by the person who has accepted the order. In case you haven\'t received your shipment, please check with family members, neighbors, security, the mail room, reception, and anyone else who may have accepted the order on your behalf.',
  ),
];
