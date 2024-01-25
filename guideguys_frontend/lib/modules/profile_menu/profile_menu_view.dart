import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_view.dart';
import 'package:guideguys/modules/travel_history/travel_history_view.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ProfileMenuView extends StatefulWidget {
  const ProfileMenuView({super.key});

  @override
  State<ProfileMenuView> createState() => _ProfileMenuViewState();
}

class _ProfileMenuViewState extends State<ProfileMenuView> {

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        // appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              profileInfo(width),
              const SeperateLine(),
              profileMenuCardList(
                width: width,
                cardIcon: Icons.person,
                cardTitle: 'Edit Profile',
                onPressed: () {},
              ),
              const SeperateLine(),
              profileMenuCardList(
                width: width,
                cardIcon: Icons.settings,
                cardTitle: 'Settings',
                onPressed: () {},
              ),
              const SeperateLine(),
              profileMenuCardList(
                width: width,
                cardIcon: Icons.work,
                cardTitle: 'Work History',
                onPressed: () {},
              ),
              const SeperateLine(),
              profileMenuCardList(
                width: width,
                cardIcon: Icons.tour_outlined,
                cardTitle: 'My Tour',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MyTourListView(),
                    ),
                  );
                },
              ),
              const SeperateLine(),
              profileMenuCardList(
                width: width,
                cardIcon: Icons.history,
                cardTitle: 'Travel History',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const TravelHistoryView(),
                    ),
                  );
                },
              ),
              const SeperateLine(),
              profileMenuCardList(
                  width: width,
                  cardIcon: Icons.logout,
                  cardTitle: 'Logout',
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector profileMenuCardList({
    required double width,
    required IconData cardIcon,
    required String cardTitle,
    required Function() onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              cardIcon,
              color: grey700,
              size: width * 0.09,
            ),
            const SizedBox(width: 10),
            Text(
              cardTitle,
              style: TextStyle(
                color: grey700,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container profileInfo(double width) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width * 0.07,
            backgroundImage:
                const AssetImage('assets/images/blank-profile-picture.png'),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olivia Rhye',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: grey700,
                  fontSize: width * 0.05,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'olivia@gmail.com',
                style: TextStyle(
                  color: grey500,
                  fontSize: width * 0.04,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
