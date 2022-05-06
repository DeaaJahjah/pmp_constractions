import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetUpEngineerProfile extends StatefulWidget {
  static const routeName = '/';
  const SetUpEngineerProfile({Key? key}) : super(key: key);

  @override
  State<SetUpEngineerProfile> createState() => _SetUpEngineerProfileState();
}

class _SetUpEngineerProfileState extends State<SetUpEngineerProfile> {
  final liquidController = LiquidController();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  String dropdownvalue = 'Architectural engineer';
  var items = [
    'Architectural engineer',
    'Civil engineer',
    'Elctricity  engineer',
    'Water  engineer',
  ];
  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBlue,
        child: Column(children: [
          sizedBoxXLarge,
          Image.asset(
            'assets/images/setup_profile1.png',
            fit: BoxFit.fill,
          ),
          sizedBoxXLarge,
          const CircleAvatar(
              backgroundColor: karmedi,
              child: Icon(Icons.person, size: 60, color: beg),
              maxRadius: 60),
          sizedBoxMedium,
          const Text('Add a picture',
              style: TextStyle(
                color: beg,
                fontFamily: font,
                fontSize: 24,
              )),
        ]),
      ),
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: darkBlue,
          child: Column(
            children: [
              sizedBoxXLarge,
              Image.asset(
                'assets/images/setup_profile2.png',
                fit: BoxFit.fill,
              ),
              sizedBoxXLarge,
              sizedBoxMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 230,
                    height: 40,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixText: '+963 ',
                        prefixStyle: TextStyle(
                            color: beg,
                            fontFamily: font,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        label: Text(
                          'Number',
                          style: TextStyle(
                              color: beg,
                              fontFamily: font,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.start,
                      autofocus: false,
                      style: const TextStyle(
                          color: beg,
                          fontFamily: font,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          size: 15,
                          color: beg,
                        )),
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          color: darkBlue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              'assets/images/setub_profile3.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownvalue,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          color: darkBlue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              'assets/images/setup_profile4.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            SizedBox(
              width: 230,
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Languages',
                    style: TextStyle(
                        color: beg,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
                style: const TextStyle(
                    color: beg,
                    fontFamily: font,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            sizedBoxLarge,
            SizedBox(
              width: 230,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintMaxLines: 3,
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Certificates',
                    style: TextStyle(
                        color: beg,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
                style: const TextStyle(
                    color: beg,
                    fontFamily: font,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            sizedBoxLarge,
            SizedBox(
              width: 230,
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  label: Text(
                    'Programs',
                    style: TextStyle(
                        color: beg,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.start,
                autofocus: false,
                style: const TextStyle(
                    color: beg,
                    fontFamily: font,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ]),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Set up your profile',
        ),
        centerTitle: true,
      ),
      body: Builder(
          builder: ((context) => Stack(
                children: [
                  LiquidSwipe(
                    pages: pages,
                    liquidController: liquidController,
                    onPageChangeCallback: (index) {
                      //  setState(() {});
                    },
                  ),
                  Positioned(
                    child: TextButton(
                      onPressed: () {
                        //  liquidController.jumpToPage(page: 3);
                      },
                      child: const Text('Skip',
                          style: TextStyle(
                            color: beg,
                            fontFamily: font,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    bottom: -7,
                    left: 300,
                  ),
                  Positioned(
                    bottom: 12,
                    left: 150,
                    child: SmoothPageIndicator(
                        axisDirection: Axis.horizontal,
                        controller: controller,
                        count: pages.length,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: orange,
                          activeDotColor: orange,
                          paintStyle: PaintingStyle.stroke,
                          type: WormType.thin,
                        ),
                        onDotClicked: (index) {}),
                  ),
                ],
              ))),
    );
  }
}
