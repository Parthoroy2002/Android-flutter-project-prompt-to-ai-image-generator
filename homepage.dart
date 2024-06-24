import 'package:flutter/material.dart';
import 'screen2.dart';
import 'convert_text_to_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textController = TextEditingController();
  bool isLoading = false;

  Future<void> _generateImage() async {
    setState(() {
      isLoading = true;
    });

    final prompt = textController.text;
    final imageData = await convertTextToImage(prompt, context);

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(imageData: imageData, prompt: prompt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.purpleAccent,
      minimumSize: const Size(200, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://wallpaper.dog/large/20407305.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ᗯᖇITE YOᑌᖇ ᑭᖇOᗰᑭT ᕼEᖇE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.3),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '',
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the TextField and the button
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: _generateImage,
                child: const Text(
                  'Generate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
