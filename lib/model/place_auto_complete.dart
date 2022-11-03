import 'dart:convert';
import 'package:bizhub_new/model/auto_complete_prediction.dart';

class PlaceAutocompleteResponse {
  final String? status;
  final List<AutoCompletePrediction>? prediction;

  PlaceAutocompleteResponse({this.status, this.prediction});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
        status: json['status'] as String?,
        prediction: json['predictions'] != null
            ? (json['predictions'])
                .map<AutoCompletePrediction>(
                    (json) => AutoCompletePrediction.fromJson(json))
                .toList()
            : null);
  }

  static PlaceAutocompleteResponse parseAutoCompleteResult(
      String responseBody) {
    final parsed = jsonDecode(responseBody);

    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}

class PlaceDetail {
  final String placeAddress;
  // final List<AutoCompletePrediction>? prediction;

  PlaceDetail({required this.placeAddress});

  factory PlaceDetail.fromJson(Map<String, dynamic> json) {
    return PlaceDetail(
      placeAddress: json['formatted_address'],
    );
    // prediction: json['predictions'] != null
    //     ? (json['predictions'])
    //         .map<AutoCompletePrediction>(
    //             (json) => AutoCompletePrediction.fromJson(json))
    //         .toList()
    //     : null);
  }

  // static PlaceDetail parseResult(String responseBody) {
  //   final parsed = jsonDecode(responseBody);

  //   return PlaceDetail.fromJson(parsed);
  // }
}
