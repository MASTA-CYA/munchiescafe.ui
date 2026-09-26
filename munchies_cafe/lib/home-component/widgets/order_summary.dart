import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munchies_cafe/common/widgets/bullet_point_paragraph.dart';
import 'package:munchies_cafe/home-component/enums/order_type_enum.dart';
import 'package:munchies_cafe/home-component/enums/payment_type_enum.dart';
import 'package:munchies_cafe/home-component/models/order_summary_model.dart';

class OrderSummaryWidget extends StatelessWidget {
  final OrderSummary order;
  final void Function() onOrderSummaryPressed;

  const OrderSummaryWidget({
    super.key,
    required this.order,
    required this.onOrderSummaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildOrderNumber(context),
            _buildOrderItems(context),
            _buildOrderType(context),
            _buildPaymentMethod(context),
            _buildOrderTotal(context),
            _buildActionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderNumber(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Order\t\t',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextSpan(
              text: '#${order.id}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: BulletPointParagraphWidget(
          paragraph: order.items,
        ),
      ),
    );
  }

  Widget _buildOrderType(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          ResizeImage(
            AssetImage('assets/images/${order.type.name}.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        ),
        const SizedBox(width: 10),
        Text(order.type.displayName),
      ],
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          ResizeImage(
            AssetImage('assets/images/${order.method.icon}.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        ),
        const SizedBox(width: 10),
        Text(order.method.displayName),
      ],
    );
  }

  Widget _buildOrderTotal(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        NumberFormat.simpleCurrency(locale: 'en_za').format(order.amount),
        style: Theme.of(context).textTheme.bodyMedium?.merge(
              const TextStyle(color: Colors.green),
            ),
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => onOrderSummaryPressed(),
          child: Text(
            'REPEAT',
            style: Theme.of(context).textTheme.titleLarge?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
          ),
        ),
      ],
    );
  }
}
