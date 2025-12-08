import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SparePartsScreen extends StatefulWidget {
  const SparePartsScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsScreen> createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  List<Map<String, String>> categories = [];
  List<dynamic> spareParts = [];
  List<dynamic> availableCars = [];

  List<String> conditions = ['New', 'Used'];

  String selectedCategory = '';
  String selectedCondition = '';
  String keyword = '';
  String minPrice = '';
  String maxPrice = '';

  bool isLoading = true;
  String? authToken;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  // -----------------------------------------
  // LOAD AUTH TOKEN
  // -----------------------------------------
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('accessToken');
    
    // Fetch data after token is loaded
    fetchCategories();
    fetchSpareParts();
    fetchAvailableCars();
  }

  // -----------------------------------------
  // GET AUTH HEADERS
  // -----------------------------------------
  Map<String, String> _getHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (authToken != null && authToken!.isNotEmpty)
        'Authorization': 'Bearer $authToken',
    };
  }

  // -----------------------------------------
  // FETCH CATEGORIES FROM API
  // -----------------------------------------
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://blackdiamondcar.com/api/spare-parts/categories'),
        headers: _getHeaders(),
      );

      print('Categories Response Status: ${response.statusCode}');
      print('Categories Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        // Handle different possible response structures
        List<dynamic> categoryList = [];
        if (jsonData is Map) {
          // Check for nested data structure: {success: true, data: {data: [...]}}
          if (jsonData['data'] is Map && jsonData['data']['data'] is List) {
            categoryList = jsonData['data']['data'];
          } else if (jsonData['data'] is List) {
            categoryList = jsonData['data'];
          } else {
            categoryList = jsonData['categories'] ?? [];
          }
        } else if (jsonData is List) {
          categoryList = jsonData;
        }

        setState(() {
          categories = List<Map<String, String>>.from(
            categoryList.map((cat) {
              return {
                'name': cat['name']?.toString() ?? cat['category_name']?.toString() ?? '',
                'slug': cat['slug']?.toString() ?? cat['id']?.toString() ?? '',
              };
            }),
          );
        });
        
        print('Loaded ${categories.length} categories');
      }
    } catch (e) {
      print('Category Error: $e');
    }
  }

  // -----------------------------------------
  // FETCH AVAILABLE CARS FROM DATABASE
  // -----------------------------------------
  Future<void> fetchAvailableCars() async {
    try {
      final response = await http.get(
        Uri.parse('https://blackdiamondcar.com/api/cars?lang_code=en'),
        headers: _getHeaders(),
      );

      print('Cars Response Status: ${response.statusCode}');
      print('Cars Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        // Handle different possible response structures
        List<dynamic> carsList = [];
        if (jsonData is Map) {
          carsList = jsonData['cars']?['data'] ?? jsonData['data'] ?? [];
        } else if (jsonData is List) {
          carsList = jsonData;
        }

        setState(() {
          availableCars = carsList.map((car) {
            return {
              'id': car['id']?.toString() ?? '',
              'name': car['name'] ?? car['title'] ?? 'Unknown',
              'brand': car['brand']?['name'] ?? car['brand_name'] ?? '',
              'model': car['car_model'] ?? car['model'] ?? '',
              'year': car['year']?.toString() ?? '',
            };
          }).toList();
        });
        
        print('Loaded ${availableCars.length} cars');
      }
    } catch (e) {
      print('Available Cars Error: $e');
    }
  }

  // -----------------------------------------
  // FETCH SPARE PARTS FROM DATABASE
  // -----------------------------------------
  Future<void> fetchSpareParts() async {
    setState(() => isLoading = true);

    final query = {
      'lang_code': 'en',
      if (keyword.isNotEmpty) 'search': keyword,
      if (selectedCategory.isNotEmpty) 'category': selectedCategory,
      if (selectedCondition.isNotEmpty) 'condition': selectedCondition,
      if (minPrice.isNotEmpty) 'min_price': minPrice,
      if (maxPrice.isNotEmpty) 'max_price': maxPrice,
    };

    final uri = Uri.parse('https://blackdiamondcar.com/api/spare-parts')
        .replace(queryParameters: query);

    try {
      final response = await http.get(uri, headers: _getHeaders());

      print('Spare Parts Response Status: ${response.statusCode}');
      print('Spare Parts Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Handle different possible response structures
        List<dynamic> rawList = [];
        if (jsonData is Map) {
          // Check for nested data structure: {success: true, data: {data: [...]}}
          if (jsonData['data'] is Map && jsonData['data']['data'] is List) {
            rawList = jsonData['data']['data'];
          } else if (jsonData['data'] is List) {
            rawList = jsonData['data'];
          } else {
            rawList = jsonData['spare_parts'] ?? [];
          }
        } else if (jsonData is List) {
          rawList = jsonData;
        }

        setState(() {
          spareParts = rawList.map((part) {
            return {
              'id': part['id']?.toString() ?? '',
              'name': part['name'] ?? part['part_name'] ?? 'Unknown Part',
              'price': part['price']?.toString() ?? '0',
              'condition': part['condition'] ?? 'Unknown',
              'compatible_models': part['compatible_models'] ?? part['compatible_cars'] ?? 'N/A',
              'category_name': part['category']?['name'] ?? part['category_name'] ?? 'Uncategorized',
              'description': part['description'] ?? '',
              'image_url': part['image'] != null && part['image'].toString().isNotEmpty
                  ? (part['image'].toString().startsWith('http')
                      ? part['image']
                      : 'https://blackdiamondcar.com/${part['image']}')
                  : 'https://via.placeholder.com/150',
            };
          }).toList();

          isLoading = false;
        });
        
        print('Loaded ${spareParts.length} spare parts');
      } else {
        print('Failed to load spare parts: ${response.statusCode}');
        setState(() {
          spareParts = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Spare Parts Error: $e');
      setState(() {
        spareParts = [];
        isLoading = false;
      });
    }
  }

  // -----------------------------------------
  // RESET FILTERS
  // -----------------------------------------
  void resetFilters() {
    setState(() {
      keyword = '';
      selectedCategory = '';
      selectedCondition = '';
      minPrice = '';
      maxPrice = '';
    });
    fetchSpareParts();
  }

  // -----------------------------------------
  // UI
  // -----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spare Parts for Sale')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildFilters(),
              const SizedBox(height: 16),
              if (availableCars.isNotEmpty) ...[
                _buildAvailableCarsSection(),
                const SizedBox(height: 24),
              ],
              _buildSparePartsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------
  // AVAILABLE CARS SECTION
  // -----------------------------------------
  Widget _buildAvailableCarsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Cars',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: availableCars.length,
            itemBuilder: (context, index) {
              final car = availableCars[index];
              return Card(
                margin: const EdgeInsets.only(right: 12),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        car['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text('Brand: ${car['brand']}'),
                      Text('Model: ${car['model']}'),
                      Text('Year: ${car['year']}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // -----------------------------------------
  // FILTERS UI
  // -----------------------------------------
  Widget _buildFilters() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Keyword'),
              onChanged: (val) => keyword = val,
            ),
            const SizedBox(height: 8),

            // Category dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory.isEmpty ? null : selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: categories
                  .map((cat) => DropdownMenuItem(
                        value: cat['slug'],
                        child: Text(cat['name']!),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedCategory = val ?? ''),
            ),

            const SizedBox(height: 8),

            // Condition chips
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: selectedCondition.isEmpty,
                  onSelected: (_) => setState(() => selectedCondition = ''),
                ),
                ...conditions.map(
                  (cond) => ChoiceChip(
                    label: Text(cond),
                    selected: selectedCondition == cond,
                    onSelected: (_) => setState(() => selectedCondition = cond),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Min Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => minPrice = val,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Max Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => maxPrice = val,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: fetchSpareParts,
                    child: const Text('Apply Filters'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: resetFilters,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------
  // GRID OF SPARE PARTS
  // -----------------------------------------
  Widget _buildSparePartsGrid() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (spareParts.isEmpty) {
      return const Text("No Spare Parts Found");
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: spareParts.length,
      itemBuilder: (context, index) {
        final part = spareParts[index];

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    part['image_url'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(part['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Price: \$${part['price']}'),
                Text('Condition: ${part['condition']}'),
                Text('Category: ${part['category_name']}'),
                Text('Compatible: ${part['compatible_models']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
