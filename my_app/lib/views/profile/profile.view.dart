import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  final String avatarUrl;
  final String email;
  final String name;
  final int phone;

  ProfileView(
      {super.key,
      required this.avatarUrl,
      required this.email,
      required this.name,
      required this.phone}) {
    print('avatarUrl: $avatarUrl');
  }

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.avatarUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 10),
              Text(
                widget.name,
                style: GoogleFonts.nunito(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                widget.email,
                style: GoogleFonts.nunito(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                widget.phone.toString(),
                style: GoogleFonts.nunito(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
