import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view_model/cubit/initial_authentication_cubit.dart';

import '../../view_model/bloc/login_screen/login_screen_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthMode mode = AuthMode.login;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenBloc(
          formKey, context.read<InitialAuthenticationCubit>().state.auth),
      child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
        builder: (context, loginPageState) {
          return GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    AbsorbPointer(
                      absorbing: loginPageState is LoadingLoginScreenState,
                      child: Opacity(
                        opacity: (loginPageState is LoadingLoginScreenState)
                            ? 0.5
                            : 1,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 15,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: SizedBox(
                                          height: 50,
                                          child: Text(
                                            loginPageState.authMode ==
                                                    AuthMode.register
                                                ? "Register with us"
                                                : "Login here",
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 45,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: emailController,
                                            decoration: const InputDecoration(
                                              hintText: 'Email',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autofillHints: const [
                                              AutofillHints.email
                                            ],
                                            validator: emailFieldValidator,
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Password',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) =>
                                                value != null &&
                                                        value.isNotEmpty
                                                    ? null
                                                    : 'Required',
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            LoginScreenBloc>(
                                                        context)
                                                    .add(LoginRegisterUserEvent(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  onError: (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(e)));
                                                  },
                                                ));
                                              },
                                              child: Text(loginPageState
                                                  .authMode.label),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(loginPageState.authMode ==
                                                      AuthMode.register
                                                  ? "Already Registered"
                                                  : "Not Registered?"),
                                              TextButton(
                                                  onPressed: () => BlocProvider
                                                          .of<LoginScreenBloc>(
                                                              context)
                                                      .add(ChangeAuthMode()),
                                                  child: Text(
                                                      loginPageState.authMode ==
                                                              AuthMode.register
                                                          ? "Login Here"
                                                          : "Register Here")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: loginPageState is LoadingLoginScreenState,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
