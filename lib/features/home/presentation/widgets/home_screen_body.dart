import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/user/presentation/friends_screen/view/friends_screen.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/inbox_screen.dart';
import 'package:tafaling/features/post/presentation/create_post_screen/view/create_post_screen.dart';
import 'package:tafaling/features/post/presentation/posts_screen/view/posts_screen.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/view/user_profile_screen.dart';

class HomeScreenBody extends StatelessWidget {
  final bool isBottomSheetOpen;
  const HomeScreenBody({super.key, required this.isBottomSheetOpen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return _getScreen(selectedPage);
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Widget _getScreen(int selectedPage) {
    final List<Widget> screens = [
      const PostsScreen(),
      const FriendsScreen(),
      const CreatePostScreen(),
      const InboxScreen(),
      UserProfileScreen(userId: authUserNotifier.value?.id),
    ];
    return screens[selectedPage];
  }
}
