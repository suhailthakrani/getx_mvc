import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_name': 'GetX App',
      'welcome': 'Welcome',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'logout': 'Logout',
      'home': 'Home',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'system_mode': 'System Mode',
    },
    'es_ES': {
      'app_name': 'Aplicación GetX',
      'welcome': 'Bienvenido',
      'login': 'Iniciar Sesión',
      'register': 'Registrarse',
      'email': 'Correo electrónico',
      'password': 'Contraseña',
      'logout': 'Cerrar sesión',
      'home': 'Inicio',
      'settings': 'Ajustes',
      'language': 'Idioma',
      'theme': 'Tema',
      'dark_mode': 'Modo oscuro',
      'light_mode': 'Modo claro',
      'system_mode': 'Modo sistema',
    },
  };
}