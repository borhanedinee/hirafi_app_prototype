import 'package:flutter/material.dart';
import 'package:hirafi/core/themes/app_colors.dart';
import 'package:hirafi/presentation/screens/home_sub_screens/profiles_screen.dart';
import 'package:hirafi/core/dummy_data.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({
    super.key,
    required this.clickedCategory,
    required this.index,
  });

  final int index;
  final String clickedCategory;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  bool isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    // Simulate a data fetch (e.g., from an API)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Set loading to false after data is "fetched"
      });
    });
  }

  // Function to get the list of services by key index
  List<String>? getServicesByKeyIndex(int index) {
    // Convert keys to a list
    List<String> keys = artisanServices.keys.toList();

    // Check if index is valid
    if (index >= 0 && index < keys.length) {
      String key = keys[index]; // Get the key at the specified index
      return artisanServices[key]; // Return the corresponding list
    } else {
      print(
          "Error: Index $index is out of range. Valid range: 0 to ${keys.length - 1}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert map values to a list and access by index
    var entries = artisanServices.entries.toList();

    List<String> subCategories = getServicesByKeyIndex(widget.index) ?? [];
    String category = entries[widget.index].key;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withValues(alpha: .96),
        appBar: AppBar(
          title: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: isLoading
            ? _buildShimmer()
            : _buildContent(subCategories, category),
      ),
    );
  }

  // Actual content when data is loaded
  Widget _buildContent(List<String> subCategories, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: ListView.builder(
        itemCount: subCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(height: 20); // Add space at the top
          }

          if (index <= subCategories.length) {
            final subCategory = subCategories[index - 1];
            return _buildSubCategoryTile(
              context,
              title: subCategory,
              profileCount: 8,
              onTap: () {
                // Handle subcategory tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilesScreen(
                      clickedSubCategory: category,
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink(); // Empty space for the last item
          }
        },
      ),
    );
  }

  // Shimmer effect while loading
  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: ListView.builder(
        itemCount: 4, // Show 3 shimmer placeholders + 1 for top spacing
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(height: 20); // Add space at the top
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                title: Container(
                  height: 16,
                  width: 100,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 14,
                  width: 60,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 5),
                ),
                trailing: Container(
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Mock data for subcategories based on the clicked category
  List<Map<String, dynamic>> _getSubCategories(String category) {
    // This is a mock implementation; replace with actual data from your backend
    switch (category.toLowerCase()) {
      case 'plumbing':
        return [
          {'title': 'Pipe Repair', 'profileCount': 12},
          {'title': 'Drain Cleaning', 'profileCount': 8},
          {'title': 'Water Heater Installation', 'profileCount': 5},
        ];
      case 'electrical':
        return [
          {'title': 'Wiring', 'profileCount': 15},
          {'title': 'Lighting Installation', 'profileCount': 10},
          {'title': 'Circuit Breaker Repair', 'profileCount': 7},
        ];
      case 'carpentry':
        return [
          {'title': 'Furniture Making', 'profileCount': 9},
          {'title': 'Door Installation', 'profileCount': 6},
          {'title': 'Wood Finishing', 'profileCount': 4},
        ];
      default:
        return [
          {'title': 'General', 'profileCount': 20},
        ];
    }
  }

  Widget _buildSubCategoryTile(
    BuildContext context, {
    required String title,
    required int profileCount,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
        ),
        subtitle: Text(
          '$profileCount Profiles',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.greyColor,
                fontSize: 14,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primaryColor, // Orange primary color
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}
