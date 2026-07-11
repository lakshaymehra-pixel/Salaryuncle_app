import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/page_routes.dart';

class RouteButtons extends StatelessWidget {
  const RouteButtons({super.key});

  @override
  Widget build(BuildContext context) {
    List<GetPage> routes = GetPages().routes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Navigator'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          String routeName = routes[index].name.toString();
          // String routePath = routes[routeName]!;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                if (routeName == "/doc") {
                  Get.toNamed(routeName, arguments: [true]);
                } else {
                  Get.toNamed(routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                routeName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
