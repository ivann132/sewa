import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewa/app/modules/home/controllers/home_controller.dart';
import 'package:sewa/app/modules/home/controllers/search_controller.dart';
import 'package:sewa/app/modules/home/views/product_tile.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final searchControllerGetX = Get.put(Searchcontroller());
  final homecontrol = Get.put(HomeController());
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search here...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final searchTerm = searchController.text.trim();
                    if (searchTerm.isNotEmpty) {
                      searchControllerGetX.addSearchTerm(searchTerm);
                      searchControllerGetX.searchInFirestore(searchTerm);
                      searchController.clear();
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                final searchTerm = value.trim();
                if (searchTerm.isNotEmpty) {
                  searchControllerGetX.addSearchTerm(searchTerm);
                  searchControllerGetX.searchInFirestore(searchTerm);
                  searchController.clear();
                }
              },
              onChanged: (value) {
                homecontrol.filterProducts(value); // Filter products based on search
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Recent Searches",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              // Observe the recentSearches list reactively
              if (searchControllerGetX.recentSearches.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("No recent searches"),
                );
              }
              return Wrap(
                spacing: 8.0, // Space between chips
                children: searchControllerGetX.recentSearches.map((term) {
                  return GestureDetector(
                    onTap: () {
                      searchController.text = term;
                      searchControllerGetX.searchInFirestore(term);
                    },
                    child: Chip(
                      label: Text(term),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        searchControllerGetX.recentSearches.remove(term);
                      },
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              "Search Results",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                // Observe search results and update UI
                if (searchControllerGetX.searchResults.isEmpty) {
                  return const Center(child: Text("No results found"));
                }
                return GridView.builder(
                  itemCount: searchControllerGetX.searchResults.length,
                  itemBuilder: (context, index) => ProductTile(product: searchControllerGetX.searchResults[index]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
