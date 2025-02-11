// import 'package:chotu_admin/models/shop.dart';
// import 'package:chotu_admin/screens/dashboard/components/add_product_form.dart';
//
// import '../../../core/data/data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../models/product.dart';
// import '../../../utility/constants.dart';
// import 'add_shop_form.dart';
//
//
// class ShopListSection extends StatelessWidget {
//   const ShopListSection({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "All Shops",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Consumer<DataProvider>(
//               builder: (context, dataProvider, child) {
//                 return DataTable(
//                   columnSpacing: defaultPadding,
//                   // minWidth: 600,
//                   columns: [
//                     DataColumn(
//                       label: Text("image"),
//                     ),
//                     DataColumn(
//                       label: Text("Shop Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Description"),
//                     ),
//                     DataColumn(
//                       label: Text("Address"),
//                     ),
//                     DataColumn(
//                       label: Text("Status"),
//                     ),
//                     DataColumn(
//                       label: Text("Add product"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.shops.length,
//                         (index) => shopDataRow(dataProvider.shops[index], delete: () {
//                     }, edit: () {
//                       showAddShopForm(context, dataProvider.shops[index] as Shop?);
//                     }),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// DataRow shopDataRow(Shop ShopInfo,{Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(ShopInfo.image ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(ShopInfo.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(ShopInfo.description ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(ShopInfo.address ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child:Text(ShopInfo.isActive?.toString() ?? ''),
//             ),
//           ],
//         ),
//       ),
//             DataCell(IconButton(
//               onPressed: () {
//                 ProductSubmitForm;
//               },
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             )),
//
//      // DataCell(Text(ShopInfo.createdAt ?? '')),
//       DataCell(IconButton(
//           onPressed: () {
//             if (edit != null) edit();
//           },
//           icon: Icon(
//             Icons.edit,
//             color: Colors.white,
//           ))),
//       DataCell(IconButton(
//           onPressed: () {
//             if (delete != null) delete();
//           },
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//           ))),
//     ],
//   );
// }
import 'package:chotu_admin/models/shop.dart';
import 'package:chotu_admin/screens/dashboard/components/add_product_form.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../utility/constants.dart';
import 'add_shop_form.dart';


class ShopListSection extends StatelessWidget {
  const ShopListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Shops",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(label:Text("Image")),
                    DataColumn(label: Text("Shop Name")),
                    DataColumn(label:Text("Description")),
                    DataColumn(label: Text("Location")),
                    DataColumn(label:Text("Products")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Actions")),
                    ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("Image")),
                      DataCell(Text("Tech Store")),
                      DataCell(Text("Dev")),
                      DataCell(Text("New York, USA")),
                      DataCell(Text(" 59 ")),

                      DataCell(Icon(Icons.check_circle, color: Colors.green)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showAddProductForm(context, null);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {},
                          ),
                          IconButton(icon: Icon(Icons.delete),
                              onPressed: () {}),
                        ],
                      )),
                    ]),
                  ],
                );
              }
            ),
          ),
          ],
        ),
      );

  }
}
