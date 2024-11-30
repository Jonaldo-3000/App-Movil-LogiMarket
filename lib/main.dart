import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App-LogiMarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BienvenidoPage(),
    );
  }
}

class BienvenidoPage extends StatelessWidget {
  const BienvenidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDE3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IMAGEN
            Image.asset(
              'assets/gato.png',
              height: 250,
            ),
            const SizedBox(height: 4),
            Image.asset(
              'assets/titulos/bienvenido.png',
              height: 150,
            ),
            const SizedBox(height: 16),

            // BOTÓN "INICIAR SESIÓN"
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // BOTÓN "REGÍSTRATE"
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text(
                  "Regístrate",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool passwordVisible = false;

  // Lista de usuarios
  final Map<String, String> _users = {
    'usu': '000',
  };

  void _login() {
    final String user = userController.text.trim();
    final String password = passwordController.text.trim();

    if (user.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Por favor completa todos los campos.";
      });
      return;
    }

    if (_users.containsKey(user) && _users[user] == password) {
      setState(() {
        errorMessage = "Inicio de sesión exitoso!";
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage(title: "Home")),
      );
    } else {
      setState(() {
        errorMessage = "Usuario o contraseña inválidos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDE3), // Fondo beige
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen
              Image.asset(
                'assets/gato2.png',
                height: 280,
              ),
              const SizedBox(height: 20),

              // Campo de usuario
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  labelText: "User name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 12),

              // Campo de contraseña
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // Opción "¿Olvidaste tu contraseña?"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RecoverPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 80, 85),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Botón "Iniciar Sesión"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: _login,
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Mensaje de error
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),

              // Enlace para registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Si no tienes cuenta, registrate ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "aquí",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      )),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController empresaController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  String? _selectedRole;

  void _register() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();
    final String user = userController.text.trim();
    final String dni = dniController.text.trim();
    final String ruc = rucController.text.trim();
    final String empresa = empresaController.text.trim();
    final String direccion = direccionController.text.trim();

    if (username.isEmpty ||
        password.isEmpty ||
        user.isEmpty ||
        dni.isEmpty ||
        ruc.isEmpty ||
        empresa.isEmpty ||
        direccion.isEmpty ||
        _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos.")),
      );
      return;
    }

    try {
      // URL de tu API local
      final url = Uri.parse('http://localhost:9091/usuario/crear');

      // Estructura del cuerpo de la solicitud
      final body = jsonEncode({
        'username': username,
        'password': password,
        'email': user,
        'dni': dni,
        'ruc': ruc,
        'role': _selectedRole,
        'empresa': empresa,
        'direccion': direccion,
      });

      // Cabeceras de la solicitud
      final headers = {
        'Content-Type': 'application/json',
      };

      // Envía la solicitud POST
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 201) {
        // Si el registro es exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro exitoso!")),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const HomePage(title: "Home")),
        );
      } else {
        // Maneja errores del servidor
        final error =
            jsonDecode(response.body)['error'] ?? "Error en el servidor.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      // Maneja errores de red
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo conectar al servidor.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDE3), // Fondo beige
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/titulos/register.png',
                  height: 40,
                ),
              ),
              const SizedBox(height: 8),

              // Crea un usuario
              const Text(
                "Crea un usuario",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),

              // Campo de usuario
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "User name",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: 12), // Reduce la altura
                ),
              ),
              const SizedBox(height: 8),

              // Crea una contraseña
              const Text(
                "Crea una contraseña",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              // Dirección de correo electrónico
              const Text(
                "Dirección de e-mail",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: "Correo",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              // DNI y RUC
              const Text(
                "Ingrese su DNI                                   Ruc de la empresa",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: dniController,
                      decoration: const InputDecoration(
                        labelText: "Dni",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: rucController,
                      decoration: const InputDecoration(
                        labelText: "Ruc",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Selección de rol
              const Text(
                "Su empresa es",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 0),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Proveedor"),
                      value: "Proveedor",
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Bodeguero"),
                      value: "Bodeguero",
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 0),

              // Nombre de la empresa
              const Text(
                "Nombre de la empresa",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: empresaController,
                decoration: const InputDecoration(
                  labelText: "Empresa",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              // Dirección
              const Text(
                "Dirección",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: direccionController,
                decoration: const InputDecoration(
                  labelText: "Dirección",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Botón de registro
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Regístrate",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  String message = '';

  void _recoverPassword() {
    final String email = emailController.text.trim();
    if (email.isNotEmpty) {
      setState(() {
        message =
            'Instrucciones para recuperar la contraseña han sido enviadas a $email';
      });
    } else {
      setState(() {
        message = 'Por favor ingrese su email.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Contraseña"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese su email para recuperar contraseña',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _recoverPassword,
                child: const Text("Recuperar Contraseña"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  void _navigateToProveedor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProveedorPage()),
    );
  }

  void _navigateToBodeguero(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BodegueroPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToProveedor(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: const Text(
                "Proveedor",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToBodeguero(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: const Text(
                "Bodeguero",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProveedorPage extends StatefulWidget {
  const ProveedorPage({super.key});

  @override
  _ProveedorPageState createState() => _ProveedorPageState();
}

class _ProveedorPageState extends State<ProveedorPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(
        child: Text('Vista de Home Proveedor', style: TextStyle(fontSize: 24))),
    const Center(
        child:
            Text('Vista de Perfil Proveedor', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proveedor"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class BodegueroPage extends StatefulWidget {
  const BodegueroPage({super.key});

  @override
  _BodegueroPageState createState() => _BodegueroPageState();
}

class _BodegueroPageState extends State<BodegueroPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tus proveedores',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProveedoresPage(),
                        ),
                      );
                    },
                    child: const Text("Ver más>"),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'assets/Logos/Backus.png',
                  //width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/Logos/gloria.png',
                  //width: 125,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/Logos/laive.png',
                  //width: 125,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/Logos/san jorge.png',
                  //width: 125,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Promociones para ti',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PromocionesPage(),
                        ),
                      );
                    },
                    child: const Text("Ver más>"),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/promocion.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/promos/descuento.png',
                  //width: 175,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categorias',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CategoriasPage(),
                        ),
                      );
                    },
                    child: const Text("Ver más>"),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'assets/categorias/lacteos.png',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/categorias/snacks.png',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/categorias/aseo.png',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/categorias/gaseosas.png',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tus últimas compras',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UltimasComprasPage(),
                        ),
                      );
                    },
                    child: const Text("Ver más>"),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
    const InventarioPage(),
    const Center(
      child: Text(
        'Vista de Carrito de Compra Bodeguero',
        style: TextStyle(fontSize: 24),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Hola Bodeguero',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditPerfilPage(),
                    ),
                  );
                },
                child: const Text("Editar Perfil"),
              );
            },
          ),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  _InventarioPageState createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  late List<Map<String, dynamic>> filteredProductos;

  @override
  void initState() {
    super.initState();
    filteredProductos = ProductRepository().productos;
    searchController.addListener(_filterProductos);
  }

  @override
  void dispose() {
    searchController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _filterProductos() {
    setState(() {
      final query = searchController.text.toLowerCase();
      filteredProductos = ProductRepository()
          .productos
          .where((producto) =>
              producto['descripcion'].toLowerCase().contains(query))
          .toList();
    });
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Añadir Producto"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Precio",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (descriptionController.text.isNotEmpty &&
                    double.tryParse(priceController.text) != null) {
                  setState(() {
                    final newProduct = {
                      'descripcion': descriptionController.text,
                      'precio': double.parse(priceController.text),
                    };
                    ProductRepository().addProduct(newProduct);
                    filteredProductos = ProductRepository().productos;
                  });
                  descriptionController.clear();
                  priceController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Por favor, completa todos los campos."),
                    ),
                  );
                }
              },
              child: const Text("Añadir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón "Nueva Venta"
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NuevaVentaPage(),
                  ),
                );
              },
              child: const Text("Generar Nueva Venta"),
            ),
          ),
          const SizedBox(height: 20),
          // Buscador de productos
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: "Buscar productos",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddProductDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Añadir Producto"),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProductos.length,
              itemBuilder: (context, index) {
                final producto = filteredProductos[index];
                return Card(
                  child: ListTile(
                    title: Text(producto['descripcion']),
                    trailing:
                        Text("\$${producto['precio'].toStringAsFixed(2)}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductRepository {
  static final ProductRepository _instance = ProductRepository._internal();

  factory ProductRepository() => _instance;

  ProductRepository._internal();

  final List<Map<String, dynamic>> _productos = [];

  List<Map<String, dynamic>> get productos => _productos;

  void addProduct(Map<String, dynamic> producto) {
    _productos.add(producto);
  }
}

class NuevaVentaPage extends StatefulWidget {
  const NuevaVentaPage({super.key});

  @override
  _NuevaVentaPageState createState() => _NuevaVentaPageState();
}

class _NuevaVentaPageState extends State<NuevaVentaPage> {
  final TextEditingController cantidadController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, dynamic>?
      productoSeleccionado; // Variable para el producto seleccionado

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nueva venta",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HistorialPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Historial",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Campo de Fecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Fecha",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: _selectDate,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Seleccionar Fecha",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hora",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: _selectTime,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : "Seleccionar Hora",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Buscar producto en mi inventario:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          List<Map<String, dynamic>> productosFiltrados =
                              ProductRepository().productos;

                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                title: const Text("Buscar producto"),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Campo de búsqueda
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Escribe para buscar...",
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (query) {
                                          setState(() {
                                            productosFiltrados =
                                                ProductRepository()
                                                    .productos
                                                    .where((producto) =>
                                                        producto['descripcion']
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()))
                                                    .toList();
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      // Lista de productos filtrados
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: productosFiltrados.length,
                                          itemBuilder: (context, index) {
                                            final producto =
                                                productosFiltrados[index];
                                            return ListTile(
                                              title:
                                                  Text(producto['descripcion']),
                                              trailing: Text(
                                                  "\$${producto['precio'].toStringAsFixed(2)}"),
                                              onTap: () {
                                                // Asignar el producto seleccionado
                                                setState(() {
                                                  productoSeleccionado =
                                                      producto;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Cierra el diálogo
                                    },
                                    child: const Text("Cerrar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.search),
                    label: Text(
                      productoSeleccionado?['descripcion'] ?? "Buscar producto",
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: cantidadController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Cant.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Mostrar producto seleccionado
            if (productoSeleccionado != null) ...[
              const Text(
                "Producto seleccionado:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Descripción: ${productoSeleccionado!['descripcion']}"),
              Text(
                  "Precio: \$${productoSeleccionado!['precio'].toStringAsFixed(2)}"),
              const SizedBox(height: 20),
            ],

            // Botón Agregar
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (productoSeleccionado == null ||
                      cantidadController.text.isEmpty ||
                      int.tryParse(cantidadController.text) == null ||
                      int.tryParse(cantidadController.text)! <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Seleccione un producto y una cantidad válida."),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Producto \"${productoSeleccionado!['descripcion']}\" agregado con cantidad ${cantidadController.text}."),
                    ),
                  );

                  setState(() {
                    productoSeleccionado = null;
                    cantidadController.clear();
                  });
                },
                child: const Text("Agregar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial"),
      ),
      body: const Center(
        child: Text(
          "Aquí se mostrará el historial.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({super.key});

  @override
  _ProveedoresPageState createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  final List<Map<String, dynamic>> proveedoresFavoritos = [];
  final List<Map<String, dynamic>> todosLosProveedores = [
    {
      'image': 'assets/Logos/backus.png',
      'nombre': 'Backus',
      'productos': [
        {'nombre': 'Cerveza Cristal', 'categoria': 'Bebidas', 'precio': 5},
        {'nombre': 'Cerveza Pilsen', 'categoria': 'Bebidas', 'precio': 6},
      ],
      'promociones': [
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
      ]
    },
    {
      'image': 'assets/Logos/gloria.png',
      'nombre': 'Gloria',
      'productos': [
        {'nombre': 'Leche Evaporada', 'categoria': 'Lácteos', 'precio': 1.5},
        {'nombre': 'Yogurt Gloria', 'categoria': 'Lácteos', 'precio': 3},
      ],
      'promociones': [
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
      ]
    },
    {
      'image': 'assets/Logos/laive.png',
      'nombre': 'Laive',
      'productos': [
        {'nombre': 'Queso Edam', 'categoria': 'Lácteos', 'precio': 4},
        {'nombre': 'Mantequilla', 'categoria': 'Lácteos', 'precio': 2.5},
      ],
      'promociones': [
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
      ]
    },
    {
      'image': 'assets/Logos/san jorge.png',
      'nombre': 'San Jorge',
      'productos': [
        {'nombre': 'Galleta soda', 'categoria': 'Snacks', 'precio': 1},
        {'nombre': 'Black out', 'categoria': 'Snacks', 'precio': 2},
      ],
      'promociones': [
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
        'assets/promos/promocion.png',
        'assets/promos/descuento.png',
      ]
    },
  ];

  void handleFavoritoChanged(Map<String, dynamic> proveedor, bool isFavorito) {
    setState(() {
      if (isFavorito) {
        if (!proveedoresFavoritos.contains(proveedor)) {
          proveedoresFavoritos.add(proveedor);
        }
      } else {
        proveedoresFavoritos.remove(proveedor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proveedores"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CarritoPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Proveedores Favoritos",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              _buildCarrusel(context, proveedoresFavoritos),
              const SizedBox(height: 8),
              const Text(
                "Todos los Proveedores",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              _buildCarrusel(context, todosLosProveedores),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarrusel(
      BuildContext context, List<Map<String, dynamic>> proveedores) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: proveedores.map((proveedor) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Image.asset(
                  proveedor['image']!,
                  //width: 75,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5),
                Text(
                  proveedor['nombre']!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetallesProveedorPage(
                          proveedor: proveedor,
                          isFavorito: proveedoresFavoritos.contains(proveedor),
                          onFavoritoChanged: handleFavoritoChanged,
                        ),
                      ),
                    );
                  },
                  child: const Text("Detalles"),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DetallesProveedorPage extends StatefulWidget {
  final Map<String, dynamic> proveedor;
  final bool isFavorito;
  final Function(Map<String, dynamic>, bool) onFavoritoChanged;

  const DetallesProveedorPage({
    super.key,
    required this.proveedor,
    required this.isFavorito,
    required this.onFavoritoChanged,
  });

  @override
  _DetallesProveedorPageState createState() => _DetallesProveedorPageState();
}

class _DetallesProveedorPageState extends State<DetallesProveedorPage> {
  late bool isFavorito;

  @override
  void initState() {
    super.initState();
    isFavorito = widget.isFavorito; // Inicializa el estado de favorito
  }

  void toggleFavorito() {
    setState(() {
      isFavorito = !isFavorito;
    });
    widget.onFavoritoChanged(widget.proveedor, isFavorito);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> promociones = widget.proveedor['promociones'];
    final List<Map<String, dynamic>> productos = widget.proveedor['productos'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del proveedor con texto al lado
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centrado vertical
              children: [
                // Texto al lado de la imagen
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Proveedor",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Nombre del proveedor
                          Expanded(
                            child: Text(
                              widget.proveedor['nombre']!,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Manejo de texto largo
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16), // Espaciado extra entre nombre y estrella

                          // Botón de favorito
                          IconButton(
                            icon: Icon(
                              isFavorito ? Icons.star : Icons.star_border,
                              color: isFavorito ? Colors.yellow : Colors.grey,
                            ),
                            onPressed:
                                toggleFavorito, // Lógica para marcar como favorito
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 200), // Espaciado entre imagen y texto
                // Imagen del proveedor
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50.0), // Bordes redondeados
                  child: Image.asset(
                    widget.proveedor['image']!,
                    height: 85, // Tamaño de la imagen
                    //width: 100, // Cuadrada
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16), // Espaciado entre imagen y texto
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Promociones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            CarouselSlider(
              options: CarouselOptions(
                height: 150, // Altura del carrusel
                autoPlay: true, // Activar el auto-play
                enlargeCenterPage: true, // Resaltar la imagen central
                viewportFraction: 0.7, // Fracción visible de las imágenes
                autoPlayInterval:
                    const Duration(seconds: 3), // Intervalo de auto-play
              ),
              items: promociones.map((promo) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(promo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              "Productos que ofrece",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return Card(
                    child: ListTile(
                      title: Text(producto['nombre']),
                      subtitle: Text("Categoría: ${producto['categoria']}"),
                      trailing: Text("\$${producto['precio']}"),
                      onTap: () {
                        _mostrarDialogoCarrito(
                            context, producto, widget.proveedor['nombre']);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _mostrarDialogoCarrito(
    BuildContext context, Map<String, dynamic> producto, String proveedor) {
  final TextEditingController cantidadController =
      TextEditingController(text: '1');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Añadir al carrito"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final int cantidad = int.tryParse(cantidadController.text) ?? 1;
            final double precioTotal =
                cantidad * (producto['precio'] as num).toDouble();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Precio unitario: \$${producto['precio']}"),
                const SizedBox(height: 10),
                TextField(
                  controller: cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cantidad",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Precio total: \$${precioTotal.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final int cantidad = int.tryParse(cantidadController.text) ?? 1;

              if (cantidad > 0) {
                Carrito.addProducto({
                  ...producto,
                  'cantidad': cantidad,
                  'proveedor': proveedor,
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${producto['nombre']} añadido al carrito."),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Por favor, ingrese una cantidad válida."),
                  ),
                );
              }
            },
            child: const Text("Añadir"),
          ),
        ],
      );
    },
  );
}

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> productosPorProveedor = {};

    for (var producto in Carrito.productos) {
      final proveedor = producto['proveedor'];
      if (!productosPorProveedor.containsKey(proveedor)) {
        productosPorProveedor[proveedor] = [];
      }
      productosPorProveedor[proveedor]!.add(producto);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrito de Compra"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: productosPorProveedor.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key), // Nombre del proveedor
                  children: entry.value.map((producto) {
                    return ListTile(
                      title: Text(producto['nombre']),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                Carrito.updateCantidad(
                                    producto, producto['cantidad'] - 1);
                              });
                            },
                          ),
                          Text("Cantidad: ${producto['cantidad']}"),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                Carrito.updateCantidad(
                                    producto, producto['cantidad'] + 1);
                              });
                            },
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$${(producto['precio'] * producto['cantidad']).toStringAsFixed(2)}",
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                Carrito.removeProducto(producto);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Producto eliminado del carrito."),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                _mostrarDialogoPago(context, productosPorProveedor);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total a pagar:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${Carrito.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoPago(
    BuildContext context,
    Map<String, List<Map<String, dynamic>>> productosPorProveedor,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Completar Pago"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...productosPorProveedor.entries.map((entry) {
                final totalPorProveedor = entry.value.fold<double>(
                  0.0,
                  (sum, item) => sum + (item['precio'] * item['cantidad']),
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text("\$${totalPorProveedor.toStringAsFixed(2)}"),
                  ],
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                _mandarPedido();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pedido enviado correctamente."),
                  ),
                );
              },
              child: const Text("Mandar Pedido"),
            ),
          ],
        );
      },
    );
  }

  void _mandarPedido() {
    setState(() {
      Carrito.clear();
    });
  }
}

class Carrito {
  static final List<Map<String, dynamic>> _productos = [];

  static void addProducto(Map<String, dynamic> producto) {
    _productos.add(producto);
  }

  static void removeProducto(Map<String, dynamic> producto) {
    _productos.remove(producto);
  }

  static void updateCantidad(Map<String, dynamic> producto, int nuevaCantidad) {
    final index = _productos.indexWhere((p) => p == producto);
    if (index != -1 && nuevaCantidad > 0) {
      _productos[index]['cantidad'] = nuevaCantidad;
    } else if (nuevaCantidad <= 0) {
      removeProducto(producto);
    }
  }

  static List<Map<String, dynamic>> get productos {
    return _productos;
  }

  static double get total {
    return _productos.fold(0, (sum, item) {
      return sum + item['precio'] * item['cantidad'];
    });
  }

  static void clear() {
    _productos.clear();
  }
}

class PromocionesPage extends StatelessWidget {
  PromocionesPage({super.key});

  final List<String> imagenes = [
    'assets/promocion.png',
    'assets/descuento.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Promociones y Descuentos",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Promociones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/promocion.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Descuentos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/promos/descuento.png',
                    //width: 175,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Categorias",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class UltimasComprasPage extends StatelessWidget {
  const UltimasComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tus Últimas Compras"),
      ),
      body: const Center(
        child: Text("Detalles de las últimas compras"),
      ),
    );
  }
}

class EditPerfilPage extends StatelessWidget {
  const EditPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
      ),
      body: const Center(
        child: Text("Edición de perfil"),
      ),
    );
  }
}
