import 'package:chop_ya/src/common_widgets/assistants/request_assistant.dart';
import 'package:chop_ya/src/common_widgets/map_key.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/features/core/models/predicted_places.dart';
import 'package:chop_ya/src/features/core/screens/driver/map/place_prediction_tile.dart';
import 'package:flutter/material.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  List<PredictedPlaces> placePredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 1) {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapkey&components=country:CM";

      var responseAutoCompleteSearch =
          await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if (responseAutoCompleteSearch == "Error Occurred, Failed. No Response") {
        return;
      }
      if (responseAutoCompleteSearch["status"] == "OK") {
        var placePredictions = responseAutoCompleteSearch["predictions"];
        var placePredictionList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();
        
        setState(() {
          placePredictedList = placePredictionList;
        });
        // print("Places List: $placePredictionList");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // search place ui
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.white54,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Set Technical Assistance Location",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.adjust_sharp,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                                onChanged: (valueTyped) {
                                  findPlaceAutoCompleteSearch(valueTyped);
                                },
                                decoration: const InputDecoration(
                                  hintText: "Search here",
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11, top: 8, bottom: 8),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //  list of predictions
            
            (placePredictedList.length > 0)
                ? Expanded(
                    child: ListView.separated(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return PlacePredictionTileDesign(
                            predictedPlaces: placePredictedList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                        itemCount: placePredictedList.length),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
