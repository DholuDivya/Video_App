import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_bloc.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_event.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/transactions_page/widgets/custom_transaction_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<UserTransactionBloc>().add(UserTransactionRequest());
    super.initState();
  }

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
      body: BlocBuilder<UserTransactionBloc, UserTransactionState>(
        builder: (BuildContext context, UserTransactionState state) {
          if(state is UserTransactionLoaded){

            return state.transactionData.length != 0 ? SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.transactionData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transactionData = state.transactionData[index];
                    var status = '';
                    if(transactionData.status == "paid"){
                      status = "Success";
                    }else if(transactionData.status == "failed"){
                      status = "Failed";
                    }else if(transactionData.status == "pending"){
                      status = "Pending";
                    }
                    return state.transactionData.length != 0 ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.h
                      ),
                      child: CustomTransactionWidget(
                        userName: transactionData.userName!,
                        transactionStatus: status,
                        amount: transactionData.amount!,
                        createdAt: transactionData.createdAt!,
                        transactionId: transactionData.transactionId!,
                        planName: transactionData.plan!.name!,
                        timePeriod: transactionData.plan!.duration!,
                        currency: transactionData.currency!,
                      ),
                    ) : Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Center(
                          child: Image.asset(
                            'assets/images/no_data.png',
                            width: 200.w,
                            height: 200.h,
                          )),
                    );
                  },
                )
            ) : Center(
                child: Image.asset(
                  'assets/images/no_data.png',
                  width: 200.w,
                  height: 200.h,
                ));
          } else if(state is UserTransactionLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Center(
                child: Image.asset(
                  'assets/images/no_data.png',
                  width: 200.w,
                  height: 200.h,
                )),
          );
        },
      ),
    );
  }
}
