import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/view_model/bloc/home_screen/profile_tab/profile_tab_bloc.dart';
import 'package:flutter_shop/view_model/cubit/initial_authentication_cubit.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ProfileTabBloc(),
        child: BlocBuilder<ProfileTabBloc, ProfileTabState>(
          builder: (context, state) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                      "Email: ${context.read<InitialAuthenticationCubit>().state.auth.currentUser!.email}"),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<InitialAuthenticationCubit>(context)
                            .logout();
                      },
                      child: const Text("Logout"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
