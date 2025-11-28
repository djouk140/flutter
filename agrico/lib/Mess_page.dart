import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// 👉 Mets ta clé API dans consts.dart puis importe ici
// Exemple dans consts.dart :
// const String GEMINI_API_KEY = "ta_cle_api_google";
import '../consts.dart';

class Mess_Page extends StatefulWidget {
  final User? user;

  const Mess_Page({Key? key, this.user}) : super(key: key);

  @override
  State<Mess_Page> createState() => _MessPageState();
}

class _MessPageState extends State<Mess_Page> {
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Utilisateur');

  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'Gemini');

  List<ChatMessage> _messages = [];
  bool _isTyping = false;

  late GenerativeModel _model;

  @override
  void initState() {
    super.initState();

    // ⚡ Utilisation du modèle correct
    _model = GenerativeModel(
      model: 'gemini-1.5-flash', // ✅ rapide et gratuit
      apiKey: GEMINI_API_KEY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Affiche l’email Firebase si dispo
        title: Text('MESSAGERIE ${widget.user?.email ?? ""}'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.black87,
      ),
      body: DashChat(
        currentUser: _currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black87,
          containerColor: Colors.green,
          textColor: Colors.white,
        ),
        onSend: (m) => getGeminiResponse(m),
        messages: _messages,
        typingUsers: _isTyping ? [_gptChatUser] : [],
      ),
    );
  }

  Future<void> getGeminiResponse(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    try {
      final content = [Content.text(message.text)];
      final response = await _model.generateContent(content);

      final reply = response.text ?? "Je n’ai pas de réponse.";

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: reply,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: "Erreur: $e",
          ),
        );
      });
    } finally {
      setState(() => _isTyping = false);
    }
  }
}
