import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/locator/locator.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';
import 'package:warsha_counter/core/utils/themes/colors.dart';
import '../../core/model/user_model.dart';
import '../../cubit/counter/counter_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<CounterCubit>(),
      child: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          final currentUserId = FirebaseAuth.instance.currentUser?.uid;
          UserModel? currentUser;

          if (state is CounterLoaded) {
            currentUser = state.users.firstWhere(
              (user) => user.id == currentUserId,
              orElse: () => UserModel(
                emailVerified: false,
                topRank: 0,
                id: '',
                name: '',
                email: '',
                insults: 0,
                isAdmin: false,
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('ترتيب الصدارةً'),
              leading: currentUser?.isAdmin == true
                  ? Icon(
                      Icons.admin_panel_settings_outlined,
                      color: ColorManager.black,
                    )
                  : null,
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CounterState state) {
    if (state is CounterLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CounterError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state is CounterLoaded) {
      final rankedUsers = state.users
        ..sort((a, b) => b.insults.compareTo(a.insults));
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      UserModel? currentUser;

      if (currentUserId != null) {
        currentUser = rankedUsers.firstWhere(
          (user) => user.id == currentUserId,
          orElse: () => UserModel(
            emailVerified: false,
            topRank: 0,
            id: '',
            name: '',
            email: '',
            insults: 0,
            isAdmin: false,
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(10.w),
        itemCount: rankedUsers.length,
        itemBuilder: (context, index) {
          final user = rankedUsers[index];
          final isAdmin = currentUser?.isAdmin ?? false;

          return Card(
            elevation: 4,
            color: ColorManager.white,
            margin: EdgeInsets.only(bottom: 10.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isAdmin)
                                Text(
                                  user.email,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        _getCenterTitle(user.insults),
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                    if (isAdmin) ...[
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomIconButton(
                              isIncrement: true,
                              onPressed: () => context
                                  .read<CounterCubit>()
                                  .updateInsultsById(user.id, 1)),
                          CustomIconButton(
                              isIncrement: false,
                              onPressed: () => context
                                  .read<CounterCubit>()
                                  .updateInsultsById(user.id, -1)),
                        ],
                      ),
                    ],
                  ],
                ).withAllPadding(12.w),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: !isAdmin ? 0 : null,
                  child: Card(
                    color: _getCardColor(index),
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomRight:
                            !isAdmin ? Radius.circular(12.0) : Radius.zero,
                      ),
                    ),
                    elevation: 5,
                    child: Text(
                      '${index + 1}',
                      style: context.textTheme.bodyLarge,
                    ).center().withSize(width: 60, height: 60),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return const Center(child: Text('Unknown state'));
  }
}

Color _getCardColor(int index) {
  return index == 0
      ? Colors.amber
      : index == 1
          ? Colors.blueGrey
          : index == 2
              ? Colors.brown[400]!
              : Colors.grey;
}

String _getCenterTitle(int n) {
  if (n == 0) {
    return "كلين شيت";
  } else if (n == 1) {
    return "شتيمه واحده";
  } else if (n < 0) {
    return "انت مولانا ($n)";
  } else if (n > 1) {
    return "$n شتايم";
  }
  return "ليه كدا";
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.isIncrement, required this.onPressed});
  final void Function()? onPressed;
  final bool isIncrement;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
          backgroundColor: isIncrement ? ColorManager.green : ColorManager.red,
          shadowColor: ColorManager.black,
          elevation: 4),
      icon: Icon(isIncrement ? Icons.add : Icons.remove, size: 24.sp),
      color: ColorManager.white,
      onPressed: onPressed,
    );
  }
}
