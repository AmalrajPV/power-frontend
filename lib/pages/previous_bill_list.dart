import 'package:flutter/material.dart';

class PreviousBillsList extends StatefulWidget {
  const PreviousBillsList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PreviousBillsListState createState() => _PreviousBillsListState();
}

class _PreviousBillsListState extends State<PreviousBillsList> {
  final ScrollController _scrollController = ScrollController();
  late List<String> previousBills;
  late bool isLoading;
  late int page;

  @override
  void initState() {
    super.initState();
    previousBills = [];
    isLoading = false;
    page = 1;

    // Initial data loading
    _loadData();

    // Listen for scroll events
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: previousBills.length * 2 + 1,
      itemBuilder: (context, index) {
          final billIndex = index ~/ 2;

          if (billIndex < previousBills.length) {
            return GestureDetector(
              onTap: () {
                // Handle the click on the ListTile
                print('Clicked on ${previousBills[billIndex]}');
              },
              child: ListTile(
                title: Text(previousBills[billIndex]),
                // Add other details or actions related to each previous bill here
                trailing: Icon(Icons.more_horiz), // Add the more icon
                onTap: () {
                  // Handle the tap on the more icon
                  print('More icon tapped for ${previousBills[billIndex]}');
                  // You can add more actions here
                },
              ),
            );
          } else {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(); // This is an empty container to avoid rendering anything while not loading
            }
          }
      },
      controller: _scrollController,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the bottom, load more data
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));
      List<String> newData =
          List.generate(10, (index) => 'Bill ${index + 1} - Page $page');
      page++;

      setState(() {
        previousBills.addAll(newData);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
