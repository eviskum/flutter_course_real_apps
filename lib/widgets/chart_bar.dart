import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.dayLabel, this.spendingAmount, this.spendingPctOfTotal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) {
        return Column(
          children: [
            SizedBox(
                height: constaints.maxHeight * 0.15,
                child: FittedBox(child: Text('€${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constaints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constaints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constaints.maxHeight * 0.05,
            ),
            SizedBox(height: constaints.maxHeight * 0.15, child: FittedBox(child: Text(dayLabel))),
          ],
        );
      },
    );
  }
}
