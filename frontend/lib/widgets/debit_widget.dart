import 'package:flutter/material.dart';

class DebitWidget extends StatefulWidget {
  const DebitWidget({super.key});

  @override
  DebitWidgetState createState() => DebitWidgetState();
}

class DebitWidgetState extends State<DebitWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
              flex: 7,
              child: FractionallySizedBox(
                  heightFactor: 1,
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: SizedBox(
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 44, 57, 51),
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "RS:",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                              ),
                              Text("1234,56",
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Stack(
                children: [
                  Positioned(
                    right: 2,
                    top: 8,
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
