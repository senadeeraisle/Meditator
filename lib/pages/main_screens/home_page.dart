import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meditator/providers/filter_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<FilterProvider>(
            context,
            listen: false,
          ).getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            }
            return Consumer<FilterProvider>(
              builder:
                  (
                    BuildContext context,
                    FilterProvider filetrdata,
                    Widget? child,
                  ) {
                    final completedData = filetrdata.filteredData;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/images/meditation_app_logo.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Meditator',
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kPrimaryBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Select a category to start exploring!",
                              style: AppTextStyle.subTitleStyle.copyWith(
                                color: AppColors.kPrimaryDeepDarkBlue,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryBlue.withValues(
                                  alpha: 0.6,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      FilterChip(
                                        label: Text("All"),
                                        onSelected: (value) {},
                                      ),
                                      SizedBox(width: 10),
                                      FilterChip(
                                        label: Text("Meditaion"),
                                        onSelected: (value) {},
                                      ),
                                      SizedBox(width: 10),
                                      FilterChip(
                                        label: Text("Midfulness"),
                                        onSelected: (value) {},
                                      ),
                                      SizedBox(width: 10),
                                      FilterChip(
                                        label: Text("Sleep Stories"),
                                        onSelected: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            if (completedData.isNotEmpty)
                              StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: completedData.map((data) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.kPrimaryBlue,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
            );
          },
        ),
      ),
    );
  }
}
