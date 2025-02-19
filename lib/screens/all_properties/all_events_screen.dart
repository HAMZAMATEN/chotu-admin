import 'package:flutter/cupertino.dart';
import 'package:chotu_admin/screens/all_properties/widgets/event_card.dart';
import 'package:chotu_admin/screens/all_properties/widgets/property_card.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

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
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
            buildEventCard(context),
          ],
        ),
      ),
    );
  }
}
