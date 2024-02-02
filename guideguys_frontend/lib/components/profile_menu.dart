import 'package:flutter/material.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/home/home_view.dart';
import 'package:guideguys/modules/login/login_view.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_view.dart';
import 'package:guideguys/modules/travel_history/travel_history_view.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.width,
    super.key,
  });

  final double width;

  Future<List<String>> getUsername() async {
    String username = await SecureStorage().readSecureData('myUsername');
    String email = await SecureStorage().readSecureData('myEmail');
    return [username, email];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String myUsername = snapshot.data![0];
            String myEmail = snapshot.data![1];
            return Drawer(
              backgroundColor: bgColor,
              width: width * 0.75,
              child: Column(
                children: [
                  profileInfo(width, myUsername, myEmail),
                  const SeperateLine(),
                  // profileMenuCardList(
                  //   width: width,
                  //   cardIcon: Icons.person,
                  //   cardTitle: 'Edit Profile',
                  //   onPressed: () {},
                  // ),
                  // const SeperateLine(),
                  // profileMenuCardList(
                  //   width: width,
                  //   cardIcon: Icons.settings,
                  //   cardTitle: 'Settings',
                  //   onPressed: () {},
                  // ),
                  // const SeperateLine(),
                  // profileMenuCardList(
                  //   width: width,
                  //   cardIcon: Icons.work,
                  //   cardTitle: 'Work History',
                  //   onPressed: () {},
                  // ),
                  const SeperateLine(),
                  profileMenuCardList(
                    width: width,
                    cardIcon: Icons.tour_outlined,
                    cardTitle: 'My Tour',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyTourListView(),
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
                      onPressed: () {
                        SecureStorage().deleteAllData();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (Route route) => false,
                        );
                      }),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
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

  Container profileInfo(double width, String myUsername, String myEmail) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myUsername,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: grey700,
                  fontSize: width * 0.05,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                myEmail,
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
