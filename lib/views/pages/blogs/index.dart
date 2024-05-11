import "/exports/exports.dart";

class IndexBlogs extends StatefulWidget {
  final String leagueName;
  final String leagueId;
  const IndexBlogs(
      {super.key, required this.leagueName, required this.leagueId});

  @override
  State<IndexBlogs> createState() => _IndexBlogsState();
}

class _IndexBlogsState extends State<IndexBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.leagueName}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Blogs",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: Consumer<DataController>(
        builder: (context, controller, child) {
          controller.fetchBlogs(widget.leagueId);
          var blogs = controller.blogs;
          return blogs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.article_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "No blogs available",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    var blog = blogs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          blogs[index].image,
                        ),
                      ),
                      title: Text(blog.title),
                      subtitle: Text(
                        blog.content,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      onLongPress: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => AlertDialog.adaptive(
                            title: const Text("Delete blog"),
                            content: Text(
                                "Are you sure you want to delete ${blog.title}?"),
                            actions: [
                              TextButton(
                                onPressed: () => Routes.popPage(),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    BlogService.deleteBlog(blog.id),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Routes.animateToPage(
                          EditBlog(blog: blog),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Routes.animateToPage(
          AddBlog(league: widget.leagueId),
        ),
        icon: const Icon(Icons.add),
        label: Text("Add a blog", style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
