import 'package:carsbnb/utils/constraints.dart';
import 'package:carsbnb/widgets/custom_app_bar.dart';
import 'package:carsbnb/widgets/custom_form.dart';
import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';

class BecomeVendorScreen extends StatelessWidget {
  const BecomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Become a Dealer'),
      body: Padding(
        padding: Utils.symmetric(),
        child: ListView(children: [
          Column(children: [
            CustomForm(label: "Company Name", child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Company name"
              ),
            )),
            Utils.verticalSpace(14.0),
            CustomForm(label: "User Name", child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "user name"
              ),
            )),
            Utils.verticalSpace(14.0),
            CustomForm(label: "Email", child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "email"
              ),
              keyboardType: TextInputType.emailAddress,
            )),
            Utils.verticalSpace(14.0),
            CustomForm(label: "Phone", child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Phone"
              ),
              keyboardType: TextInputType.phone,
            )),
            Utils.verticalSpace(14.0),
            CustomForm(label: "Address", child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "address"
              ),
            )),
            Utils.verticalSpace(14.0),
            CustomForm(label: "Zip Code", child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "zip code"
              ),
            )),
            Utils.verticalSpace(14.0),
            CustomForm(
              label: 'Select State',
              child: DropdownButtonFormField<DummyCategoryModel>(
                hint: const CustomText(text: "state"),
                isDense: true,
                isExpanded: true,
                // value: _categories!,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(Utils.radius(10.0))),
                  ),
                ),
                onTap: () => Utils.closeKeyBoard(context),
                onChanged: (value) {
                  if (value == null) return;
                  //serviceCubit.changeCategoryId(value.id.toString());
                },
                items: locationList
                    .map<DropdownMenuItem<DummyCategoryModel>>(
                        (DummyCategoryModel value) =>
                        DropdownMenuItem<DummyCategoryModel>(
                            value: value,
                            child: CustomText(
                              text: value.name,
                              fontFamily: bold700,
                              fontSize: 16.0,
                            )))
                    .toList(),
              ),
            ),
            Utils.verticalSpace(14.0),
            CustomForm(
                label: 'Password',
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Password here',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      // onPressed: () => loginBloc.add(
                      //     LoginEventShowPassword(
                      //         state.showPassword)),
                      icon:
                      Icon(Icons.visibility_off_outlined, color: blackColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                )),
            Utils.verticalSpace(14.0),
            CustomForm(
                label: 'Confirm Password',
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'confirm Password here',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      // onPressed: () => loginBloc.add(
                      //     LoginEventShowPassword(
                      //         state.showPassword)),
                      icon:
                      Icon(Icons.visibility_off_outlined, color: blackColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                )),
          ],),
          Utils.verticalSpace(20.0),
        ],),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(h: 20.0, v: 10.0),
        child: PrimaryButton(
          text: 'Submit',
          onPressed: ()  {

          },
        ),
      ),
    );
  }
}
