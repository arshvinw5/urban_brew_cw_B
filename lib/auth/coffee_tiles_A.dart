// CoffeeTiles widget
import 'package:flutter/material.dart';
import 'package:urban_brew/models/coffee.dart';

class CoffeeTilesII extends StatelessWidget {
  final Coffee coffee;
  final void Function()? onTap;

  const CoffeeTilesII({
    super.key,
    required this.coffee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      width: 300,
      height: 400, // Fixed height for consistent sizing
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          // Top image section (takes up roughly 60% of the container)
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   height: 240, // 60% of 400
          //   child: ClipRRect(
          //     borderRadius:
          //         const BorderRadius.vertical(top: Radius.circular(12.0)),
          //     child: Image.asset(
          //       coffee.imagePath,
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) => Container(
          //         color: Colors.black54,
          //         child: const Icon(Icons.error, color: Colors.red),
          //       ),
          //     ),
          //   ),
          // ),

          // Bottom content section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 160, // 40% of 400
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    coffee.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Bottom row with name, price, and add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Name and price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              coffee.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'LKR ${coffee.price}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add button
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color(0xffF39E60),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
