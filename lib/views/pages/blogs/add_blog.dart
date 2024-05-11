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
  final summaryController = TextEditingController();
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
            TapEffect(
              onClick: () async {
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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: SizedBox.square(
                  dimension: MediaQuery.of(context).size.width / 2.3,
                  child: image != null
                      ? Image.file(
                          File(image!),
                          fit: BoxFit.cover,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add),
                            const SizedBox.square(dimension: 10),
                            Text(
                              "Add a banner",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            TextFormField(
              maxLines: 1,
              controller: titleController,
              readOnly: controller.isLoading,
              decoration: InputDecoration(
                labelText: "Blog title",
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "Enter blog title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            TextFormField(
              maxLines: 3,
              controller: summaryController,
              readOnly: controller.isLoading,
              decoration: InputDecoration(
                labelText: "Blog summary",
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "Enter blog summary",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            TextFormField(
              maxLines: 9,
              controller: contentController,
              readOnly: controller.isLoading,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "Enter description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            CustomButton(
                text: "Publish",
                buttonRadius: 10,
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
                      "summary": summaryController.text,
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
