import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/app_configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/core/widgets/app_text_input.dart';
import 'package:tafaling/core/widgets/network_error_dialog.dart';
import 'package:tafaling/features/auth/presentation/views/registration_screen/bloc/registration_screen_bloc.dart';
import 'package:tafaling/features/post/injection.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegistrationScreenBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.theme.colorScheme.primary,
                context.theme.colorScheme.secondary,
              ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: BlocListener<RegistrationScreenBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationErrorState) {
                if (state.message == "No internet connection") {
                  NetworkErrorDialog.show(context);
                } else {
                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'On Snap!',
                      message: state.message,

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              }

              if (state is RegistrationSuccessState) {
                Navigator.pushReplacementNamed(context, RoutesName.homePage);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<RegistrationScreenBloc, RegistrationState>(
                    builder: (context, state) {
                      return Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppLogo(width: 150, height: 150),
                          const SizedBox(height: 50),
                          AppTextInput(
                            controller: nameController,
                            label: 'Name',
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['name']?.isNotEmpty == true
                                        ? state.errors['name']![0]
                                        : null
                                    : null,
                            prefixIcon: Icon(Icons.person),
                          ),
                          AppTextInput(
                            controller: emailController,
                            label: 'Email',
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['email']?.isNotEmpty == true
                                        ? state.errors['email']![0]
                                        : null
                                    : null,
                            prefixIcon: Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          AppTextInput(
                            controller: passwordController,
                            label: 'Password',
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['password']?.isNotEmpty ==
                                            true
                                        ? state.errors['password']![0]
                                        : null
                                    : null,
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          AppTextInput(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state
                                                .errors['confirm_password']
                                                ?.isNotEmpty ==
                                            true
                                        ? state.errors['confirm_password']![0]
                                        : null
                                    : null,
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<
                            RegistrationScreenBloc,
                            RegistrationState
                          >(
                            builder: (context, state) {
                              if (state is RegistrationLoadingState) {
                                return CircularProgressIndicator();
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<RegistrationScreenBloc>().add(
                                    RegisterEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  backgroundColor: Colors.tealAccent,
                                ),
                                child: const Text('Register'),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
