import 'package:blackdiamondcar/widgets/fetch_error_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/constraints.dart';
import '../../../../../utils/utils.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/kyc/kyc_model.dart';
import '../../../data/model/kyc/kyc_submit_state_model.dart';
import '../../../logic/cubit/kyc/kyc_info_cubit.dart';
import '../../../logic/cubit/kyc/kyc_info_state.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/primary_button.dart';

class KycVerificationScreen extends StatelessWidget {
  const KycVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Kyc Verification"),
      body: KycSubmitForm(),
    );
  }
}

class KycSubmitForm extends StatefulWidget {
  const KycSubmitForm({super.key});

  @override
  State<KycSubmitForm> createState() => _KycSubmitFormState();
}

class _KycSubmitFormState extends State<KycSubmitForm> {
  late KycInfoCubit kycCubit;
  KycType? _kycType;

  @override
  void initState() {
    kycCubit = context.read<KycInfoCubit>();
    kycCubit.getKycInfo();
    if (kycCubit.kycModel != null && kycCubit.kycModel!.kycType!.isNotEmpty) {
      _kycType = kycCubit.kycModel!.kycType!.first;
      kycCubit.kycIdChange(_kycType!.id.toString());
    } else {
      _kycType = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(),
      child: SingleChildScrollView(
          child: Column(
        children: [
          CustomForm(
            label: 'KYC Type',
            bottomSpace: 14.0,
            child: DropdownButtonFormField<KycType>(
              hint: const CustomText(text: "Select KycType"),
              isDense: true,
              isExpanded: true,
              value: _kycType,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Utils.radius(10.0))),
                ),
              ),
              // onTap: () {
              //   Utils.closeKeyBoard(context);
              // },
              onChanged: (val) {
                if (val == null) return;
                kycCubit.kycIdChange(val.id.toString());
              },

              items: kycCubit.kycModel!.kycType!
                  .map<DropdownMenuItem<KycType>>((KycType value) =>
                      DropdownMenuItem<KycType>(
                          value: value, child: CustomText(text: value.name)))
                  .toList(),
            ),
          ),
          CustomForm(
            label: 'Message',
            bottomSpace: 14.0,
            child: BlocBuilder<KycInfoCubit, KycSubmitStateModel>(
              builder: (context, state) {
                final kycVerify = state.kycInfoState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.message,
                      onChanged: (String value) =>
                          kycCubit.messageChange(value),
                      decoration: const InputDecoration(
                        hintText: 'Write your Message',
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                    ),
                    if (kycVerify is KycVerifyValidateError &&
                        kycVerify.errors.message.isNotEmpty)
                      FetchErrorText(text: kycVerify.errors.message.first),
                  ],
                );
              },
            ),
          ),
          const CustomForm(label: 'Upload File', child: UploadFile()),
          Utils.verticalSpace(20.0),
          BlocConsumer<KycInfoCubit, KycSubmitStateModel>(
              listener: (context, state) {
            final kyc = state.kycInfoState;
            if (kyc is KycVerifyStateError) {
              Utils.failureSnackBar(context, kyc.message);
            } else if (kyc is KycVerifySubmitStateSuccess) {
              Utils.successSnackBar(context, kyc.message);
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pop(true);
              });
            }
          }, builder: (context, state) {
            final kyc = state.kycInfoState;
            if (kyc is KycVerifyStateLoading) {
              return const LoadingWidget();
            }
            return PrimaryButton(
                text: 'Submit',
                onPressed: () {
                  kycCubit.submitKycVerify();
                  kycCubit.clearAllField();
                });
          }),
        ],
      )),
    );
  }
}

class UploadFile extends StatelessWidget {
  const UploadFile({super.key});

  @override
  Widget build(BuildContext context) {
    final kycCubit = context.read<KycInfoCubit>();
    return BlocBuilder<KycInfoCubit, KycSubmitStateModel>(
      builder: (context, state) {
        final existImage = kycCubit.state.tempFile.isNotEmpty
            ? RemoteUrls.imageUrl(kycCubit.state.tempFile)
            : state.tempFile;
        final filePicker = state.file.isNotEmpty ? state.file : existImage;
        final edit = state.kycInfoState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.file.isEmpty && state.tempFile.isEmpty) ...[
              GestureDetector(
                onTap: () async {
                  final file = await Utils.pickSingleImage();
                  if (file != null && file.isNotEmpty) {
                    kycCubit.fileChange(file);
                  }
                },
                child: Container(
                  height: Utils.hSize(70.0),
                  margin: Utils.symmetric(v: 16.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: DottedBorder(
                    padding: Utils.symmetric(v: 24.0),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(Utils.radius(10.0)),
                    color: Color(0xFFE9D634),
                    dashPattern: const [6, 3],
                    strokeCap: StrokeCap.square,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          color: Color(0xFFE9D634),
                        ),
                        Utils.horizontalSpace(5.0),
                        const CustomText(
                          text: "Browser Image",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFE9D634),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ] else ...[
              Stack(
                children: [
                  Container(
                    height: Utils.hSize(180.0),
                    margin: Utils.symmetric(v: 16.0, h: 0.0),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: Utils.borderRadius(),
                      child: CustomImage(
                        path: state.file,
                        isFile: state.file.isNotEmpty,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 20,
                    child: InkWell(
                      onTap: () async {
                        final image = await Utils.pickSingleImage();
                        if (image != null && image.isNotEmpty) {
                          kycCubit.fileChange(image);
                        }
                      },
                      child: const CircleAvatar(
                        maxRadius: 16.0,
                        backgroundColor: Color(0xFFE9D634),
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 20.0),
                      ),
                    ),
                  )
                ],
              )
            ],
            if (edit is KycVerifyValidateError) ...[
              if (edit.errors.image.isNotEmpty)
                FetchErrorText(text: edit.errors.image.first),
            ]
          ],
        );
      },
    );
  }
}
