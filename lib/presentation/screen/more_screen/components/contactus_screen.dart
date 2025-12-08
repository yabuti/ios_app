import 'package:carsbnb/logic/cubit/contact_message/contact_message_cubit.dart';
import 'package:carsbnb/logic/cubit/contact_message/contact_message_state.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/language_code_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/fetch_error_text.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Contact Us"),
      body: BlocListener<ContactMessageCubit, LanguageCodeState>(
        listener: (context, state) {
          final contact = state.contactMessageState;
          if (contact is ContactMessageStateLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (contact is ContactMessageStateError) {
              Utils.failureSnackBar(context,contact.message);
            } else if (contact is ContactMessageStateSuccess) {
              Utils.successSnackBar(context, contact.message);
              Navigator.pop(context);
            }
          }
        },
        child: Padding(
          padding: Utils.symmetric(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ContactMessageCubit, LanguageCodeState>(
                  builder: (context, state) {
                    final contact = state.contactMessageState;
                    return Column(
                      children: [
                        CustomForm(
                            label: 'Name',
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: 'Name here',
                              ),
                              keyboardType: TextInputType.text,
                            )),
                        if (contact is ContactMessageValidateStateError) ...[
                          if (contact.errors.name.isNotEmpty)
                            FetchErrorText(text: contact.errors.name.first),
                        ]

                      ],
                    );
                  }
                ),
                Utils.verticalSpace(10.0),
                BlocBuilder<ContactMessageCubit, LanguageCodeState>(
                  builder: (context,state) {
                    final contact = state.contactMessageState;
                    return Column(
                      children: [
                        CustomForm(
                            label: 'Subject',
                            child: TextFormField(
                             controller: subjectController,
                              decoration: const InputDecoration(
                                hintText: 'subject',
                              ),
                              keyboardType: TextInputType.number,
                            )),
                        if (contact is ContactMessageValidateStateError) ...[
                          if (contact.errors.subject.isNotEmpty)
                            FetchErrorText(text: contact.errors.subject.first),
                        ]
                      ],
                    );
                  }
                ),
                Utils.verticalSpace(10.0),
                BlocBuilder<ContactMessageCubit, LanguageCodeState>(
                  builder: (context,state) {
                    final contact = state.contactMessageState;
                    return Column(
                      children: [
                        CustomForm(
                            label: 'Email',
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: 'email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )),
                        if (contact is ContactMessageValidateStateError) ...[
                          if (contact.errors.email.isNotEmpty)
                            FetchErrorText(text: contact.errors.email.first),
                        ]

                      ],
                    );
                  }
                ),
                Utils.verticalSpace(10.0),
                BlocBuilder<ContactMessageCubit, LanguageCodeState>(
                    builder: (context,state) {
                      final contact = state.contactMessageState;
                    return Column(
                      children: [
                        CustomForm(
                            label: 'Message',
                            child: TextFormField(
                              maxLines: 4,
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: 'message',

                              ),
                              keyboardType: TextInputType.text,
                            )),
                        if (contact is ContactMessageValidateStateError) ...[
                          if (contact.errors.message.isNotEmpty)
                            FetchErrorText(text: contact.errors.message.first),
                        ]
                      ],
                    );
                  }
                ),
                Utils.verticalSpace(20.0),
                PrimaryButton(text: "Send Now", onPressed: (){
                  final body = {
                    'message': messageController.text.trim(),
                    'name': nameController.text.trim(),
                    'email': emailController.text.trim(),
                    'subject': subjectController.text.trim(),
                  };
                  context.read<ContactMessageCubit>().contactMessage(body);
                  messageController.clear();
                  nameController.clear();
                  emailController.clear();
                  subjectController.clear();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
