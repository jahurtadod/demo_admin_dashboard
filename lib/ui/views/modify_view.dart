import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:admin_dashboard/providers/modify_form_provider.dart';
import 'package:admin_dashboard/providers/modify_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class ModifyView extends StatelessWidget {
  const ModifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModifyProvider modifyProvider = Provider.of<ModifyProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => ModifyFormProvider(),
      child: Builder(builder: (context) {
        final modifyFormProvider =
            Provider.of<ModifyFormProvider>(context, listen: false);

        return Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: modifyFormProvider.formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      onFieldSubmitted: (_) =>
                          onFormSubmit(modifyFormProvider, modifyProvider),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre de usuario';
                        }
                      },
                      onChanged: (value) => modifyFormProvider.nombre = value,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su nuevo nombre',
                          label: 'Nombre',
                          icon: Icons.email),
                    ),

                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      // onFieldSubmitted: (_) =>
                      //     onFormSubmit(modifyFormProvider, authProvider),
                      onChanged: (value) =>
                          modifyFormProvider.apellidos = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre de usuario';
                        }
                      },
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: '********',
                          label: 'Ingrese su nuevo apellido',
                          icon: Icons.lock_outline),
                    ),

                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                        onPressed: () =>
                            onFormSubmit(modifyFormProvider, modifyProvider),
                        text: 'Modificar Datos'),

                    const SizedBox(height: 20),
                    LinkText(
                      text: 'Modificar datos',
                      onPressed: () {
                        Navigator.pushNamed(context, Flurorouter.registerRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void onFormSubmit(
      ModifyFormProvider modifyFormProvider, ModifyProvider modifyProvider) {
    final isValid = modifyFormProvider.validateForm();
    if (isValid) {
      modifyProvider.modify(
          modifyFormProvider.nombre, modifyFormProvider.apellidos);
    }
  }
}
