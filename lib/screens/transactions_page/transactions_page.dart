import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/transactions_page/widgets/custom_transaction_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Transaction',
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h
              ),
              child: CustomTransactionWidget(),
            );
          },
        )
      ),
    );
  }
}
