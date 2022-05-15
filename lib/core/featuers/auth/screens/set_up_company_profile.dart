import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/widgets/custom_text_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetUpCompanyProfile extends StatefulWidget {
  static const routeName = '/company_set_up';
  const SetUpCompanyProfile({Key? key}) : super(key: key);

  @override
  State<SetUpCompanyProfile> createState() => _SetUpCompanyProfileState();
}

int activePage = 0;

class _SetUpCompanyProfileState extends State<SetUpCompanyProfile> {
  final liquidController = LiquidController();
  final nameController = TextEditingController();

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
              child: Icon(
                Icons.person_add,
                size: 50,
                color: beg,
              ),
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
        child: Column(children: [
          sizedBoxXLarge,
          Image.asset(
            'assets/images/setup_profile2.png',
            fit: BoxFit.fill,
          ),
          sizedBoxXLarge,
          sizedBoxMedium,
          TextFieldCustome(
            controller: nameController,
            text: 'Name',
          ),
          sizedBoxMedium,
        ]),
      )),
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
          child: Column(
            children: [
              Image.asset(
                'assets/images/setub_profile3.png',
                fit: BoxFit.fill,
              ),
              sizedBoxXLarge,
              SizedBox(
                width: 300,
                child: TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    prefixStyle: TextStyle(
                        color: beg,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                    isDense: true,
                    contentPadding: EdgeInsets.all(14),
                    labelStyle: TextStyle(
                      color: beg,
                      fontFamily: font,
                      fontSize: 24,
                    ),
                    label: Text(
                      'Describtion',
                      style: TextStyle(
                          color: orange,
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
              'assets/images/setup_profile4.png',
              fit: BoxFit.fill,
            ),
            sizedBoxXLarge,
            sizedBoxMedium,
            SizedBox(
              width: 300,
              height: 200,
              child: TextFormField(
                onTap: () {},
                decoration: const InputDecoration(
                  isDense: true,
                  label: Text(
                    'Location',
                    style: TextStyle(
                        color: orange,
                        fontFamily: font,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
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
                      activePage = index;
                      setState(() {});
                    },
                  ),
                  Positioned(
                    child: TextButton(
                      onPressed: () {
                        if (activePage + 1 < pages.length) {
                          liquidController.jumpToPage(
                              page: liquidController.currentPage + 1);
                        }
                        setState(() {});
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
                      child: AnimatedSmoothIndicator(
                        count: pages.length,
                        activeIndex: activePage,
                        duration: const Duration(milliseconds: 300),
                        effect: const WormEffect(
                            activeDotColor: orange,
                            dotHeight: 10,
                            dotWidth: 10),
                      )),
                ],
              ))),
    );
  }
}
