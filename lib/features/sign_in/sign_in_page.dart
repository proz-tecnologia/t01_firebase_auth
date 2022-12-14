import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_controller.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = SignInController(FirebaseRepository());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is ErrorSignInState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ops, erro no login')));
      }
      if (controller.state is SuccessSignInState) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    controller.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem vindo'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Senha',
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.notifier,
              builder: (_, state, __) {
                return (state is LoadingSignInState)
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              //fazer validacoes dos campos email e senha
                              controller.login(emailController.text, passwordController.text);
                            },
                            child: const Text('Entrar'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.register(emailController.text, passwordController.text);
                            },
                            child: const Text('Registrar'),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
