// ignore_for_file: invalid_use_of_visible_for_testing_member

import "/exports/exports.dart";
import "dart:io";

class AddBlog extends StatefulWidget {
  final String league;
  const AddBlog({super.key, required this.league});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
      ),
      body: Consumer<LoaderController>(builder: (context, controller, ch) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CircleAvatar(
                backgroundImage: image == null
                    ? const AssetImage("assets/images/logo.jpeg")
                        as ImageProvider<Object>
                    : FileImage(
                        File(image!),
                      ),
                radius: 70,
              ),
              IconButton(
                iconSize: 40,
                icon: const Icon(
                  Icons.add_a_photo_rounded,
                ),
                onPressed: () async {
                  final pickedFile =
                      await ImagePicker.platform.getImageFromSource(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image = pickedFile.path;
                    });
                  }
                },
              ),
            ]),
            CommonTextField(
              titleText: "Title",
              enableBorder: true,
              hintText: "Enter title",
              readOnly: controller.isLoading,
              controller: titleController,
            ),
            const SizedBox.square(dimension: 20),
            TextFormField(
              maxLines: 15,
              controller: contentController,
              readOnly: controller.isLoading,
              decoration: InputDecoration(
                // helperText: "Description",
                hintText: "Enter description",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 20),
            CustomButton(
                text: "Add Blog Post",
                loading: controller.isLoading,
                buttonColor: controller.isLoading
                    ? null
                    : Theme.of(context).primaryColor,
                textColor: controller.isLoading ? null : Colors.white,
                onPress: () {
                  if (titleController.text.isEmpty ||
                      contentController.text.isEmpty ||
                      image == null) {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        title: const Text("Error"),
                        content: const Text("All fields are required"),
                        actions: [
                          TextButton(
                            onPressed: () => Routes.popPage(),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                    return;
                  } else {
                    BlogService.createBlog({
                      "title": titleController.text,
                      "content": contentController.text,
                      "league": widget.league,
                      "image": image,
                    });
                  }
                })
          ],
        );
      }),
    );
  }
}
