import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Distribuição Por Comunidade",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Comunidade São José",
            amountOfFiles: "100 Reais",
            numOfFiles: 100,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Comunidade São José",
            amountOfFiles: "120 Reais",
            numOfFiles: 120,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Comunidade São José",
            amountOfFiles: "110 Reais",
            numOfFiles: 110,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Comunidade São José",
            amountOfFiles: "100 Reais",
            numOfFiles: 100,
          ),
        ],
      ),
    );
  }
}
