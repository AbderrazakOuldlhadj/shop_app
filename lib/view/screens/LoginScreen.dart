import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/controller/cashing/HiveKeys.dart';

import 'package:shop_app/view/components.dart';
import 'package:shop_app/view/screens/HomeScreen.dart';

import '../../controller/bloc/cubits/loginCubit.dart';
import '../../controller/bloc/states/loginStates.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (ctx, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            Hive.box('data').put(HiveKeys.token, state.loginModel.data?.token);
          } else {
            showToast(state.loginModel.message);
          }
        }
      }, builder: (ctx, state) {
        LoginCubit cubit = LoginCubit.get(ctx);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Login", style: titleTextStyle),
                      const SizedBox(height: 20),
                      const Text("Login now to browse our hot offers",
                          style: subTitleTextStyle),
                      const SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: "Email Address",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Invalid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: primaryColor,
                              obscureText: cubit.isObscure,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      cubit.setObscure(!cubit.isObscure),
                                  child: Icon(
                                    cubit.isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: "Password",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length < 6) {
                                  return "password must have 6 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              child: state is! LoginLoadState
                                  ? Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
