import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/sahomedecor-794d8.appspot.com/o/no_data_found%2FEmpty-amico.png?alt=media&token=4776e3a7-97af-495e-8608-208d962dbf62',
            width: 300,
            height: 300,
          ),
          const Text(
            'No Data Found',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
