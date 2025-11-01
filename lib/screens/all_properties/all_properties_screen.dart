import 'package:chotu_admin/screens/all_properties/widgets/property_card.dart';
import 'package:flutter/cupertino.dart';

class AllPropertiesScreen extends StatelessWidget {
  const AllPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(
          30,
        ),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
            buildPropertyCard(context),
          ],
        ),
      ),
    );
  }
}
