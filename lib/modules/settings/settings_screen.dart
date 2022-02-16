import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ShopSuccessLogoutState) {
          if (!state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        if (AppCubit().get(context).uload) {
          nameController.text = AppCubit().get(context).userModel.data!.name;
          emailController.text = AppCubit().get(context).userModel.data!.email;
          phoneController.text = AppCubit().get(context).userModel.data!.phone;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopLoadingUserDataState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person,
                        validatemsg: 'name must not be empty',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email,
                        validatemsg: 'email must not be empty',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        prefix: Icons.phone,
                        validatemsg: 'phone must not be empty',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // defaultButton(
                      //   function: () {
                      //     if (formKey.currentState!.validate()) {
                      //       AppCubit().get(context).updateUserData(
                      //             name: nameController.text,
                      //             phone: phoneController.text,
                      //             email: emailController.text,
                      //           );
                      //     }
                      //   },
                      //   text: 'update',
                      // ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          AppCubit().get(context).signout(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
