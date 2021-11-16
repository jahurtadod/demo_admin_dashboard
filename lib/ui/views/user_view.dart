import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/providers/user_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';

import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notificarions_service.dart';

import 'package:admin_dashboard/models/user.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'User View',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          if (user == null)
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(),
              ),
            ),
          if (user != null) _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {0: FixedColumnWidth(250)},
        children: const [
          TableRow(children: [
            // Avatar
            _AvatarContainer(),

            _UserViewForm(),
          ])
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del Usuario',
                label: 'Nombre',
                icon: Icons.supervised_user_circle_outlined,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Ingrese un nombre';
                if (value.length < 2)
                  return 'El nombre debe tener dos letras minimo';
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(nombre: value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Correo del Usuario',
                  label: 'Correo',
                  icon: Icons.mark_email_read_outlined),
              validator: (value) {
                if (!EmailValidator.validate(value ?? '')) {
                  return 'Email no válido';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(correo: value),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: ElevatedButton(
                  onPressed: () async {
                    final save = await userFormProvider.updateUser();
                    if (save) {
                      NotificationsService.showSnackbar('Usuario actualizado');
                      // print(user);
                      Provider.of<UsersProvider>(context, listen: false)
                          .refresUser(user);
                    } else {
                      NotificationsService.showSnackbarError(
                          'No se pudo actualizar');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    shadowColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.save_outlined),
                      Text(' Guardar'),
                    ],
                  )),
            )
          ],
        ),
      ),
      title: 'Información generar del ususrio',
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.img == null)
        ? const Image(image: AssetImage('assets/no-image.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'assets/loader.gif', image: user.img!);

    return WhiteCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                    child: image,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 5)),
                      child: FloatingActionButton(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'jpeg', 'png']);

                          if (result != null) {
                            // PlatformFile file = result.files.first;
                            NotificationsService.showBusyIndicator(context);

                            final newUser = await userFormProvider.uploadImage(
                                '/uploads/usuarios/${user.uid}',
                                result.files.first.bytes!);

                            Provider.of<UsersProvider>(context, listen: false)
                                .refresUser(newUser);

                            Navigator.of(context).pop();
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Icon(Icons.camera_alt_outlined),
                        elevation: 0,
                        backgroundColor: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.nombre,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
