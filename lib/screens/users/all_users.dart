import 'package:chotu_admin/model/user_model.dart';
import 'package:chotu_admin/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chotu_admin/screens/users/widgets/ShowUserPopupDialog.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../generated/assets.dart';
import '../../providers/riders_provider.dart';

import '../../utils/app_colors.dart';
import '../../widgets/pagination_widget.dart';
import 'widgets/user_tile_widget.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getAllUsers(1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: Column(
            children: [
              CustomTextField(
                  width: MediaQuery.of(context).size.width,
                  title: '',
                  controller: provider.searchController,
                  obscureText: false,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  hintText: 'Search users by name',
                  suffixIcon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: SvgPicture.asset(Assets.iconsSearchnormal1),
                    ),
                  ),
                  onChanged: (string) {
                    provider.searchUsers(string);
                  }),
              padding30,
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xffF1F1F1),
                          width: 1,
                        )),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: UserTable(),
                    ),
                  ),
                ),
              ),
              padding20,
              if (provider.searchController.text.isEmpty)
                PaginationWidget(
                  currentPage: provider.currentPage,
                  lastPage: provider.pagination == null
                      ? 1
                      : provider.pagination!.lastPage ?? 1,
                  onPageSelected: (int selectedPage) {
                    // fetch data for selectedPage
                    print("Go to page $selectedPage");
                    provider.getAllUsers(selectedPage);
                  },
                ),
              padding20,
            ],
          ),
        );
      },
    );
  }
}

class UserTable extends StatelessWidget {
  UserTable({
    Key? key,
  }) : super(key: key);

  late UsersProvider usersProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, provider, child) {
        usersProvider = provider;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: provider.allUsersList == null || provider.searchLoading
              ? [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.users.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xffF1F1F1),
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final user = provider.users[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: shimmerUserTile(user, provider, index, context),
                      );
                    },
                  ),
                ]
              : [
                  // Header Row

                  provider.searchController.text.isNotEmpty &&
                          (provider.filterUsersList == null ||
                              provider.filterUsersList!.isEmpty)
                      ? Center(
                          child: Text(
                            "No users found!!!",
                            style: getBoldStyle(
                                color: AppColors.textColor, fontSize: 22),
                          ),
                        )
                      : provider.searchController.text.isEmpty &&
                              (provider.allUsersList == null ||
                                  provider.allUsersList!.isEmpty)
                          ? Center(
                              child: Text(
                                "No users found!!!",
                                style: getBoldStyle(
                                    color: AppColors.textColor, fontSize: 22),
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "User's Name",
                                    style: getMediumStyle(
                                        color: const Color(0xffABABAB),
                                        fontSize: 14),
                                  ),
                                ),
                                padding15,
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Contact Information",
                                    style: getMediumStyle(
                                        color: const Color(0xffABABAB),
                                        fontSize: 14),
                                  ),
                                ),
                                padding15,
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Status",
                                      style: getMediumStyle(
                                          color: const Color(0xffABABAB),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                padding15,
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Info",
                                      style: getMediumStyle(
                                          color: const Color(0xffABABAB),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  padding3,

                  const Divider(
                    color: Color(0xffF1F1F1),
                    thickness: 1,
                  ),
                  // Custom divider

                  padding3,

                  //Shimmer User List

                  if (provider.searchController.text.isNotEmpty)
                    if (provider.searchLoading) ...[
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.users.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Color(0xffF1F1F1),
                          thickness: 1,
                        ),
                        itemBuilder: (context, index) {
                          final user = provider.users[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 6),
                            child:
                                shimmerUserTile(user, provider, index, context),
                          );
                        },
                      ),
                    ] else ...[
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.filterUsersList!.length,
                        separatorBuilder: (context, index) {
                          UserModel user = provider.filterUsersList![index];
                          return Divider(
                            color: Color(0xffF1F1F1),
                            thickness: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          UserModel user = provider.allUsersList![index];
                          return Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: UserListTile(
                              userModel: user,
                            ),
                          );
                        },
                      ),
                    ]
                  else ...[
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.allUsersList!.length,
                      separatorBuilder: (context, index) {
                        UserModel user = provider.allUsersList![index];
                        return Divider(
                          color: Color(0xffF1F1F1),
                          thickness: 1,
                        );
                      },
                      itemBuilder: (context, index) {
                        UserModel user = provider.allUsersList![index];
                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: UserListTile(
                            userModel: user,
                          ),
                        );
                      },
                    ),
                  ],
                ],
        );
      },
    );
  }
}
