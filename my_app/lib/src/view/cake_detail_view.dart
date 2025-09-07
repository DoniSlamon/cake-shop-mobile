import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/src/models/cake_model.dart';

class CakeDetailPage extends StatefulWidget {
  final int id;

  const CakeDetailPage({super.key, required this.id});

  @override
  _CakeDetailPageState createState() => _CakeDetailPageState();
}

class _CakeDetailPageState extends State<CakeDetailPage> with SingleTickerProviderStateMixin {
  late Future<Cake> cake;
  late Future<List<Review>> reviews;
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  double _userRating = 5.0;

  @override
  void initState() {
    super.initState();
    cake = fetchCakeById(widget.id);
    reviews = fetchReviewsByCakeId(widget.id);
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<Cake> fetchCakeById(int id) async {
    final response = await http.get(Uri.parse('http://localhost:3000/cake/get/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Cake.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load cake: ${response.reasonPhrase}');
    }
  }

  Future<List<Review>> fetchReviewsByCakeId(int cakeId) async {
    final response = await http.get(Uri.parse('http://localhost:3000/reviews/get/$cakeId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Review.fromJson(data)).toList();
    } else {
      // Return empty list if reviews not found
      return [];
    }
  }

  Future<void> deleteReview(int reviewId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/reviews/delete/$reviewId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        reviews = fetchReviewsByCakeId(widget.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Review deleted'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to delete review'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> updateCakeRating(double rating) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/cake/rating/${widget.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'rating': rating,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        cake = fetchCakeById(widget.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cake Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.cake), text: 'Details'),
            Tab(icon: Icon(Icons.comment), text: 'Reviews'),
          ],
        ),
      ),
      body: FutureBuilder<Cake>(
        future: cake,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading delicious details...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load cake details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        cake = fetchCakeById(widget.id);
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Cake not found'));
          } else {
            final cakeData = snapshot.data!;
            final imageUrl = 'http://localhost:3000/${cakeData.imagePath}';

            return TabBarView(
              controller: _tabController,
              children: [
                _buildDetailsTab(cakeData, imageUrl),
                _buildReviewsTab(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailsTab(Cake cake, String imageUrl) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          cake.isAvailable ? Icons.check_circle : Icons.cancel,
                          color: cake.isAvailable ? Colors.green : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          cake.isAvailable ? 'Available' : 'Sold Out',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cake.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${cake.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Section
                if (cake.rating > 0) ...[
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < cake.rating.floor()
                              ? Icons.star
                              : index < cake.rating
                                  ? Icons.star_half
                                  : Icons.star_outline,
                          color: Colors.amber[600],
                          size: 24,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        cake.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],

                // Basic Info Cards
                _buildInfoCard('Category', cake.category, Icons.category),
                _buildInfoCard('Flavor', cake.flavor, Icons.local_dining),
                _buildInfoCard('Size', cake.size, Icons.straighten),
                _buildInfoCard('Weight', '${cake.weight}g', Icons.monitor_weight),

                const SizedBox(height: 20),

                // Description
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        cake.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Order Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: cake.isAvailable ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${cake.name} to cart! 🛒'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } : null,
                    icon: Icon(cake.isAvailable ? Icons.shopping_cart : Icons.cancel),
                    label: Text(
                      cake.isAvailable ? 'Add to Cart' : 'Sold Out',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cake.isAvailable 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: reviews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load reviews: ${snapshot.error}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: snapshot.hasData && snapshot.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final review = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                title: Text(review.username ?? 'Anonymous'),
                                subtitle: Text(review.comment),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    deleteReview(review.id);
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.rate_review,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No reviews yet',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Be the first to review this cake!',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                ),
                _buildReviewForm(context),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildReviewForm(BuildContext context) {
    Future<void> submitReview() async {
      if (_formKey.currentState!.validate()) {
        final response = await http.post(
          Uri.parse('http://localhost:3000/reviews/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user_id': 1,
            'cake_id': widget.id,
            'comment': _commentController.text,
            'rating': _userRating,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review submitted! 🎉'),
              backgroundColor: Colors.green,
            ),
          );
          _commentController.clear();
          setState(() {
            reviews = fetchReviewsByCakeId(widget.id);
          });
          // Update cake rating
          updateCakeRating(_userRating);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to submit review'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Leave a Review',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            // Rating Slider
            Text('Your Rating: ${_userRating.toStringAsFixed(1)} ⭐'),
            Slider(
              value: _userRating,
              min: 1.0,
              max: 5.0,
              divisions: 8,
              label: _userRating.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _userRating = value;
                });
              },
            ),
            const SizedBox(height: 8),
            
            TextFormField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Share your experience...',
                hintText: 'How was this cake? Tell us what you think!',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a review';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: submitReview,
                icon: const Icon(Icons.send),
                label: const Text('Submit Review'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}

class Review {
  final int id;
  final String? username;
  final String comment;
  final double? rating;

  Review({required this.id, required this.username, required this.comment, this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      username: json['username'],
      comment: json['comment'],
      rating: json['rating']?.toDouble(),
    );
  }
}
