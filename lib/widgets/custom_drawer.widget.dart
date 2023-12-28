import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.currentScreen,
    required this.changeScreen,
  });

  final String currentScreen;
  final Function changeScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF002851),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Fechar menu de navegação',
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pinkAccent,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/profile-image.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bem vindo!',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            const SizedBox(height: 20),
            drawerButton(
              title: 'Home',
              screen: 'Home',
              icon: Icons.inbox,
            ),
            drawerButton(
              title: 'Sobre',
              screen: 'About',
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }

  ListTile drawerButton(
      {required String title, required String screen, required IconData icon}) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      onTap: () => changeScreen(screen),
      selected: screen == currentScreen,
      iconColor: Colors.grey,
      selectedTileColor: const Color(0xFF3b82f6),
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
