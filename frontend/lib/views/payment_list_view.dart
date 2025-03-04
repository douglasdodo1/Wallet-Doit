import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/payment_view_model.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/card_payment_widget.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/modal_new_payment.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/modal_edit_widget.dart';
import 'package:provider/provider.dart';

class PaymentListView extends StatefulWidget {
  const PaymentListView({super.key});

  @override
  PaymentListViewState createState() => PaymentListViewState();
}

class PaymentListViewState extends State<PaymentListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<PaymentViewModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, viewModel, child) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 0.8,
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          ModalNewPayment.showNewPaymentModal(context)
                              .then((result) => viewModel.sendData(result)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 250, 250, 250),
                        elevation: 0,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const Text("Payment list"),
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => viewModel.selectDate(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 250, 250, 250),
                          side: BorderSide.none,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        viewModel.formattedDate,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
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
                        itemCount: viewModel.payments.length,
                        itemBuilder: (context, index) {
                          int iconCode =
                              int.parse(viewModel.payments[index].iconCode);
                          return Draggable<Object>(
                            data: viewModel.payments[index].namePayment
                                as String?,
                            onDragStarted: () {
                              setState(() {
                                viewModel.isDragging = true;
                                viewModel.draggedPayment =
                                    viewModel.payments[index];
                              });
                            },
                            onDraggableCanceled: (velocity, offset) {
                              setState(() {
                                viewModel.isDragging = false;
                              });
                            },
                            onDragUpdate: (details) {
                              bool isInside = viewModel
                                  .checkIfInsideTrash(details.globalPosition);
                              viewModel.isOverTrashNotifier.value = isInside;
                            },
                            onDragEnd: (details) {
                              if (viewModel.isOverTrashNotifier.value) {
                                viewModel.deleteData(
                                    viewModel.payments[index].id.toString());
                              }
                              setState(() {
                                viewModel.isDragging = false;
                              });
                            },
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: CardPaymentWidget(
                                  paymentName:
                                      viewModel.payments[index].namePayment,
                                  iconCode: iconCode),
                            ),
                            feedback: ValueListenableBuilder<bool>(
                              valueListenable: viewModel.isOverTrashNotifier,
                              builder: (context, isOverTrash, child) {
                                return Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: viewModel.isOverTrashNotifier.value
                                        ? 100
                                        : 90,
                                    height: viewModel.isOverTrashNotifier.value
                                        ? 100
                                        : 90,
                                    child: CardPaymentWidget(
                                      paymentName:
                                          viewModel.payments[index].namePayment,
                                      iconCode: iconCode,
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: GestureDetector(
                              onTap: () => ModalEditWidget.showModalEditWidget(
                                  context, viewModel.payments[index]),
                              child: CardPaymentWidget(
                                paymentName:
                                    viewModel.payments[index].namePayment,
                                iconCode: iconCode,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Lixeira centralizada
                    if (viewModel.isDragging)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                viewModel.isDragging = false;
                              });
                            },
                            child: Container(
                              key: viewModel.trashKey,
                              width: 100,
                              height: 100,
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
                                size: 100,
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
      },
    );
  }
}
