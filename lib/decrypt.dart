import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DecryptThis extends HookConsumerWidget {
  const DecryptThis({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final keyController = useTextEditingController();
    final encrypted = useState('');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: 'Masukan text yang ingin di dekripsi',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
              fillColor: Colors.red,
              filled: false,
            ),
            onChanged: (val) async {
              if (controller.text.isNotEmpty && keyController.text.isNotEmpty) {
                encrypted.value =
                    decryptAES(controller.text, keyController.text);
              } else {
                encrypted.value = 'Masukan Text dan SecretKey';
              }
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: keyController,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Masukan SecretKey',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              fillColor: Colors.red,
              filled: false,
            ),
            onChanged: (val) async {
              if (controller.text.isNotEmpty && keyController.text.isNotEmpty) {
                encrypted.value =
                    decryptAES(controller.text, keyController.text);
              } else if (keyController.text.length < 32) {
                encrypted.value = 'SecretKey harus berjumlah 32 karakter';
              } else {
                encrypted.value = 'Masukan Text dan SecretKey';
              }
            },
          ),
        ),
        Text(encrypted.value),
        TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: encrypted.value));
            },
            child: const Text(
              'Copy',
              style: TextStyle(
                color: Colors.black,
              ),
            ))
      ],
    );
  }
}

String decryptAES(plainText, skey) {
  final key = encrypt.Key.fromUtf8(skey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final decrypted =
      encrypter.decrypt(encrypt.Encrypted.fromBase64(plainText), iv: iv);
  return decrypted;
}
