import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Uint8List?> convertTextToImage(String prompt, BuildContext context) async {
  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse(''
      '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer sk-jwQuDqNNjGxQLMGU3akH46fnH6uorXI0AP9oAMCMEnSKlQSG',
      'Accept': 'image/png',
    },
    body: jsonEncode({
      'cfg_scale': 15,
      'clip_guidance_preset': 'FAST_BLUE',
      'height': 512,
      'width': 512,
      'samples': 1,
      'steps': 150,
      'seed': 0,
      'style_preset': "3d-model",
      'text_prompts': [
        {
          'text': prompt,
          'weight': 1,
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    return null;
  }
}
