enum OrderStatus {
  initialized('Order Placed'),
  confirmed('Order Confirmed'),
  preparing('Preparing Your Order'),
  ready('Order Ready for Pickup'),
  completed('Order Delivered'),
  canceled('Order Canceled');

  const OrderStatus(this.message);
  final String message;
}
