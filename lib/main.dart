import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'decrypt.dart';
import 'encypt.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: const Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CipherCrypt'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Encrypt',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.maxFinite,
              color: Colors.grey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: EncryptThis(),
              ),
            ),
            const Text(
              'Decrypt',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.maxFinite,
              color: Colors.grey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: DecryptThis(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// void _decryptText() {
//   final key = encrypt.Key.fromUtf8(_encryptionKey);
//   final iv = encrypt.IV.fromLength(16);
//   final encrypter = encrypt.Encrypter(encrypt.AES(key));
//   final encrypted = encrypt.Encrypted.fromBase64(_inputController.text);
//   final decrypted = encrypter.decrypt(encrypted, iv: iv);
//   _outputController.text = decrypted;
// }
