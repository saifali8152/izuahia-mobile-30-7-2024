import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/controllers/thread-tab-controller.dart';
import 'package:izuahia/res/assets.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/res/components/buttons/round-button.dart';
import 'package:izuahia/screens/SERVICEHUB/Payment/payment-screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ThreadTabController tabController = Get.put(ThreadTabController());

  final List<Map<String, dynamic>> itemList = [
    {'image': Assets.mobile},
    {'image': Assets.laptop1},
    {'image': Assets.shoe},
    {'image': Assets.profileImage},
    {'image': Assets.mobile},
    {'image': Assets.laptop2},
    {'image': Assets.shoe},
    {'image': Assets.profileImage},
    {'image': Assets.profileImage},
    {'image': Assets.mobile},
  ];

  var counter = 0;

  increment() {
    setState(() {
      counter++;
    });
  }

  decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
            // padding: EdgeInsets.only(top: 10.h, left: 13.w, right: 13.w, bottom: 30.h),
            decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      'CART',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              Assets.cart,
                              color: Colors.black,
                            )))
                  ],
                ),
                10.verticalSpace,
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return cartItemWidget(onTap: () {}, image: itemList[index]['image']);
                      }),
                ),
                summaryWidget(),
              ],
            )));
  }

  Widget cartItemWidget({required VoidCallback onTap, required String image}) {
    return Container(
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .09,
            width: Get.width * .34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              color: AppColors.yellow2,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Item Name:',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    3.horizontalSpace,
                    const Text(
                      'Tech Writing',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                Row(
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.horizontalSpace,
                    incrementWidget(
                      onIncrement: increment,
                      onDecrement: decrement,
                      counter: counter.toString(),
                    ),
                  ],
                ),
                4.verticalSpace,
                Row(
                  children: [
                    const Text(
                      'Amount:',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.horizontalSpace,
                    const Text(
                      '4112',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    customButton(
                      title: 'Delete',
                      onTap: onTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget incrementWidget({required VoidCallback onIncrement, required VoidCallback onDecrement, required String counter}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onDecrement,
        child: Container(
          height: 10,
          width: 15,
          decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(2)),
          child: const Center(
              child: Icon(
            Icons.remove_outlined,
            size: 8,
            color: AppColors.yellow,
          )),
        ),
      ),
      8.horizontalSpace,
      Text(
        counter,
        style: const TextStyle(fontSize: 14, color: AppColors.blackColor, fontWeight: FontWeight.bold),
      ),
      8.horizontalSpace,
      GestureDetector(
        onTap: onIncrement,
        child: Container(
          height: 10,
          width: 15,
          decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(2)),
          child: const Center(
              child: Icon(
            Icons.add,
            size: 8,
            color: AppColors.yellow,
          )),
        ),
      ),
    ],
  );
}

Widget summaryWidget() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric( vertical: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.orangeLight),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Summary',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
        ),
        5.verticalSpace,
        const Divider(
          color: AppColors.blackColor,
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Amount:',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
            5.horizontalSpace,
            const Text('54300',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500)),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Shipping charges:',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w600)),
            5.horizontalSpace,
            const Text('654',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.w500)),
          ],
        ),
        5.verticalSpace,
        const Divider(
          color: AppColors.blackColor,
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)),
            5.horizontalSpace,
            const Text('782783',
                style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: AppColors.blackColor, fontWeight: FontWeight.bold)
                ),
          ],
        ),
        12.verticalSpace,
        Row(
          children: [
            Row(
              children: [
                const Text(
                  'Protect Buy',
                    style: TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.blackColor,)
                ),
                5.horizontalSpace,
                Image.asset(Assets.infoCircle),
              ],
            ),
            10.horizontalSpace,
            CustomCupertinoSwitch(value: true, onChanged: (value) {}),
            const Spacer(),
          ],
        ),
        5.verticalSpace,
        SizedBox(
          height: Get.height * .05,
          width: Get.width * 0.3,
          child: RoundButton(
            label: 'Place Order',
            onPressed: () {
              Get.to(() => const PaymentScreen());
            },
          ),
        )
      ],
    ),
  );
}

Widget customButton({required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
      child: Text(title,
          style: const TextStyle(fontSize: 12, fontFamily: 'Inter', color: AppColors.yellow, fontWeight: FontWeight.w500)),
    ),
  );
}

class CustomCupertinoSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCupertinoSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _CustomCupertinoSwitchState();
}

class _CustomCupertinoSwitchState extends State<CustomCupertinoSwitch> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant CustomCupertinoSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.animateTo(widget.value ? 1.0 : 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SwitchPainter(_controller.value),
            child: Container(
              width: 100,
              height: 25,
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 20.0, // Smaller thumb
                height: 20.0, // Smaller thumb
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SwitchPainter extends CustomPainter {
  final double position;

  _SwitchPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.lerp(Colors.grey, AppColors.yellow, position)!
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromLTRBR(0.0, 0.0, size.width, size.height, Radius.circular(size.height / 2));
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
