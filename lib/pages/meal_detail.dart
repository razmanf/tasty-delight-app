import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  final String mealName;
  final double price;
  final String imagePath;

  const MealDetailPage({
    super.key,
    required this.mealName,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mealName)),
      body: Column(
        children: [
          Image.network(imagePath, height: 300, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mealName, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text('\$$price', style: const TextStyle(fontSize: 24, color: Colors.green)),
                const SizedBox(height: 16),
                const Text('Meal Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore.'),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}