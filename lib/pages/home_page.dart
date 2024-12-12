import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'image_generator_provider.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AIProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 230, 0),
        centerTitle: true,
        title: Text(
          'NOVAX  CHATBOT',
          style: GoogleFonts.poppins(
            fontSize: 30,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                style:
                    TextStyle(color: const Color.fromARGB(221, 225, 225, 225)),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 74, 74, 74),
                    labelText: 'Enter Prompt Here!',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 1, 169, 1))),
              ),
              const SizedBox(height: 20),
              Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      final enteredText = _controller.text;
                      aiProvider.fetchAIResponse(enteredText);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent, // Remove shadow
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.purple
                          ], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        child: const Text(
                          'Send Your Prompt',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:
                                Color.fromARGB(255, 36, 36, 36), // Text color
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 50),
              Stack(children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/robot-removebg-preview.png'),
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: aiProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : aiProvider.response != null
                          ? SingleChildScrollView(
                              child: Text(aiProvider.response!,
                                  style: GoogleFonts.openSans(
                                      color: const Color.fromARGB(210, 255, 255, 255))),
                            )
                          : const Center(
                              child: Text(
                                'Response will appear here.',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
