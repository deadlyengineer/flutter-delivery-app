import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';

class PlacesAutocompleteWidget extends StatefulWidget {
  final String apiKey;
  static String hint = "Search Location";
  final Location location;
  final num offset;
  final num radius;
  final String language;
  final String sessionToken;
  final List<String> types;
  final List<Component> components;
  final bool strictbounds;
  final Mode mode;
  final Widget logo;
  final ValueChanged<PlacesAutocompleteResponse> onError;
  static bool isRegister = false;

  final String proxyBaseUrl;

  final BaseClient httpClient;

  PlacesAutocompleteWidget(
      {this.apiKey,
      this.mode = Mode.fullscreen,
      this.offset,
      this.location,
      this.radius,
      this.language,
      this.sessionToken,
      this.types,
      this.components,
      this.strictbounds,
      this.logo,
      this.onError,
      Key key,
      this.proxyBaseUrl,
      this.httpClient})
      : super(key: key);

  @override
  State<PlacesAutocompleteWidget> createState() {
    if (mode == Mode.fullscreen) {
      return _PlacesAutocompleteScaffoldState();
    }
    return _PlacesAutocompleteOverlayState();
  }

  static PlacesAutocompleteState of(BuildContext context) =>
      context.findAncestorStateOfType<PlacesAutocompleteState>();
}

class _PlacesAutocompleteScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: Navigator.of(context).pop,
      listfooter: widget.logo,
    );
    return Scaffold(appBar: appBar, body: body);
  }
}

class _PlacesAutocompleteOverlayState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = Column(children: <Widget>[
      Material(
          color: theme.dialogBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.0), topRight: Radius.circular(2.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                child: _textField(context),
                padding: const EdgeInsets.only(right: 8.0),
              )),
            ],
          )),
      Divider(
          //height: 1.0,
          )
    ]);

    var body;

    if (PlacesAutocompleteState.searching) {
      body = Stack(
        children: <Widget>[_Loader()],
        alignment: FractionalOffset.bottomCenter,
      );
    } else if (PlacesAutocompleteState.queryTextController.text.isEmpty ||
        PlacesAutocompleteState.response == null ||
        PlacesAutocompleteState.response.predictions.isEmpty) {
      body = Material(
        color: theme.dialogBackgroundColor,
        child: widget.logo ?? PoweredByGoogleImage(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0)),
      );
    } else {
      body = SingleChildScrollView(
        child: Material(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0),
          ),
          child: ListBody(
            children: PlacesAutocompleteState.response.predictions
                .map(
                  (p) => PredictionTile(
                    prediction: p,
                    onTap: Navigator.of(context).pop,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    final container = Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Stack(children: <Widget>[
          header,
          Padding(padding: EdgeInsets.only(top: 48.0), child: body),
        ]));

    if (Platform.isIOS) {
      return Padding(padding: EdgeInsets.only(top: 8.0), child: container);
    }
    return container;
  }

  Widget _textField(BuildContext context) => TextField(
        controller: PlacesAutocompleteState.queryTextController,
        autocorrect: false,
        autofocus: true,
        cursorColor: Colors.black,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black87
                : null,
            fontSize: 16.0),
        decoration: InputDecoration(
          hintText: PlacesAutocompleteWidget.hint,
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[500]
                : null,
            fontSize: 16.0,
          ),
          border: InputBorder.none,
        ),
      );
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 2.0),
        child: LinearProgressIndicator());
  }
}

class PlacesAutocompleteResult extends StatefulWidget {
  final ValueChanged<Prediction> onTap;
  final Widget listfooter;

  PlacesAutocompleteResult({this.onTap, this.listfooter});

  @override
  _PlacesAutocompleteResult createState() => _PlacesAutocompleteResult();
}

class _PlacesAutocompleteResult extends State<PlacesAutocompleteResult> {
  @override
  Widget build(BuildContext context) {
    final state = PlacesAutocompleteWidget.of(context);
    assert(state != null);

    if (PlacesAutocompleteState.queryTextController.text.isEmpty ||
        PlacesAutocompleteState.response == null ||
        PlacesAutocompleteState.response.predictions.isEmpty) {
      final children = <Widget>[
        // Text("Your searched location is not available in places list..")
      ];
      if (PlacesAutocompleteState.searching) {
        // return Container(height: 0.0,);
        print("placecompleteresult");
      }

      return Stack(children: children);
    }
    return PredictionsListView(
      listfooter: widget.listfooter,
      predictions: PlacesAutocompleteState.response.predictions,
      onTap: widget.onTap,
    );
  }
}

class AppBarPlacesAutoCompleteTextField extends StatefulWidget {
  bool avoidUnderline;
  String hintText;
  Function onChange;
  AppBarPlacesAutoCompleteTextField({
    this.avoidUnderline = false,
    this.hintText = "",
    this.onChange,
  });
  @override
  _AppBarPlacesAutoCompleteTextFieldState createState() =>
      _AppBarPlacesAutoCompleteTextFieldState();
}

class _AppBarPlacesAutoCompleteTextFieldState
    extends State<AppBarPlacesAutoCompleteTextField> {
  @override
  void initState() {
    PlacesAutocompleteWidget.hint = widget.hintText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            !widget.avoidUnderline ? Alignment.topLeft : Alignment.topLeft,
        margin: !widget.avoidUnderline
            ? EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0)
            : EdgeInsets.only(left: 10.0, top: 0.0, right: 0.0, bottom: 0.0),
        child: TextField(
          controller: PlacesAutocompleteState.queryTextController,
          autofocus: PlacesAutocompleteState.focus,
          textInputAction: TextInputAction.search,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          cursorColor: Colors.black,
          onChanged: (value) {
            widget.onChange(value);
          },
          decoration: InputDecoration(
            hintText: PlacesAutocompleteWidget.hint,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 15.0,
            ),
            border: !widget.avoidUnderline
                ? new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.black,
                    ),
                  )
                : InputBorder.none,
          ),
        ));
  }
}

