import 'package:flutter/material.dart';

class ProductListShow extends StatefulWidget {
  const ProductListShow({super.key});

  @override
  State<ProductListShow> createState() => _ProductListShowState();
}

class _ProductListShowState extends State<ProductListShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Comming Soon"),
    );
  }
}
