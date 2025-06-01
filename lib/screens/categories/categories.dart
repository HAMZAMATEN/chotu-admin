import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/providers/categories_provider.dart';
import 'package:chotu_admin/screens/categories/widgets/add_new_category_alert.dart';
import 'package:chotu_admin/screens/categories/widgets/category_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/functions.dart';
import '../../widgets/custom_TextField.dart';
import '../../widgets/pagination_widget.dart';
import '../users/widgets/user_tile_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getAllCategories(1);
  }

  late CategoriesProvider provider;

  Widget build(BuildContext context) {
    provider = Provider.of<CategoriesProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                    width: MediaQuery.of(context).size.width,
                    title: '',
                    controller: provider.searchController,
                    obscureText: false,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    hintText: 'Search Categories by name',
                    suffixIcon: SizedBox(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: SvgPicture.asset(Assets.iconsSearchnormal1),
                      ),
                    ),
                    onChanged: (string) {
                      provider.searchCategories(string);
                    }),
              ),
              padding12,
              InkWell(
                onTap: () {
                  showAddCategoryDialog(context: context, provider: provider);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      'Add New Category',
                      style: getSemiBoldStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: CategoriesTable(),
                ),
              ),
            ),
          ),
          padding20,
        ],
      ),
    );
  }
}

class CategoriesTable extends StatelessWidget {
  CategoriesTable({
    Key? key,
  }) : super(key: key);

  late CategoriesProvider categoriesProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        categoriesProvider = provider;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Index",
                    style: getMediumStyle(
                        color: const Color(0xffABABAB), fontSize: 14),
                  ),
                ),
                padding15,
                Expanded(
                  flex: 2,
                  child: Text(
                    "Name",
                    style: getMediumStyle(
                        color: const Color(0xffABABAB), fontSize: 14),
                  ),
                ),
                padding15,
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Status",
                      style: getMediumStyle(
                          color: const Color(0xffABABAB), fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Action",
                      style: getMediumStyle(
                          color: const Color(0xffABABAB), fontSize: 14),
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
                  itemCount: provider.categories.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xffF1F1F1),
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: shimmerCategoryTile(
                          category, provider, index, context),
                    );
                  },
                ),
              ] else ...[
                provider.filterCategoriesList!.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "No categories found!!!",
                              style: getBoldStyle(
                                  color: AppColors.textColor, fontSize: 22),
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.filterCategoriesList!.length,
                        separatorBuilder: (context, index) {
                          CategoryModel category =
                              provider.filterCategoriesList![index];
                          return Divider(
                            color: Color(0xffF1F1F1),
                            thickness: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          CategoryModel category =
                              provider.filterCategoriesList![index];

                          return Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: CategoryListTile(
                              categoryModel: category,
                            ),
                          );
                        },
                      ),
              ]
            else if (provider.allCategoriesList == null) ...[
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.categories.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xffF1F1F1),
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  final category = provider.categories[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 6),
                    child:
                        shimmerCategoryTile(category, provider, index, context),
                  );
                },
              ),
            ] else ...[
              provider.allCategoriesList!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "No categories found!!!",
                            style: getBoldStyle(
                                color: AppColors.textColor, fontSize: 22),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.allCategoriesList!.length,
                      separatorBuilder: (context, index) {
                        CategoryModel category =
                            provider.allCategoriesList![index];
                        return Divider(
                          color: Color(0xffF1F1F1),
                          thickness: 1,
                        );
                      },
                      itemBuilder: (context, index) {
                        CategoryModel category =
                            provider.allCategoriesList![index];

                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: CategoryListTile(
                            categoryModel: category,
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
