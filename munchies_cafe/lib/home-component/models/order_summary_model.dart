import 'package:munchies_cafe/home-component/enums/order_type_enum.dart';
import 'package:munchies_cafe/home-component/enums/payment_type_enum.dart';

class OrderSummary {
  final String id;
  final String items;
  final double amount;
  final OrderType type;
  final PaymentMethod method;

  OrderSummary({
    required this.id,
    required this.items,
    required this.amount,
    required this.type,
    required this.method,
  });
}