class PoweredByGoogleImage extends StatelessWidget {
  final _poweredByGoogleWhite =
      "packages/flutter_google_places/assets/google_white.png";
  final _poweredByGoogleBlack =
      "packages/flutter_google_places/assets/google_black.png";

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? _poweredByGoogleWhite
                : _poweredByGoogleBlack,
            scale: 2.5,
          ))
    ]);
  }
}

class PredictionsListView extends StatelessWidget {
  final List<Prediction> predictions;
  final ValueChanged<Prediction> onTap;
  final bool isRegister;
  final _scrollController = new ScrollController();
  Widget listfooter;

  PredictionsListView(
      {this.predictions, this.listfooter, this.onTap, this.isRegister});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels !=
          _scrollController.position.minScrollExtent) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });
    return PlacesAutocompleteWidget.isRegister
        ? Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 40.0),
            child: ListView(
              children: predictions
                  .map((Prediction p) => Column(
                        children: <Widget>[
                          PredictionTile(prediction: p, onTap: onTap),
                          Divider(
                            height: 5,
                            color: Colors.grey,
                          ),
                        ],
                      ))
                  .toList(),
              controller: _scrollController,
            ),
          )
        : ListView.builder(
            itemCount: predictions.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  PredictionTile(prediction: predictions[index], onTap: onTap),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  // index == predictions.length - 1 ? listfooter : Container(),
                ],
              );
            });
  }
}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onTap;

  PredictionTile({this.prediction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap(prediction);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
              width: 35,
              height: 35,
              child: new Icon(
                Icons.location_on_outlined,
                size: 35,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
                child:

                    /* Text(prediction.description, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: AppDimen.text_size_h1, ),),*/

                    HighlightText(
              text: prediction.description,
              highlight: PlacesAutocompleteState.queryTextController.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
              highlightStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )
                /* Text(prediction.description, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: AppDimen.text_size_h1, ),),*/
                ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final TextStyle highlightStyle;

  const HighlightText({
    Key key,
    this.text,
    this.highlight,
    this.style,
    this.highlightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("highlight text:${highlight}");
    String text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = text.indexOf(highlight, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    } while (true);
    /*do {
      indexOfHighlight = text.indexOf(highlight, start);
      if (!text.toLowerCase().contains(highlight.toLowerCase())) {
        // no highlight
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
      */ /*if (indexOfHighlight == start) {
        // start with highlight.
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else*/ /* {
        // normal + highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    } while (true);*/

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}

enum Mode { overlay, fullscreen }

abstract class PlacesAutocompleteState extends State<PlacesAutocompleteWidget> {
  static TextEditingController queryTextController;
  static bool focus = false;
  static PlacesAutocompleteResponse response;
  GoogleMapsPlaces _places;
  static bool searching;

  final _queryBehavior = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();
    queryTextController = TextEditingController(text: "");

    _places = GoogleMapsPlaces(
        apiKey: widget.apiKey,
        baseUrl: widget.proxyBaseUrl,
        httpClient: widget.httpClient);
    searching = false;

    setListener();

    _queryBehavior.stream
        .debounceTime(const Duration(milliseconds: 300))
        .listen(doSearch);
  }

  Future<Null> doSearch(String value) async {
    print('dosearch value');
    print(value);
    if (mounted && value.isNotEmpty) {
      setState(() {
        searching = true;
      });

      final res = await _places.autocomplete(
        value,
        offset: widget.offset,
        location: widget.location,
        radius: widget.radius,
        language: widget.language,
        sessionToken: widget.sessionToken,
        types: widget.types,
        components: widget.components,
        strictbounds: widget.strictbounds,
      );

      if (res.errorMessage?.isNotEmpty == true ||
          res.status == "REQUEST_DENIED") {
        onResponseError(res);
      } else {
        onResponse(res);
      }
    } else {
      onResponse(null);
    }
  }

  void setListener() {
    queryTextController.addListener(onQueryChange);
  }

  void onQueryChange() {
    print("query change: " + PlacesAutocompleteState.queryTextController.text);

    _queryBehavior.add(queryTextController.text);
  }

  @override
  void dispose() {
    super.dispose();

    _places.dispose();
    _queryBehavior.close();
    queryTextController.removeListener(onQueryChange);
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    if (widget.onError != null) {
      widget.onError(res);
    }

    print(res.errorMessage);

    setState(() {
      response = null;
      searching = false;
    });
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    setState(() {
      response = res;
      searching = false;
    });
  }
}

class PlacesAutocomplete {
  static Future<Prediction> show(
      {BuildContext context,
      String apiKey,
      Mode mode = Mode.fullscreen,
      String hint = 'Search Location',
      num offset,
      Location location,
      num radius,
      String language,
      String sessionToken,
      List<String> types,
      List<Component> components,
      bool strictbounds,
      Widget logo,
      ValueChanged<PlacesAutocompleteResponse> onError,
      String proxyBaseUrl,
      Client httpClient}) {
    final builder = (BuildContext ctx) => PlacesAutocompleteWidget(
        apiKey: apiKey,
        mode: mode,
        language: language,
        sessionToken: sessionToken,
        components: components,
        types: types,
        location: location,
        radius: radius,
        strictbounds: strictbounds,
        offset: offset,
        logo: logo,
        onError: onError,
        proxyBaseUrl: proxyBaseUrl,
        httpClient: httpClient);

    if (mode == Mode.overlay) {
      return showDialog(context: context, builder: builder);
    }
    return Navigator.push(context, MaterialPageRoute(builder: builder));
  }
}
