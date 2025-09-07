import 'package:flutter/material.dart';
import 'package:my_app/src/view/monitor_detail_view.dart';

class CardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;
  final int id;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MonitorDetailPage(
                id: id,
              ),
            ),
          );
        },
        child: Container(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(
                      'http://127.0.0.1:3000/${imagePath}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Rp. $price'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
