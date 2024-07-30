import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/res/components/text-fields/text-form-fields.dart';

class SalesPointListVacancyScreen extends StatefulWidget {
  const SalesPointListVacancyScreen({super.key});

  @override
  State<SalesPointListVacancyScreen> createState() => _SalesPointListVacancyScreenState();
}

class _SalesPointListVacancyScreenState extends State<SalesPointListVacancyScreen> {
  String companyValue = 'EzyBrot Limited';
  var companyItems = [
    'EzyBrot Limited',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  String typeValue = 'Full Time';
  var typeItems = [
    'Full Time',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  String urgency = '1 Week';
  var urgencyItems = [
    '1 Week',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * .8,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: AppColors.whiteColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          Assets.logo,
                          height: 45,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      20.horizontalSpace,
                      const Text(
                        'WORKWAVE AND CO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Container(
                    height: height * .048,
                    width: width,
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                              blurRadius: 4)
                        ],
                        border: const Border(left: BorderSide(color: AppColors.blackColor, width: 8))),
                    child: const Text('CONSULTING',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700)),
                  ),
                  8.verticalSpace,
                ],
              ),
            ),
            0.verticalSpace,
            textFormFieldWidget(title: 'Job Title', hintText: "Write Job Title"),
            10.verticalSpace,
            // DropdownButton2(
            //   isExpanded: true,
            //   underline: Container(),
            //   value: dropdownvalue,
            //   items: items.map((String item) {
            //     return DropdownMenuItem(
            //       value: item,
            //       child: Text(
            //         item,
            //         style: const TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: AppColors.grey2,
            //           fontSize: 10,
            //         ),
            //       ),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       dropdownvalue = newValue!;
            //     });
            //   },
            //   buttonStyleData:  ButtonStyleData(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.black
            //     ),
            //     borderRadius: BorderRadius.circular(10)
            //   )
            //   ),
            //   dropdownStyleData: DropdownStyleData(
            //       maxHeight: height * 0.2,
            //       decoration: const BoxDecoration(
            //         color: AppColors.grey3,
            //       )),
            // ),
            const Text(
              'Company',
              style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500),
            ),
            5.verticalSpace,
            DropdownButtonFormField(
              menuMaxHeight: height * .2,
              value: companyValue,
              dropdownColor: AppColors.grey3,
              elevation: 0,
              isDense: true,
              isExpanded: true,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(width: 10, child: Image.asset(Assets.logo)),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: companyItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey2,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  companyValue = newValue!;
                });
              },
            ),
            10.verticalSpace,
            const Text(
              'Type',
              style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500),
            ),
            5.verticalSpace,
            DropdownButtonFormField(
              menuMaxHeight: height * .2,
              value: typeValue,
              dropdownColor: AppColors.grey3,
              elevation: 0,
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: typeItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey2,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  typeValue = newValue!;
                });
              },
            ),
            10.verticalSpace,

            textFormFieldWidget(title: "Job Description", hintText: 'Write Job Desciption', maxLines: 5),
            10.verticalSpace,
            const Text(
              'Working hours',
              style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500),
            ),
            5.verticalSpace,
            Row(
              children: [
                const Expanded(
                  child: customTextFormField(hintText: "Start Date"),
                ),
                10.horizontalSpace,
                const Text(
                  'To',
                  style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500),
                ),
                10.horizontalSpace,
                const Expanded(child: customTextFormField(hintText: 'End Date')),
              ],
            ),
            10.verticalSpace,
            textFormFieldWidget(title: 'Requirements', hintText: 'Write Job Requirements'),
            10.verticalSpace,
            textFormFieldWidget(title: 'Vacancy', hintText: 'Write Vacancy'),
            10.verticalSpace,
            const Text(
              'Urgency',
              style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500),
            ),
            5.verticalSpace,
            DropdownButtonFormField(
              menuMaxHeight: height * .2,
              value: urgency,
              dropdownColor: AppColors.grey3,
              elevation: 0,
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: urgencyItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey2,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  urgency = newValue!;
                });
              },
            ),
            10.verticalSpace,
                          Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * .32,
                  child: RoundButton(
                    label: 'Add Vacancy',
                    onPressed: () {},
                  ),
                ),
              ),
              130.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class customTextFormField extends StatelessWidget {
  final String hintText;
  const customTextFormField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: "Montserrat-Regular",
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
        fontSize: 12,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppColors.grey3,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey3, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey3, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.grey3, width: 1),
        ),
        hintStyle: const TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          color: AppColors.grey2,
          fontSize: 10,
        ),
      ),
    );
  }
}
