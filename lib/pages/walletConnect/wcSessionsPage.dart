import 'package:app/common/components/jumpToLink.dart';
import 'package:app/pages/walletConnect/wcPairingConfirmPage.dart';
import 'package:app/service/index.dart';
import 'package:app/utils/i18n/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';
import 'package:polkawallet_ui/components/v3/back.dart';
import 'package:polkawallet_ui/components/v3/index.dart';
import 'package:polkawallet_ui/components/v3/roundedCard.dart';

class WCSessionsPage extends StatefulWidget {
  const WCSessionsPage(this.service);
  final AppService service;

  static const String route = '/wc/session';

  @override
  _WCSessionsPageState createState() => _WCSessionsPageState();
}

class _WCSessionsPageState extends State<WCSessionsPage> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context).getDic(i18n_full_dic_app, 'account');

    return Observer(builder: (_) {
      final session = widget.service.store.account.wcSession;
      return Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/images/wallet_connect_banner.png',
                height: 20),
            centerTitle: true,
            leading: BackBtn()),
        body: SafeArea(
          child: RoundedCard(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            dic['wc.connect'],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: WCPairingSourceInfoDetail(session),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(16),
                        //   child: Text(
                        //     dic['wc.permission'],
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 24),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: permissions.map((e) {
                        //       return Text('- $e');
                        //     }).toList(),
                        //   ),
                        // )
                      ]),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.lightGreen,
                        ),
                        Text(dic['wc.connected'])
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24, bottom: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            JumpToLink(
                              'https://walletconnect.com/',
                              text: dic['wc.service'],
                              color: Theme.of(context).disabledColor,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Button(
                        title: dic['wc.disconnect'],
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
