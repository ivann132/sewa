import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/product.dart';

class Searchcontroller extends GetxController {
  var recentSearches = <String>[].obs;
  var searchResults = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }
  Future<void> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.value = prefs.getStringList('recent_searches') ?? [];
  }

  Future<void> addSearchTerm(String searchTerm) async {
    if (searchTerm.isNotEmpty) {
      recentSearches.remove(searchTerm); // Remove if it already exists
      recentSearches.insert(0, searchTerm); // Insert at the top

      // Limit to 5 recent searches
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recent_searches', recentSearches);
    }
  }

  Future<void> clearRecentSearches() async {
    recentSearches.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
  }

  Future<void> searchInFirestore(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    // Example Firestore query to find items matching the search term
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection('product') // Replace with your Firestore collection name
        .where('namaproduct', isGreaterThanOrEqualTo: query)
        .where('namaproduct', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    // Extract data from the snapshot
    searchResults.value = snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
  }
}