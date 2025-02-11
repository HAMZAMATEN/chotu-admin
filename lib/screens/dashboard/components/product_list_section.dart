// import '../../../core/data/data_provider.dart';
// import '../../../models/product.dart';
// import 'add_product_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
//
// class ProductListSection extends StatelessWidget {
//   const ProductListSection({
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
//             "All Products",
//             style: Theme
//                 .of(context)
//                 .textTheme
//                 .titleMedium,
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
//                       label: Text("Product Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Sub Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Price"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.products.length,
//                         (index) => productDataRow(dataProvider.products[index],edit: () {
//                           showAddProductForm(context, dataProvider.products[index]);
//                         },
//                           delete: () {
//                             //TODO: should complete call deleteProduct
//                           },),
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
// DataRow productDataRow(Product productInfo,{Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               productInfo.images?.first.url ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(productInfo.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(productInfo.proCategoryId?.name ?? '')),
//       DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
//       DataCell(Text('${productInfo.price}'),),
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
//
// import '../../../core/data/data_provider.dart';
// import '../../../models/product.dart';
// import 'add_product_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
//
// class ProductListSection extends StatelessWidget {
//   ProductListSection({
//     Key? key,
//   }) : super(key: key);
//   final List<Product> products = [
//     Product(
//       sId: '1',
//       name: 'Product 1',
//       description: 'Description of Product 1',
//       price: 100.0,
//       offerPrice: 80.0,
//       quantity: 10,
//       images: [
//         Images(url: 'assets/images/product.png'),
//         Images(url: 'assets/images/product.png'),
//       ],
//     ),
//     Product(
//       sId: '2',
//       name: 'Product 2',
//       description: 'Description of Product 2',
//       price: 150.0,
//       offerPrice: 120.0,
//       quantity: 5,
//       images: [Images(url: 'assets/images/app_logo.png')],
//     ),
//     Product(
//       sId: '1',
//       name: 'Product 1',
//       description: 'Description of Product 1',
//       price: 100.0,
//       offerPrice: 80.0,
//       quantity: 10,
//       images: [
//         Images(url: 'assets/images/app_logo.png')
//       ],
//     ),
//     Product(
//       sId: '2',
//       name: 'Product 2',
//       description: 'Description of Product 2',
//       price: 150.0,
//       offerPrice: 120.0,
//       quantity: 5,
//       images: [Images(url: 'assets/images/app_logo.png')],
//     ),
//
//   ];
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
//             "All Products",
//             style: Theme
//                 .of(context)
//                 .textTheme
//                 .titleMedium,
//           ),
//
//           SizedBox(
//             width: double.infinity,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal, // Enable horizontal scrolling
//               child: Row(
//                 children: products.map((product) {
//                   return productCard(product);
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget productCard(Product productInfo) {
//     return Card(
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       elevation: 5,
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Check if productInfo.images is not null and display all images horizontally
//             productInfo.images != null && productInfo.images!.isNotEmpty
//                 ? Row(
//               children: productInfo.images!.map((image) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 80, // Set a fixed width for the images
//                     height: 80, // Set a fixed height for the images
//                     child: Image.asset(
//                       image.url ?? '',
//                       fit: BoxFit.cover,
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrace) {
//                         return Icon(Icons.error,
//                             size: 80); // Show error icon if image loading fails
//                       },
//                     ),
//                   ),
//                 );
//               }).toList(),
//             )
//                 : SizedBox.shrink(),
//             // If no images, don't display anything
//
//             SizedBox(height: 10),
//             Text(
//               productInfo.name ?? 'No Name',
//               style: TextStyle(
//                 color: secondaryColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             // Display Product Description
//             Text(
//               productInfo.description ?? 'No Description',
//               style: TextStyle(fontSize: 14, color: secondaryColor),
//             ),
//
//             SizedBox(height: 10),
//
//             // Display Price and Offer Price
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '\$${productInfo.price}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: secondaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   '\$${productInfo.offerPrice}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.red,
//                     decoration: TextDecoration.lineThrough,
//                   ),
//                 ),
//               ],
//             ),
//
//             // Display Product Quantity
//             SizedBox(height: 10),
//             Text(
//               'Quantity: ${productInfo.quantity}',
//               style: TextStyle(color: secondaryColor, fontSize: 14),
//             ),
//
//             // Add Edit and Delete buttons
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//           IconButton(
//           onPressed: () {
//             if (edit != null) edit();
//           },
//           icon: Icon(
//             Icons.edit,
//             color: Colors.white,
//           )),
//       IconButton(
//           onPressed: () {
//             if (delete != null) delete();
//           },
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//           )),
//     ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../utility/constants.dart';

class ProductListSection extends StatelessWidget {
  ProductListSection({Key? key}) : super(key: key);

  final List<Product> products = [
    Product(
      sId: '1',
      name: 'Product 1',
      description: 'Description of Product 1',
      price: 100.0,
      offerPrice: 80.0,
      quantity: 10,
      images: [
        Images(url: 'assets/images/product.png'),
        Images(url: 'assets/images/product.png'),
      ],
    ),
    Product(
      sId: '2',
      name: 'Product 2',
      description: 'Description of Product 2',
      price: 100.0,
      offerPrice: 80.0,
      quantity: 10,
      images: [
        Images(url: 'assets/images/product.png'),
        Images(url: 'assets/images/product.png'),
      ],
    ),
    Product(
      sId: '3',
      name: 'Product 3',
      description: 'Description of Product 3',
      price: 100.0,
      offerPrice: 80.0,
      quantity: 10,
      images: [
        Images(url: 'assets/images/product.png'),
        Images(url: 'assets/images/product.png'),
      ],
    ),
    Product(
      sId: '4',
      name: 'Product 4',
      description: 'Description of Product 4',
      price: 150.0,
      offerPrice: 120.0,
      quantity: 5,
      images: [
        Images(url: 'assets/images/app_logo.png'),
        Images(url: 'assets/images/app_logo.png'),
      ],
    ),
    Product(
      sId: '5',
      name: 'Product 5',
      description: 'Description of Product 5',
      price: 150.0,
      offerPrice: 120.0,
      quantity: 5,
      images: [
        Images(url: 'assets/images/app_logo.png'),
        Images(url: 'assets/images/app_logo.png'),
      ],
    ),
  ];

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
            "All Products",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(label: Text("Product Name")),
        DataColumn(
                      label: Text("Description"),
                    ),
                    DataColumn(
                      label: Text("Price"),
                    ),
                DataColumn(label: Text("Offer Price")),
                DataColumn(label: Text("Quantity")),
                DataColumn(label: Text("Edit")),
                DataColumn(label: Text("Delete")),
              ],
              rows: List.generate(
                products.length,
                    (index) => productDataRow(products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productDataRow(Product productInfo) {
  return DataRow(
    cells: [
      DataCell(Row(
        children: [
          productInfo.images != null && productInfo.images!.isNotEmpty
                ? Row(
              children: productInfo.images!.map((image) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      image.url ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Icon(Icons.error,
                            size: 80); // Show error icon if image loading fails
                      },
                    ),
                  ),
                );
              }).toList(),
            )
                : SizedBox.shrink(),



          // Image.asset(
          //   productInfo.images?.first.url ?? '',
          //   height: 30,
          //   width: 30,
          //   errorBuilder: (context, error, stackTrace) {
          //     return Icon(Icons.error);
          //   },
          // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(productInfo.description??'')),
      DataCell(Text('${productInfo.price} ')),
      DataCell(Text('${productInfo.offerPrice}')),
      DataCell(Text('${productInfo.quantity}')),
      DataCell(Icon(Icons.edit, color: Colors.white)),
      DataCell(Icon(Icons.delete, color: Colors.red)),
        ],

  );
}
