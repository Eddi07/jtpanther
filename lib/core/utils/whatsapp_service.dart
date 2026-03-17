import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(String phone, String message) async {

  final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";

  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw "No se pudo abrir WhatsApp";
  }
}