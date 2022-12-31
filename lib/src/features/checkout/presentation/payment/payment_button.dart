import 'package:ecommerce_app/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      paymentButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(paymentButtonControllerProvider);

    final Uri toLaunch =
    Uri(scheme: 'https', host: 'buy.stripe.com', path: 'test_fZe4i135Ca5Eb1CaEE');

    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed:
           () => ref.read(paymentButtonControllerProvider.notifier).launchInBrowser(toLaunch),
    );



    // return Scaffold(
    //     body: Container(
    //         alignment: Alignment.bottomRight,
    //
    //         child:GestureDetector(
    //           child: const Text('Pay'),
    //           onTap:(){
    //             state.isLoading
    //                 ? null
    //                 : () => ref.read(paymentButtonControllerProvider.notifier).pay();
    //
    //           },)
    //     ),
    // );
  }


  Future<void> launchURL2(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
        uri, mode: LaunchMode.externalApplication,
    )){
      throw "Can not launch URL";
    }
  }


  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

}
