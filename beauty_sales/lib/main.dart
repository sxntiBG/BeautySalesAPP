import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  Future<void> _login() async {
    const String api = 'https://apiindividual.onrender.com/api/usuarios';
    final String nombre = _nombreController.text;
    final String contrasena = _contrasenaController.text;

    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final List<dynamic> usuarios = json.decode(response.body);

      for (var usuario in usuarios) {
        if (usuario['nombre'] == nombre &&
            usuario['contraseña'] == contrasena) {
          // Iniciar sesión exitoso
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          return;
        }
      }

      // Nombre o contraseña incorrectos
      alertaEmergente('Nombre o contraseña incorrectos');
    } else {
      // Error en la solicitud HTTP
      alertaEmergente('Error en la solicitud HTTP');
    }
  }

  void alertaEmergente(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3), // Duración del SnackBar
        backgroundColor:
            const Color(0xFFfeb4a6), // Color de fondo personalizado
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        centerTitle: true,
        backgroundColor: const Color(0xFFfeb4a6),
      ),
      backgroundColor: const Color.fromARGB(255, 52, 53, 65),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/BeautySales.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '¡Bienvenido/a a Beauty Sales!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Agrega esta línea para cambiar el color a blanco
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                labelStyle: TextStyle(
                  color: Color(0xFFfeb4a6), // Color del texto del label
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFFfeb4a6), // Color del ícono
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                          0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                ),
              ),
              style: const TextStyle(
                color: Colors.white, // Color del texto ingresado
              ),
            ),
            TextField(
              controller: _contrasenaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  color: Color(0xFFfeb4a6), // Color del texto del label
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFFfeb4a6), // Color del icono
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                          0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                ),
              ),
              style: const TextStyle(
                color: Colors.white, // Color del texto ingresado
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFfeb4a6),
              ),
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFFfeb4a6),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: _cerrarSesion,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 52, 53, 65),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/BeautySales.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                      double.infinity, // Ajusta el ancho al máximo disponible
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          20), // Ajusta el espacio horizontal entre los botones
                  child: ElevatedButton(
                    onPressed: _crearNuevoRol,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFfeb4a6),
                    ),
                    child: const Text('Crear Nuevo Rol'),
                  ),
                ),
                const SizedBox(
                    height: 20), // Ajusta el espacio vertical entre los botones
                Container(
                  width:
                      double.infinity, // Ajusta el ancho al máximo disponible
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          20), // Ajusta el espacio horizontal entre los botones
                  child: ElevatedButton(
                    onPressed: _listarRoles,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFfeb4a6),
                    ),
                    child: const Text('Listar Roles'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _crearNuevoRol() {
    // Navegar a la pantalla para crear un nuevo rol
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearRolScreen()),
    );
  }

  void _listarRoles() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListarRolesScreen()),
    );
  }

  void _cerrarSesion() {
    // Lógica para cerrar sesión y volver a la pantalla de inicio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}

class CrearRolScreen extends StatefulWidget {
  const CrearRolScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CrearRolScreenState createState() => _CrearRolScreenState();
}

class _CrearRolScreenState extends State<CrearRolScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();

  bool _productos = false;
  bool _ventas = false;
  bool _compras = false;
  bool _proveedores = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nuevo Rol'),
        backgroundColor: const Color(0xFFfeb4a6),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 53, 65),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'ID del Rol',
                  labelStyle: TextStyle(
                    color: Color(0xFFfeb4a6), // Color del texto del label
                  ),
                  prefixIcon: Icon(
                    Icons.insert_emoticon_rounded,
                    color: Color(0xFFfeb4a6),
                  ), // Icono de ID
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white, // Color del texto ingresado
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el ID del Rol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Rol',
                  labelStyle: TextStyle(
                    color: Color(0xFFfeb4a6), // Color del texto del label
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                  ),
                  prefixIcon: Icon(
                    Icons.insert_emoticon_rounded,
                    color: Color(0xFFfeb4a6),
                  ), // Icono de Nombre
                ),
                style: const TextStyle(
                  color: Colors.white, // Color del texto ingresado
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el Nombre del Rol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: _productos,
                onChanged: (bool? value) {
                  setState(() {
                    _productos = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                checkColor: Colors.white, // Color del check dentro del checkbox
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(
                    0.1), // Color de fondo del ListTile cuando está seleccionado
              ),
              CheckboxListTile(
                title: const Text(
                  'Ventas',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: _ventas,
                onChanged: (bool? value) {
                  setState(() {
                    _ventas = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),

                /// Color de fondo del ListTile cuando está seleccionado
              ),
              CheckboxListTile(
                title: const Text(
                  'Compras',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: _compras,
                onChanged: (bool? value) {
                  setState(() {
                    _compras = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),

                /// Color de fondo del ListTile cuando está seleccionado
              ),
              CheckboxListTile(
                title: const Text(
                  'Proveedores',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: _proveedores,
                onChanged: (bool? value) {
                  setState(() {
                    _proveedores = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),

                /// Color de fondo del ListTile cuando está seleccionado
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarNuevoRol,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFfeb4a6), // Color del botón
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardarNuevoRol() async {
    if (_formKey.currentState!.validate()) {
      const String apiUrl = 'https://apiindividual.onrender.com/api/roles';

      final String idRol = _idController.text;
      final String nombreRol = _nombreController.text;

      final Map<String, dynamic> rolData = {
        'id': idRol,
        'nombre': nombreRol,
        'productos': _productos,
        'ventas': _ventas,
        'compras': _compras,
        'proveedores': _proveedores,
      };

      try {
        final http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(rolData),
        );

        if (response.statusCode == 200) {
          // Éxito en la solicitud POST
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nuevo rol creado con éxito'),
              duration: Duration(seconds: 3), // Duración del SnackBar
              backgroundColor:
                  Color(0xFFfeb4a6), // Color de fondo personalizado
            ),
          );

          // Limpiar el formulario
          _idController.clear();
          _nombreController.clear();
          setState(() {
            _productos = false;
            _ventas = false;
            _compras = false;
            _proveedores = false;
          });
        } else {
          // Error en la solicitud POST
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error en la solicitud POST'),
              duration: Duration(seconds: 3), // Duración del SnackBar
              backgroundColor:
                  Color(0xFFfeb4a6), // Color de fondo personalizado
            ),
          );
        }
      } catch (e) {
        // Error al realizar la solicitud
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error'),
            duration: Duration(seconds: 3), // Duración del SnackBar
            backgroundColor: Color(0xFFfeb4a6), // Color de fondo personalizado
          ),
        );
      }
    }
  }
}

class ListarRolesScreen extends StatefulWidget {
  const ListarRolesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListarRolesScreenState createState() => _ListarRolesScreenState();
}

class _ListarRolesScreenState extends State<ListarRolesScreen> {
  late Future<List<Map<String, dynamic>>> _roles;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _roles = _fetchRoles();
  }

  Future<List<Map<String, dynamic>>> _fetchRoles() async {
    const apiUrl = 'https://apiindividual.onrender.com/api/roles';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> roles = json.decode(response.body);
      return List<Map<String, dynamic>>.from(roles);
    } else {
      throw Exception('Error en la solicitud HTTP');
    }
  }

  List<Map<String, dynamic>> filtrarRoles(
      List<Map<String, dynamic>> roles, String query) {
    return roles.where((role) {
      final nombre = role['nombre'].toLowerCase();
      return nombre.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Roles'),
        backgroundColor: const Color(0xFFfeb4a6),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 53, 65),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _roles = _fetchRoles(); // Resetear la lista
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre',
                labelStyle: TextStyle(
                  color: Color(0xFFfeb4a6), // Color del texto del label
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFfeb4a6), // Color del icono
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                          0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                ),
              ),
              style: const TextStyle(
                color: Colors.white, // Color del texto ingresado
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _roles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<Map<String, dynamic>> roles = filtrarRoles(
                      snapshot.data as List<Map<String, dynamic>>,
                      _searchController.text);

                  return ListView.builder(
                    itemCount: roles.length,
                    itemBuilder: (context, index) {
                      final role = roles[index];
                      return Card(
                        color: const Color.fromRGBO(254, 235, 231, 1.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                role['nombre'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('ID: ${role['id']}'),
                              const SizedBox(height: 4),
                              Text('Productos: ${role['productos']}'),
                              Text('Ventas: ${role['ventas']}'),
                              Text('Compras: ${role['compras']}'),
                              Text('Proveedores: ${role['proveedores']}'),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditarRolScreen(role: role),
                                        ),
                                      );
                                    },
                                    child: const Text('Editar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      eliminarRegistro(context, role['_id']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EditarRolScreen extends StatefulWidget {
  final Map<String, dynamic> role;

  const EditarRolScreen({super.key, required this.role});

  @override
  // ignore: library_private_types_in_public_api
  _EditarRolScreenState createState() => _EditarRolScreenState();
}

class _EditarRolScreenState extends State<EditarRolScreen> {
  late TextEditingController nombreController;
  late bool productos;
  late bool ventas;
  late bool compras;
  late bool proveedores;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.role['nombre']);
    productos = widget.role['productos'];
    ventas = widget.role['ventas'];
    compras = widget.role['compras'];
    proveedores = widget.role['proveedores'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Rol'),
        backgroundColor: const Color(0xFFfeb4a6),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 53, 65),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Rol',
                  labelStyle: TextStyle(
                    color: Color(0xFFfeb4a6), // Color del texto del label
                  ),
                  prefixIcon: Icon(
                    Icons.insert_emoticon_rounded,
                    color: Color(0xFFfeb4a6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFFfeb4a6)), // Color de la barra inferior cuando se selecciona
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white, // Color del texto ingresado
                ),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: productos,
                onChanged: (bool? value) {
                  setState(() {
                    productos = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                checkColor: Colors.white, // Color del check dentro del checkbox
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),
              ),
              CheckboxListTile(
                title: const Text(
                  'Ventas',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: ventas,
                onChanged: (bool? value) {
                  setState(() {
                    ventas = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                checkColor: Colors.white, // Color del check dentro del checkbox
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),
              ),
              CheckboxListTile(
                title: const Text(
                  'Compras',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: compras,
                onChanged: (bool? value) {
                  setState(() {
                    compras = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                checkColor: Colors.white, // Color del check dentro del checkbox
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),
              ),
              CheckboxListTile(
                title: const Text(
                  'Proveedores',
                  style: TextStyle(
                    color: Colors.white, // Color del título
                  ),
                ),
                value: proveedores,
                onChanged: (bool? value) {
                  setState(() {
                    proveedores = value ?? false;
                  });
                },
                activeColor: const Color(
                    0xFFfeb4a6), // Color del checkbox cuando está seleccionado
                checkColor: Colors.white, // Color del check dentro del checkbox
                selectedTileColor: const Color(0xFFfeb4a6).withOpacity(0.1),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _editarRol(
                    widget.role['_id'],
                    nombreController.text,
                    productos,
                    ventas,
                    compras,
                    proveedores,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFfeb4a6), // Color del botón
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editarRol(
    String id,
    String nuevoNombre,
    bool nuevosProductos,
    bool nuevasVentas,
    bool nuevasCompras,
    bool nuevosProveedores,
  ) async {
    final apiUrl = 'https://apiindividual.onrender.com/api/roles/$id';

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nombre': nuevoNombre,
        'productos': nuevosProductos,
        'ventas': nuevasVentas,
        'compras': nuevasCompras,
        'proveedores': nuevosProveedores,
      }),
    );

    if (response.statusCode == 200) {
      // La edición fue exitosa
      alertaEmergente('Rol editado exitosamente');
    } else {
      // Hubo un error en la edición
      alertaEmergente('Error al editar el rol');
    }
  }

  void alertaEmergente(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3), // Duración del SnackBar
        backgroundColor:
            const Color(0xFFfeb4a6), // Color de fondo personalizado
      ),
    );
  }
}

Future<void> eliminarRegistro(BuildContext context, String id) async {
  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Está seguro de eliminar este registro?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _eliminarRegistro(id, context);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  try {
    await _showConfirmationDialog();
  } catch (error) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al mostrar el diálogo de confirmación'),
      ),
    );
  }
}

Future<void> _eliminarRegistro(String id, BuildContext context) async {
  final url = 'https://apiindividual.onrender.com/api/roles/$id';

  try {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro eliminado con éxito'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error al eliminar el registro. Código de estado: ${response.statusCode}'),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mensaje de error: ${response.body}'),
        ),
      );
    }
  } catch (error) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error de red: $error'),
      ),
    );
  }
}
