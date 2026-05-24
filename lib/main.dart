import 'package:demo_project/controllers/cubit/login_cubit.dart';
import 'package:demo_project/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setup for hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getTemporaryDirectory()).path),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // final String title;
  // final emailController = TextEditingController(text: 'am@gmail.com');
  final nameController = TextEditingController(text: 'ahmed');
  final passwordController = TextEditingController(text: '123456789');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,
                children: [
                  SizedBox(height: 200),
                  Text('Welcome back to login.', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(
                              isEmail: false,
                              labelText: 'name',
                              prefixIcon: Icon(Icons.person_pin),
                              controller: nameController,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              labelText: 'password',
                              prefixIcon: Icon(Icons.password),
                              controller: passwordController,
                            ),

                            // todo: to not rebuild the whole body but only the elevated button
                            BlocConsumer<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state is LoginFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage),
                                      backgroundColor: Colors.red,),
                                  );
                                } else if (state is LoginSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Login Success'),
                                      backgroundColor: Colors.green,),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is LoginLoading ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,),) :
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<LoginCubit>().login(
                                          nameController.text,
                                          passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.blue,),
                                    child: Text('Login')
                                );
                              },

                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),


      ),
    );
  }
}
