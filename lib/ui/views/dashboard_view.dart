import 'package:admin_dashboard/models/user_twilio.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class DashboarView extends StatelessWidget {
  const DashboarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context).user!;
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(LocalStorage.prefs.getString('token') ?? '');
    final user = UserTwilio.fromMap(decodedToken);
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text(
          'Dashboard View',
          style: CustomLabels.h1,
        ),
        const SizedBox(height: 10),
        WhiteCard(
          title: user.email,
          child: Text(user.nombre),
        )
      ],
    );
  }
}
