import 'package:course_allocation_phone/controllers/add_courses_controller.dart';
import 'package:course_allocation_phone/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contstants.dart';
import '../../models/course.dart';
import '../../services/base_client.dart';

class AddCourses extends StatefulWidget {
  const AddCourses({Key? key}) : super(key: key);

  @override
  State<AddCourses> createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> with BaseController {
  late AddCoursesController controller;
  int i = 0;
  @override
  void initState() {
    controller = AddCoursesController();
    super.initState();
    getData();
  }

  bool isLoading = true;
  getData() async {
    BaseClient baseClient = BaseClient();
    var response =
        await baseClient.get(kBaseUrl, 'courses').catchError(handleError);
    if (response == null) return [];
    controller.coursesList = response.map<Course>(Course.fromJson).toList();
    controller.searchedList = controller.coursesList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 23,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 3),
            child: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Obx(
            () => Container(
              child: controller.showSearchField.value == false
                  ? const Text('Add Courses')
                  : buildSearchField(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 7, right: 3),
              child: InkWell(
                onTap: () {
                  controller.showSearchField.value =
                      !controller.showSearchField.value;
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => Text(
                    'Choosen ${controller.selectedCourses.length} of ${controller.count} Courses',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Obx(
                          () => Flexible(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedCourses.length,
                                itemBuilder: (context, index) {
                                  return buildSelectedCList(index);
                                }),
                          ),
                        ),
                        Obx(() => Container(
                            child: controller.selectedCourses.length == 4
                                ? buildSendButton()
                                : const SizedBox.shrink())),
                      ],
                    )),
                Expanded(
                  child: buildList(),
                )
              ]),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: controller.searchedList.length,
      itemBuilder: ((context, index) {
        return ListTile(
            minVerticalPadding: 1,
            title: Text(controller.searchedList.elementAt(index).name),
            subtitle: Text(
                'Code: ${controller.searchedList.elementAt(index).code}, Semester: ${controller.searchedList.elementAt(index).program} ${controller.searchedList.elementAt(index).department} ${controller.searchedList.elementAt(index).semester}'),
            contentPadding: const EdgeInsets.only(left: 10),
            trailing: InkWell(
                onTap: () {
                  controller.addCourses(controller.searchedList[index]);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )) //),
            );
      }),
    );
  }

  Widget buildSearchField() => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: TextField(
          controller: controller.queryC,
          onChanged: (String value) {
            controller.filterData(value);
            setState(() {});
          },
          textInputAction: TextInputAction.search,
          onSubmitted: (String str) {},
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      );

  Container buildSelectedCList(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4.0,
          right: 3,
        ),
        child: Row(
          children: [
            Text(
              controller.selectedCourses.elementAt(index).name.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              width: 4,
            ),
            InkWell(
              splashColor: Colors.black12,
              onTap: () {
                controller.removeSelectedCourses(index);
              },
              child: const Icon(Icons.cancel_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSendButton() {
    return Container(
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
          border: Border.all(color: kKfueitblue, width: 1),
          color: kKfueitGreen,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4.0,
          right: 3,
        ),
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () {
            controller.sendPrefCourses();
            //print(controller.isChecked);
          },
          child: Row(
            children: const [
              Text(
                'Send',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.send,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
