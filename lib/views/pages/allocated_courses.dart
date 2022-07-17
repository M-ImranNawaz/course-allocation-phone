import 'package:course_allocation_phone/controllers/ac_controller.dart';
import 'package:course_allocation_phone/views/pages/add_courses_page.dart';
import 'package:course_allocation_phone/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/course.dart';

class AllocatedCourses extends StatefulWidget {
  const AllocatedCourses({Key? key}) : super(key: key);

  @override
  State<AllocatedCourses> createState() => _AllocatedCoursesState();
}

class _AllocatedCoursesState extends State<AllocatedCourses> {
  late ACController controller;
  @override
  void initState() {
    controller = ACController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
                prefs.clear();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Icon(Icons.logout),
              ),
            ),
            title: const Text('Allocated Courses'),
            centerTitle: true,
            actions: [
              Tooltip(
                message: 'Add Courses',
                child: InkWell(
                    onTap: () async {
                      bool c = await Get.to(() => const AddCourses());
                      if (c) {
                        setState(() {});
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Icon(Icons.add),
                    )),
              ),
            ]),
        body: SizedBox(
          height: double.infinity,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.getData();
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Center(
                child: FutureBuilder(
                  future: controller.getData(),
                  builder: (context, snapshot) {
                    if (controller.aCourses.isNotEmpty) {
                      return buildCourseView();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (controller.aCourses.isEmpty) {
                      return Center(
                          child: Column(
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text('Retry')),
                          const Text('Empty'),
                        ],
                      ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }

  Center buildCourseView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "${controller.aCourses['Allocated Courses']['faculty'].toString()}'s Allocated Courses",
              style: Get.textTheme.bodyText1),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.courses.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FixedColumnWidth(120.0),
                      },
                      children: [
                        TableRow(
                          children: [
                            buildTextField("Name"),
                            buildTextField(controller.courses
                                .elementAt(index)
                                .toString()
                                .split('_')[0]
                                .trim()),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildTextField("Course Code"),
                            buildTextField(controller.courses
                                .elementAt(index)
                                .toString()
                                .split('_')[1]),
                            //buildTextField(c.code),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildTextField("Credit Hours"),
                            buildTextField(controller.courses
                                .elementAt(index)
                                .toString()
                                .split('_')[2]
                                .toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildTextField("Section"),
                            buildTextField(controller.courses
                                .elementAt(index)
                                .toString()
                                .split('_')[3]
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  Center buildCourseVie(List<Course> courses) {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: courses.length,
          itemBuilder: ((context, index) {
            var c = courses.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(120.0),
                },
                children: [
                  TableRow(
                    children: [
                      buildTextField("Name"),
                      buildTextField(c.name),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildTextField("Course Code"),
                      buildTextField(c.code),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildTextField("Section"),
                      buildTextField("${c.program} "
                          "${c.department} "
                          "${c.semester.length == 1 ? '${c.semester}-A' : c.semester}"),
                    ],
                  ),
                ],
              ),
            );
          })),
    );
  }

  Widget buildTextField(data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: SelectableText(
        data,
      ),
    );
  }
}
