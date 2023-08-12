import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: Text(
            tAppName,
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage(tUserProfileImage),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADINGS
                Text(tDashboardTitle, style: TextTheme.bodyText2),
                Text(tDashboardHeading, style: TextTheme.headline2),
                const SizedBox(
                  height: tDashboardPadding,
                ),
                // SEARCH BAR
                Container(
                  decoration: const BoxDecoration(
                      border: Border(left: BorderSide(width: 4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tDashboardSearch,
                          style: TextTheme.headline2?.apply(
                            color: Colors.grey.withOpacity(0.5),
                          )),
                      const Icon(
                        Icons.mic,
                        size: 25,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: tDashboardPadding,
                ),

                // TOP TECHICIANS
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Technicians",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 31, 29, 29)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "TechnicianScreen");
                          },
                          child: const Text(
                            'View More',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                ),

                const SizedBox(
                  height: tDashboardPadding,
                ),

                // CATEGORIES
                SizedBox(
                  height: 100,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 10; i++)
                        SizedBox(
                          width: 260,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF36454f),
                                ),
                                child: const Center(
                                    child:
                                        // Text("JS", style: TextTheme.headline6?.apply(color: Colors.white),
                                        // )
                                        Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: Oga Bomboy ",
                                      style: TextTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Location: Santa Akum",
                                      style: TextTheme.bodyText2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Center(
                                      child: FlutterRating(
                                        rating: 3.5,
                                        size: 20,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: tDashboardPadding,
                ),

                // Banner
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF36454f).withOpacity(0.5),
                  ),
                ),

                const SizedBox(
                  height: tDashboardPadding,
                ),
              ],
            ),
          ),
        ));
  }
}
