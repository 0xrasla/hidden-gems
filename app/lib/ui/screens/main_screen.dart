import 'package:app/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/ph.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const filters = [
    'All',
    "Nature",
    "Beach",
    "Malls",
    "Water",
    "Food",
    "Nightlife",
    "Turfs"
  ];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Iconify(AkarIcons.bell),
              onPressed: () {},
            ),
            IconButton(
              icon: const Iconify(Ph.user_circle_bold),
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
            )
          ],
          automaticallyImplyLeading: false,
          title: const Text('Welcome Back !',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(color: Colors.black),
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      label: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedFilter == filter
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      selected: selectedFilter == filter,
                      showCheckmark: false,
                      elevation: 5,
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = filter;
                        });
                        // Implement your filtering logic here
                      },
                      backgroundColor: Colors.black,
                      selectedColor: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: height * 0.2,
                      width: double.infinity,
                      child: const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/f0e3/b1b9/b1285a61abdb2cfb8802f18f22136fbe?Expires=1719792000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kTGHKYddw5Cwkjb41XJrzflu-F-tP2d~MZ0uBjQ~VllvuXVz~MZEk7Mk4zkEk9Q1UGji73wTSLSBNIVAC-i7l5wYtmlQDTSyXyD5DAbaGMKnBvhu3C7OV1DmGSibikU-qq6MAXpa6XU01syUfBUtLkKxB7A~P8RskXcEjLbTGF40kpZDENfTZS1pPJllD4HT3nEThFyMrGvqufPigBi5Kp4JAFqvgH6FFmLaJ9e6bn8tEg6uwD3uVo2EGgTogmdab6a9OybvnJoQ~YvgGK6gjiOipV004Of~ogvz4-KzGQGgiamoaXrso7~Lz3nOcH2kVA4605j-FOphPJC8cSxftg__")),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: height * 0.2,
                      width: double.infinity,
                      child: const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/f0e3/b1b9/b1285a61abdb2cfb8802f18f22136fbe?Expires=1719792000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kTGHKYddw5Cwkjb41XJrzflu-F-tP2d~MZ0uBjQ~VllvuXVz~MZEk7Mk4zkEk9Q1UGji73wTSLSBNIVAC-i7l5wYtmlQDTSyXyD5DAbaGMKnBvhu3C7OV1DmGSibikU-qq6MAXpa6XU01syUfBUtLkKxB7A~P8RskXcEjLbTGF40kpZDENfTZS1pPJllD4HT3nEThFyMrGvqufPigBi5Kp4JAFqvgH6FFmLaJ9e6bn8tEg6uwD3uVo2EGgTogmdab6a9OybvnJoQ~YvgGK6gjiOipV004Of~ogvz4-KzGQGgiamoaXrso7~Lz3nOcH2kVA4605j-FOphPJC8cSxftg__")),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: height * 0.2,
                      width: double.infinity,
                      child: const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/f0e3/b1b9/b1285a61abdb2cfb8802f18f22136fbe?Expires=1719792000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kTGHKYddw5Cwkjb41XJrzflu-F-tP2d~MZ0uBjQ~VllvuXVz~MZEk7Mk4zkEk9Q1UGji73wTSLSBNIVAC-i7l5wYtmlQDTSyXyD5DAbaGMKnBvhu3C7OV1DmGSibikU-qq6MAXpa6XU01syUfBUtLkKxB7A~P8RskXcEjLbTGF40kpZDENfTZS1pPJllD4HT3nEThFyMrGvqufPigBi5Kp4JAFqvgH6FFmLaJ9e6bn8tEg6uwD3uVo2EGgTogmdab6a9OybvnJoQ~YvgGK6gjiOipV004Of~ogvz4-KzGQGgiamoaXrso7~Lz3nOcH2kVA4605j-FOphPJC8cSxftg__")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
