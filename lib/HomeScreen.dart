import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class ViewScreen extends StatefulWidget {
//   const ViewScreen({super.key});
//
//   @override
//   State<ViewScreen> createState() => _ViewScreenState();
// }
//
// class _ViewScreenState extends State<ViewScreen> {
//   late List<String> imageUrls;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the list of image URLs when the screen loads
//     imageUrls = [];
//     getImages(); // Call method to fetch image URLs
//   }
//
//   Future<void> getImages() async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     ListResult result = await storage.ref().child('images/').listAll();
//     List<String> urls = [];
//     await Future.forEach(result.items, (Reference ref) async {
//       String url = await ref.getDownloadURL();
//       urls.add(url);
//     });
//     setState(() {
//       imageUrls = urls;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Images'),
//       ),
//       body: ListView.builder(
//         itemCount: imageUrls.length,
//         itemBuilder: (context, index) {
//           String imageUrl = imageUrls[index];
//           return ListTile(
//             title: Text('Image ${index + 1}'),
//             leading: Image.network(
//               imageUrl,
//               width: 200,
//               height: 200,
//               fit: BoxFit.fill ,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(color: Colors.red); // Placeholder image to show if there's an error loading the image
//               },
//             ),
//             onTap: () {
//               // Handle tap on image item if needed
//             },
//           );
//         },
//       ),
//
//
//     );
//   }
// }


class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late List<String> imageUrls;

  @override
  void initState() {
    super.initState();
    // Initialize the list of image URLs when the screen loads
    imageUrls = [];
    getImages(); // Call method to fetch image URLs
  }

  Future<void> getImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref().child('images/').listAll();
    List<String> urls = [];
    await Future.forEach(result.items, (Reference ref) async {
      String url = await ref.getDownloadURL();
      urls.add(url);
    });
    setState(() {
      imageUrls = urls;
    });
  }

  Future<void> deleteImage(String imageUrl) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.refFromURL(imageUrl).delete();
    // Remove the deleted image URL from the list
    setState(() {
      imageUrls.remove(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Images'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          String imageUrl = imageUrls[index];
          return Column(
            children: [
              SizedBox(height: 25,),
              ListTile(
                title: Text('Image ${index + 1}'),
                leading: SizedBox(
                  width: 300,
                  height: 800,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 800,
                    width: 300,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.red,
                      ); // Placeholder image to show if there's an error loading the image
                    },
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Image?'),
                          content: Text('Are you sure you want to delete this image?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteImage(imageUrl);
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                onTap: () {
                  // Handle tap on image item if needed
                },
              ),
              SizedBox(height: 10), // Add spacing between list items
            ],
          );
        },
      ),


    );
  }
}






