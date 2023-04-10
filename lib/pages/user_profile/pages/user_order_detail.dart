part of '../user_profile.dart';

class UserOrderDetailScreen extends GetView {
  const UserOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var orderDetail = Get.arguments as UsersOrderItem;
    return Scaffold(
      appBar: CustomAppBar(
        title: Row(
          children: [
            Text(
              'ORDER  #',
              style: Get.theme.appBarTheme.titleTextStyle
                  ?.copyWith(fontSize: 18.r),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  orderDetail.orderId.substring(0, 16),
                  maxLines: 1,
                  style: Get.theme.appBarTheme.titleTextStyle
                      ?.copyWith(fontSize: 18.r),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant & Order Details
              _headerDetails(orderDetail),
              _header('Bill Details'),
              _billDetailCard(orderDetail),
              _header('Review'),
              _reviewDetails(orderDetail),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerDetails(UsersOrderItem orderDetail) {
    var extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();
    return ContainerCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      shadowStyle: ShadowStyle.style1,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          // Restaurant Name
          Text(
            orderDetail.restName,
            style: TextStyle(
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
              color: Get.theme.customColor()?.text06,
            ),
          ),
          if (orderDetail.restOutlet != null &&
              orderDetail.restOutlet!.isNotEmpty)
            const SizedBox(height: 4),
          if (orderDetail.restOutlet != null &&
              orderDetail.restOutlet!.isNotEmpty)
            Text(
              orderDetail.restOutlet!,
              style: TextStyle(
                fontSize: 12.r,
                fontWeight: FontWeight.normal,
                color: Get.theme.customColor()?.text04,
              ),
            ),
          _divider(),
          Text(
            'Order Placed on ${DateFormat('MMMM d, h:mm a').format(orderDetail.orderDate)}',
            style: TextStyle(
              fontSize: 14.r,
              fontWeight: FontWeight.normal,
              color: Get.theme.customColor()?.text05,
            ),
          ),
          _divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                orderDetail.isOrderPickedUp
                    ? 'Order was successfully completed'
                    : 'Order was canceled',
                style: TextStyle(
                  fontSize: 14.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text04,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                orderDetail.isOrderPickedUp
                    ? Icons.check_circle_rounded
                    : Icons.question_mark_rounded,
                size: 14,
                color: orderDetail.isOrderPickedUp
                    ? extendedColorsStyle?.currentOrderCardColor
                    : extendedColorsStyle?.nonVegColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _billDetailCard(UsersOrderItem orderDetail) {
    var orderItems = orderDetail.orderItems;
    return ContainerCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      shadowStyle: ShadowStyle.style1,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 12.r,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.customColor()?.text07?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 60,
                child: Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 12.r,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.customColor()?.text07?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 60,
                child: Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12.r,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.customColor()?.text07?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...List.generate(orderItems.length, (idx) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      orderItems.entries.elementAt(idx).key.name ?? '',
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.normal,
                        color: Get.theme.customColor()?.text06,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 60,
                    child: Text(
                      orderItems.entries.elementAt(idx).value.toString(),
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.normal,
                        color: Get.theme.customColor()?.text05,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '₹${orderItems.entries.elementAt(idx).key.price}',
                      style: TextStyle(
                        fontSize: 14.r,
                        fontWeight: FontWeight.normal,
                        color: Get.theme.customColor()?.text05,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }),
          _divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Items',
                style: TextStyle(
                  fontSize: 14.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text05,
                ),
              ),
              Text(
                orderItems.values.reduce((a, b) => a + b).toString(),
                style: TextStyle(
                  fontSize: 16.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text05,
                ),
              ),
            ],
          ),
          _divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Paid via ${orderDetail.paymentType.capitalize}',
                style: TextStyle(
                  fontSize: 11.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text03,
                ),
              ),
              const Spacer(),
              Text(
                'Bill Total',
                style: TextStyle(
                  fontSize: 16.r,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.customColor()?.text06,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '₹${orderDetail.totalPrice}',
                style: TextStyle(
                  fontSize: 16.r,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.customColor()?.text06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewDetails(UsersOrderItem orderDetail) {
    var rating = orderDetail.rating;

    if (rating != null) {
      var extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();
      return ContainerCard(
        padding: const EdgeInsets.all(16),
        borderRadius: 22,
        shadowStyle: ShadowStyle.style1,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Row(
              children: [
                Text(
                  'Your rating for this order',
                  style: TextStyle(
                    fontSize: 14.r,
                    fontWeight: FontWeight.normal,
                    color: Get.theme.customColor()?.text05,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.stars_rounded,
                  size: 14,
                  color: extendedColorsStyle?.ratingsIconColor,
                ),
                const SizedBox(width: 4),
                Text(
                  rating.rating.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.customColor()?.text06,
                  ),
                ),
              ],
            ),
            _divider(),
            Text(
              'Feedback',
              style: TextStyle(
                fontSize: 12.r,
                fontWeight: FontWeight.w500,
                color: Get.theme.customColor()?.text07?.withOpacity(0.7),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4),
            Text(
              rating.feedback.isEmpty
                  ? 'You have not added any feedback for this order'
                  : rating.feedback,
              style: TextStyle(
                fontSize: 14.r,
                fontWeight: FontWeight.normal,
                color: Get.theme.customColor()?.text04,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "You haven't rated this order yet",
            style: TextStyle(
              fontSize: 14.r,
              fontWeight: FontWeight.normal,
              color: Get.theme.customColor()?.text04,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.FEEDBACK, parameters: {
                'orderId': orderDetail.orderId,
              });
            },
            child: Container(
              width: 1.sw,
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: Get.theme.primaryColorDark,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 10,
              ),
              child: Text(
                'Leave a Feedback',
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text00,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomPaint(
        painter: DashedLinePainter(
          dashColor: Get.theme.primaryColorLight.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _header(String text) {
    var fontStyles = Get.theme.extension<CustomFontStyles>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Text(
        text,
        style: fontStyles!.header2,
        textAlign: TextAlign.left,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
