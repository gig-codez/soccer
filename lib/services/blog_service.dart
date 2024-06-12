import "/exports/exports.dart";
import "dart:convert";

class BlogService {
  // function to fetch blogs
  static Future<List<BlogsModel>> getBlogs(String league) async {
    try {
      var response = await Client().get(Uri.parse("${Apis.blogs}/$league"));
      if (response.statusCode == 200) {
        return blogsModelFromJson(response.body);
      } else {
        showMessage(msg: response.reasonPhrase ?? "Error fetching blogs");
        return [];
      }
    } on Exception catch (e, _) {
      debugPrint("Error $_");
      return [];
    }
  }

  static void createBlog(Map<String, dynamic> data) async {
    try {
      context.read<LoaderController>().isLoading = true;
      var request = MultipartRequest('POST', Uri.parse(Apis.addBlog));
      request.fields['title'] = data['title'];
      request.fields['content'] = data['content'];
      request.fields['summary'] = data['summary'];
      request.fields['league'] = data['league'];
      request.fields['action'] = "Blogs";
      // handle file upload
      request.files.add(
        await MultipartFile.fromPath(
          'blog',
          data['image'],
        ),
      );
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Client().close();
        context.read<LoaderController>().isLoading = false;
        var result = json.decode(await response.stream.bytesToString());
        showMessage(
          msg: result['message'],
          color: Colors.green[900],
        );
        Routes.popPage();
      } else {
        Client().close();
        context.read<LoaderController>().isLoading = false;
        showMessage(msg: response.reasonPhrase ?? "Error adding a blog");
      }
    } on Exception catch (e, _) {
      Client().close();
      context.read<LoaderController>().isLoading = false;
      debugPrint("Error $_");
    }
  }

  // function to delete a blog
  static void deleteBlog(String id) async {
    try {
      showLoader(text: "Deleting blog");
      var response = await Client().delete(Uri.parse("${Apis.deleteBlog}/$id"));
      if (response.statusCode == 200) {
        Routes.popPage();
        Routes.popPage();
        var result = json.decode(response.body);
        showMessage(
          msg: result['message'],
          color: Colors.green[900],
        );
      } else {
        Routes.popPage();
        showMessage(msg: response.reasonPhrase ?? "Error deleting a blog");
      }
    } on Exception catch (e, _) {
      Routes.popPage();
      debugPrint("Error $_");
    }
  }

  // function to update a blog
  static void updateBlog(Map<String, dynamic> data) async {
    try {
      context.read<LoaderController>().isLoading = true;
      var request = MultipartRequest(
          'PUT', Uri.parse("${Apis.updateBlog}/${data['id']}"));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      request.fields['title'] = data['title'];
      request.fields['content'] = data['content'];
      request.fields['summary'] = data['summary'];
      request.fields['league'] = data['league'];
      request.fields['action'] = "Blogs";
      // handle file upload
      if (data['stream'] != null) {
        request.files.add(
          MultipartFile(
            "blog",
            data["stream"],
            data["length"],
            filename: data["filename"],
          ),
        );
      }
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        context.read<LoaderController>().isLoading = false;
        Routes.popPage();
        var result = json.decode(await response.stream.bytesToString());
        showMessage(
          msg: result['message'],
          color: Colors.green[900],
        );
      } else {
        context.read<LoaderController>().isLoading = false;
        var result = json.decode(await response.stream.bytesToString());
        showMessage(msg: result['message']);
      }
    } on Exception catch (e, _) {
      context.read<LoaderController>().isLoading = false;
      debugPrint("Error $_");
    }
  }
}
