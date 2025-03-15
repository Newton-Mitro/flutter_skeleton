import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/presentation/widgets/profile_video_grid.dart';
import 'package:tafaling/features/user/data/data_sources/follower_data.dart';
import 'package:tafaling/features/user/data/data_sources/following_data.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/widgets/following_users.dart';
import 'package:tafaling/features/user/presentation/widgets/users_followers.dart';
import 'package:tafaling/injection_container.dart';

final profileTabs = [
  Tab(text: 'Posts'),
  Tab(text: 'Following'),
  Tab(text: 'followers'),
];

class UserProfileScreen extends StatelessWidget {
  final Object? userId;

  const UserProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final profileBloc = serviceLoc<ProfileBloc>();
        profileBloc.add(FetchProfileEvent(userId: userId as int, fetchPage: 1));
        return profileBloc;
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // if (state.loading) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.posts.isNotEmpty) {
            return _buildProfilePage(context, state.posts, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProfilePage(
      BuildContext context, List<PostModel> posts, ProfileState state) {
    var profilePic = posts[0].creator.profilePicture ?? '';
    var userId = posts[0].creator.id;
    var userName = posts[0].creator.name;
    var followers = posts[0].creator.followers;
    var following = posts[0].creator.following;
    var isFollowing = posts[0].creator.isFollowing;
    List<PostModel> myPosts = posts.isNotEmpty && posts[0].id != 0 ? posts : [];

    return PopScope(
      child: DefaultTabController(
        length: profileTabs.length, // Two tabs: Public and Private
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                userId == authUserNotifier.value?.id ? false : true,
            title: const Text(
              'Profile',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // More Actions
                },
              ),
            ],
          ),
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 0,
                    pinned: true,
                    floating: true,
                    snap: true,
                    expandedHeight: 350.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 100,
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: profilePic.isNotEmpty
                                      ? Image.network(
                                          profilePic,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/avatar.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FollowStatus(
                                  label: "Following",
                                  value: following.toString(),
                                  onPressed: () {},
                                ),
                                FollowStatus(
                                  label: "Followers",
                                  value: followers.toString(),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Show "Edit Profile" and "Share Profile" if it's the authenticated user's profile
                                if (userId == authUserNotifier.value?.id) ...[
                                  FilledButton(
                                    child: Text(
                                      "Edit Profile",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Edit Profile Action
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    child: Text(
                                      "Share Profile",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Share Profile Action
                                    },
                                  ),
                                ]
                                // If it's not the authenticated user's profile, show "Follow/Unfollow" buttons
                                else ...[
                                  isFollowing
                                      ? state.loading
                                          ? CircularProgressIndicator(
                                              color: Colors.red,
                                            )
                                          : FilledButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 13, 82, 14),
                                              ),
                                              child: Text(
                                                "Unfollow",
                                                style: context.theme.textTheme
                                                    .labelMedium,
                                              ),
                                              onPressed: () {
                                                context.read<ProfileBloc>().add(
                                                    UnFollowUserEvent(userId));
                                              },
                                            )
                                      : state.loading
                                          ? CircularProgressIndicator(
                                              color: Colors.red,
                                            )
                                          : FilledButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 6, 47, 82),
                                              ),
                                              child: Text(
                                                "Follow",
                                                style: context.theme.textTheme
                                                    .labelMedium,
                                              ),
                                              onPressed: () {
                                                context.read<ProfileBloc>().add(
                                                    FollowUserEvent(userId));
                                              },
                                            ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    child: Text(
                                      "Message",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Share Profile Action
                                    },
                                  ),
                                ],
                                // Always show "Message" and "My Icon Button"
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0B4B4A),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'This is a short bio about the user. It can include interests, hobbies, or anything the user wants to share.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white, // Active tab color
                        unselectedLabelColor: Colors.grey, // Inactive tab col
                        tabs: profileTabs,
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  ProfileVideoGrid(
                    itemCount: myPosts.length,
                    myPosts: myPosts,
                  ),
                  FollowingUsers(
                    itemCount: followingUsers.length,
                    users: followingUsers,
                  ),
                  UsersFollowers(
                    itemCount: myFollowers.length,
                    users: myFollowers,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(TabBar tabBar) : _tabBar = tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: const Color.fromARGB(255, 2, 31, 32),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
