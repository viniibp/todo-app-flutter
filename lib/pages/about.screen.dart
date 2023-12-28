import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'ToDo App',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('lib/assets/about-masthead.png', height: 220),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            'Aplicativo feito para o teste técnico em Flutter!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        itemChecked(title: 'Listagem de tarefas com filtros'),
        itemChecked(title: 'BloC Cubit State Manager'),
        itemChecked(title: 'SQLite (persistência de dados)'),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          onPressed: () async {
            final uri = Uri.parse("https://next.tec.br");
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          icon: const Icon(Icons.travel_explore_rounded),
          label: const Text('Next Tecnologia'),
        )
      ],
    );
  }

  Widget itemChecked({title}) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
      ),
      value: true,
      onChanged: (value) {},
      checkColor: Colors.white70,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
