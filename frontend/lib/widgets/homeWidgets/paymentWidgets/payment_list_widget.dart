import 'package:flutter/material.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/card_payment_widget.dart';
import 'modal_widget.dart';

class PaymentListWidget extends StatefulWidget {
  const PaymentListWidget({super.key});

  @override
  PaymentListWidgetState createState() => PaymentListWidgetState();
}

class PaymentListWidgetState extends State<PaymentListWidget> {
  final List<String> payments = [
    'dividas',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
  ];

  bool _isDragging = false;
  final GlobalKey _trashKey = GlobalKey();
  final ValueNotifier<bool> _isOverTrashNotifier = ValueNotifier<bool>(false);

  void _showPaymentDialog(String name, double value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalWidget(paymentName: name, paymentValue: value);
      },
    );
  }

  bool _checkIfInsideTrash(Offset position) {
    final RenderBox? trashBox =
        _trashKey.currentContext?.findRenderObject() as RenderBox?;

    if (trashBox != null) {
      final Offset trashPosition = trashBox.localToGlobal(Offset.zero);
      final Size trashSize = trashBox.size;

      bool inside = position.dx >= trashPosition.dx &&
          position.dx <= trashPosition.dx + trashSize.width &&
          position.dy >= trashPosition.dy &&
          position.dy <= trashPosition.dy + trashSize.height;

      return inside;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.8,
      child: Column(
        children: [
          const Text('Payment list',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                    ),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      return Draggable<String>(
                        data: payments[index],
                        onDragStarted: () {
                          setState(() {
                            _isDragging = true;
                          });
                        },
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        onDragUpdate: (details) {
                          bool isInside =
                              _checkIfInsideTrash(details.globalPosition);
                          _isOverTrashNotifier.value = isInside;
                        },
                        onDragCompleted: () {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child:
                              CardPaymentWidget(paymentName: payments[index]),
                        ),
                        feedback: ValueListenableBuilder<bool>(
                          valueListenable: _isOverTrashNotifier,
                          builder: (context, isOverTrash, child) {
                            return Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: isOverTrash ? 100 : 60,
                                height: isOverTrash ? 100 : 60,
                                child: CardPaymentWidget(
                                    paymentName: payments[index]),
                              ),
                            );
                          },
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              _showPaymentDialog(payments[index], 50.00),
                          child:
                              CardPaymentWidget(paymentName: payments[index]),
                        ),
                      );
                    },
                  ),
                ),
                // Lixeira centralizada
                if (_isDragging)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        child: Container(
                          key: _trashKey,
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
