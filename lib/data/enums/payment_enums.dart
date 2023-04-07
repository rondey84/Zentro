enum PaymentModes {
  card(true),
  netbanking(true),
  wallet(true),
  emi(true),
  upi(true),
  payOnPickup(false),
  cash(true);

  const PaymentModes(this.prePaid);
  final bool prePaid;
}
