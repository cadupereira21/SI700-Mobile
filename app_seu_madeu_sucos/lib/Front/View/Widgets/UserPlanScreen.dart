import 'package:flutter/material.dart';

import '../../Entities/Plan.dart';
import '../../Logic/PlanInfo.dart';

class UserPlanScreen extends StatefulWidget {
  const UserPlanScreen({super.key});

  @override
  State<UserPlanScreen> createState() => _UserPlanScreenState();
}

class _UserPlanScreenState extends State<UserPlanScreen> {
  List<Plan> allPlans = PlanInfo.allPlans;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: 
            ListView.builder(
            itemCount: allPlans.length,
            itemBuilder: (BuildContext context, int index) =>
              planTile(allPlans[index]),
            ),
          ),
          Expanded(   
            child: 
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              //color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.5, 15, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Voltar"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget planTile(Plan plan) {
    return Card(
      margin: const EdgeInsets.all(10),
      //elevation: 2,
      color: Colors.white,
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        title: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan.name, 
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              Text(
                "R\$ ${plan.value.toStringAsFixed(2)}", 
                style: const TextStyle(fontSize: 20, color: Colors.orange),
              ),
            ],
          )
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plan.description, style: const TextStyle(fontSize: 15, color: Colors.black)),
          ],
        ),
        //trailing: addToCartButton(product),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
