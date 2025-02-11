import 'package:chotu_admin/models/rider.dart';
import 'package:chotu_admin/screens/riders/components/add_rider_form.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../category/components/add_category_form.dart';
import '../provider/rider_provider.dart';


class RiderListSection extends StatelessWidget {
  const RiderListSection({
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
            "All Riders",
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
                    DataColumn(
                      label: Text("Profile Image"),
                    ),
                    DataColumn(
                      label: Text("RiderName"),
                    ),
                    DataColumn(
                      label: Text("Phone No"),
                    ),
                    DataColumn(
                      label: Text("location"),
                    ),
                    DataColumn(
                      label: Text("Complete Order"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.riders.length,
                        (index) => riderDataRow(
                      dataProvider.riders[index] as Rider ,
                      edit: () {
                        showAddRiderForm(context, dataProvider.riders[index] as Rider?);
                      },
                      delete: () {
                        //TODO: should complete call deleteSubCategory
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


void _showAddRiderDialog(BuildContext context) {
    final riderProvider = Provider.of<RiderProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Register Rider"),
          content: Form(
            key: riderProvider.riderFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(controller: riderProvider.nameCtrl, decoration: InputDecoration(labelText: "Name")),
                TextFormField(controller: riderProvider.phoneCtrl, decoration: InputDecoration(labelText: "Phone")),
                TextFormField(controller: riderProvider.emailCtrl, decoration: InputDecoration(labelText: "Email")),
                SwitchListTile(
                  title: Text("Available"),
                  value: riderProvider.isAvailable,
                  onChanged: (val) => riderProvider.isAvailable = val,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                riderProvider.registerRider();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

DataRow riderDataRow(Rider RiderInfo,{Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(RiderInfo.id ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(RiderInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(RiderInfo.profileImage ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(RiderInfo.phone ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(RiderInfo.location ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child:Text(RiderInfo.completedOrders.toString() ?? ''),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child:Text(RiderInfo.rating.toString() ?? ''),
            ),
          ],
        ),
      ),

      // DataCell(Text(ShopInfo.createdAt ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}

