// ignore_for_file: invalid_use_of_visible_for_testing_member

import "/exports/exports.dart";
import "dart:io";
import "dart:typed_data";

class EditBlog extends StatefulWidget {
  final BlogsModel blog;
  const EditBlog({super.key, required this.blog});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final titleController = TextEditingController();
  final summaryController = TextEditingController();
  final contentController = TextEditingController();
  String? image;

  @override
  void initState() {
    super.initState();
    setState(() {
      titleController.text = widget.blog.title;
      contentController.text = widget.blog.content;
      summaryController.text = widget.blog.summary;
    });
  }

  Uint8List? imageData;
  String fileName = "";
  String? currentImage;
  Stream<Uint8List>? streamData;
  int fileLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Blog Post"),
      ),
      body: Consumer<LoaderController>(builder: (context, controller, ch) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          children: [
            TapEffect(
              onClick: () async {
                final file = await ImagePicker.platform.getImageFromSource(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  setState(() {
                    imageData = File(file.path).readAsBytesSync();
                    fileName = file.path.split("/").last;
                    streamData = File(file.path).readAsBytes().asStream();
                    fileLength = File(file.path).lengthSync();
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
                  child: imageData != null
                      ? Image.memory(
                          imageData!,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.blog.image,
                          fit: BoxFit.cover,
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
                text: "Publish Update",
                buttonRadius: 10,
                loading: controller.isLoading,
                buttonColor: controller.isLoading
                    ? null
                    : Theme.of(context).primaryColor,
                textColor: controller.isLoading ? null : Colors.white,
                onPress: () {
                  if (titleController.text.isEmpty ||
                      contentController.text.isEmpty) {
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
                    BlogService.updateBlog({
                      "title": titleController.text,
                      "content": contentController.text,
                      "summary": summaryController.text,
                      "league": widget.blog.league,
                      "stream": streamData,
                      "length": fileLength,
                      "filename": fileName,
                      "id": widget.blog.id,
                    });
                  }
                })
          ],
        );
      }),
    );
  }
}
