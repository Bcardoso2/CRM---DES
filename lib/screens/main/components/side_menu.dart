import 'package:admin/screens/Atividades_Screen.dart';
import 'package:admin/screens/campanhas_screen.dart';
import 'package:admin/screens/dizimo_screen.dart';
import 'package:admin/screens/documentos_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/patrimonio_screen.dart';
import 'package:admin/screens/perfil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/screens/FinanceiroScreen.dart'; // Adicione a importação

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.network("https://arquidiocesedebelem.com.br/wp-content/uploads/2017/01/arquidiocese.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()), // Implemente a navegação
              );
            },
          ),
          DrawerListTile(
            title: "Financeiro", // Novo item adicionado
            svgSrc: "assets/icons/menu_tran.svg", // Você precisará adicionar um ícone correspondente
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FinanceiroScreen()), // Navegar para a tela Financeiro
              );
            },
          ),
          // Mantenha os outros itens como estão...
          
          DrawerListTile(
            title: "Atividades",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AtividadesScreen()), // Navegação para Atividades
              );
            },
          ),
          DrawerListTile(
            title: "Documentos",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DocumentosScreen()), // Navegação para Atividades
              );
            },
          ),
          DrawerListTile(
            title: "Campanhas",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CampanhasScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Dizimo",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DizimosScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Patrimonio",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatrimonioScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Perfil",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
