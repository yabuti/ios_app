import 'package:carsbnb/data/data_provider/remote_url.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/kyc/kyc_model.dart';
import '../../../logic/cubit/kyc/kyc_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_text.dart';

class KycViewScreen extends StatefulWidget {
  const KycViewScreen({super.key});

  @override
  State<KycViewScreen> createState() => _KycViewScreenState();
}

class _KycViewScreenState extends State<KycViewScreen> {
  late KycInfoCubit kycCubit;

  @override
  void initState() {
    kycCubit = context.read<KycInfoCubit>();
    kycCubit.getKycInfo();
    super.initState();
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              CustomImage(path: RemoteUrls.imageUrl(imageUrl)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "KYC Verification"),
      body: Padding(
        padding: Utils.symmetric(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showImageDialog(kycCubit.kycModel!.kyc!.file);
              },
              child: Container(
                padding: Utils.all(value: 14.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: borderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(
                      columnWidths: const {
                        2: IntrinsicColumnWidth(), // For label column
                        1: FlexColumnWidth(), // For value column
                      },
                      children: [
                        _buildTableRow(
                            "Document Type:",
                            _getDocumentTypeName(
                                kycCubit.kycModel!.kyc!.kycId)),
                      ],
                    ),
                    Row(
                      children: [
                        const CustomText(
                          text: "Status:",
                          color: sTextColor,
                        ),
                        Utils.horizontalSpace(110.0),
                        if (kycCubit.kycModel!.kyc!.status == 0) ...[
                          Container(
                            padding: Utils.symmetric(h: 10.0, v: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.yellow.shade500),
                            child: const CustomText(
                              text: "Pending",
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ] else if (kycCubit.kycModel!.kyc!.status == 1) ...[
                          Container(
                            padding: Utils.symmetric(h: 10.0, v: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.shade600),
                            child: const CustomText(
                              text: "Approved",
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ] else if (kycCubit.kycModel!.kyc!.status == 2) ...[
                          Container(
                            padding: Utils.symmetric(h: 10.0, v: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.red.shade600),
                            child: const CustomText(
                              text: "Reject",
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Expanded(child: PrimaryButton(text: "Edit", onPressed: (){
                    //       Navigator.pushNamed(context, RouteNames.kycScreen);
                    //     })),
                    //     Utils.horizontalSpace(8.0),
                    //     Expanded(child: PrimaryButton(text: "View", onPressed: (){
                    //       _showImageDialog(kycCubit.kycModel!.kyc!.file);
                    //     },bgColor: const Color(0xFF0D274E),)),
                    //   ],
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getDocumentTypeName(int id) {
    final kycType = kycCubit.kycModel!.kycType!.firstWhere(
        (type) => type.id == id,
        orElse: () => const KycType(
            id: 0, name: 'Unknown', status: 0, createdAt: '', updatedAt: ''));
    return kycType.name;
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: sTextColor,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Color(0xFFE9D634),
            ),
          ),
        ),
      ],
    );
  }
}
