import 'package:flutter/material.dart';
import '../../domain/repositories/i_transport_repository.dart';

class RouteSearchDelegate extends SearchDelegate {
  final ITransportRepository repository;

  RouteSearchDelegate(this.repository);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This could trigger a search for routes matching the 'query'
    return Center(child: Text("Searching for line: $query"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show recent searches as popular lines like "804"
    return const Column(
      children: [
        ListTile(title: Text("804 - VeloRoute Express")),
        ListTile(title: Text("102 - City Centre")),
      ],
    );
  }
}
