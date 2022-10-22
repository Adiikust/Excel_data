import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:excle_data/Model/Excel_Data_Fetch.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<ExcelDataFetch> getData = [];
Future<List<ExcelDataFetch>> fetchExcelDataFetch() async {
  final response = await http.get(Uri.parse(
      "https://script.googleusercontent.com/macros/echo?user_content_key=yWxr7B3RuC9K6E3UUIn1r3-FC-iEoW0RVK9OTeZ7aY4LvFtYwG5hNFJhlgOxDmrjGYnP1VfDnHhcY14X8cL2zam4f4t_SkiNm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnJfYSidkcDQMojNYl7YdB2vIVCX_AEJBXDv-Ekg1emol-2xM5yTgNQQ10TDBjGRyqq6l5TV8ikOTjQqmDsQwvyxBvORg1paMbdz9Jw9Md8uu&lib=MCkCgeTe0TJMMC0SEMyfcUf0MEPxoW2ln"));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      getData.add(ExcelDataFetch.fromJson(i));
    }
    return getData;
  } else {
    return getData;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel Data"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder(
                    future: fetchExcelDataFetch(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ExcelDataFetch>> snapshot) {
                      if (snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            itemCount: getData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 3),
                                      CircleAvatar(
                                        radius: 35,
                                        child: Image.asset(
                                          "image/scr3.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      ReusableRow(
                                          title: "Name :",
                                          value:
                                              getData[index].name.toString()),
                                      const SizedBox(height: 3),
                                      ReusableRow(
                                          title: "Email :",
                                          value:
                                              getData[index].email.toString()),
                                      const SizedBox(height: 3),
                                      ReusableRow(
                                          title: "Phone :",
                                          value: getData[index]
                                              .mobileNo
                                              .toString()),
                                      const SizedBox(height: 3),
                                      ReusableRow(
                                          title: "Feedback :",
                                          value: getData[index]
                                              .feedback
                                              .toString()),
                                      const SizedBox(height: 3),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
