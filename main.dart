import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 252, 247, 181),
      ),
      home: SplashScreen(), // Awali dengan SplashScreen
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/asset/logoapp2.png', // Ganti dengan path logo Anda
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Warkop Mobile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Login
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Contoh validasi login (hardcoded)
    if (_usernameController.text == "farrel" && _passwordController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username atau Password Tidak Sesuai")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[900]),
              onPressed: _login,
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                "Belum Punya Akun? Daftar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Sign Up
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    // Simulasi pendaftaran pengguna (bisa diganti dengan API backend)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account created successfully")),
    );
    Navigator.pop(context); // Kembali ke halaman login setelah Sign Up
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[900]),
              onPressed: _signUp,
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Daftar item keranjang
  List<Map<String, String>> cartItems = [];

  void _onMenuSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Menutup drawer setelah item dipilih
  }

  @override
  Widget build(BuildContext context) {
    // Opsi halaman berdasarkan index
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(onItemTap: (item) {
        setState(() {
          cartItems.add(item); // Tambahkan item ke keranjang
        });
        // Pindah ke halaman keranjang
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(cartItems: cartItems),
          ),
        );
      }),
      CartPage(cartItems: cartItems),
      ProfilePage(),
      VideoPage(),
      CalculatorPage(),
      ConverterPage(),
      ContactsPage(),
      CustomerServicePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text('Warkop Mobile'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header Profil
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('lib/asset/fotoprofil.jpg'), // Path gambar profil
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Farrel Arvin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Menu Drawer
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => _onMenuSelected(0),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Keranjang'),
              onTap: () => _onMenuSelected(1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => _onMenuSelected(2),
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Video'),
              onTap: () => _onMenuSelected(3),
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculator'),
              onTap: () => _onMenuSelected(4),
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text('Converter'),
              onTap: () => _onMenuSelected(5),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () => _onMenuSelected(6),
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('Customer Service'),
              onTap: () => _onMenuSelected(7),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(Map<String, String>) onItemTap;

  HomePage({required this.onItemTap});

  final List<Map<String, String>> foodItems = [
    {"title": "Indomie", "description": "6000.", "image": "lib/asset/indomie2.png"},
    {"title": "Nasi Telor", "description": "9000", "image": "lib/asset/telur2.png"},
    {"title": "Nasi Tempe", "description": "7000", "image": "lib/asset/tempe2.png"},
    {"title": "Kopi", "description": "3000", "image": "lib/asset/kopi2.png"},
    {"title": "Teh", "description": "4000", "image": "lib/asset/teh2.png"},
    {"title": "Susu", "description": "5000", "image": "lib/asset/susu2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Menu Makanan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            final item = foodItems[index];
            return GestureDetector(
              onTap: () => onItemTap(item), // Panggil callback saat kartu ditekan
              child: Card(
                color: Colors.blue[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.asset(
                          item['image'] ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['title'] ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item['description'] ?? "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Keranjang"),
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                "Keranjang Belanja Anda Kosong",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  color: Colors.blue[600],
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.asset(
                      item['image'] ?? '',
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      item['title'] ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      item['description'] ?? '',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Farrel Arvin";
  String description = "Mahasiswa suka lapar tengah malam";
  String profileImage = 'lib/asset/fotoprofil.jpg';

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController(text: name);
        TextEditingController descriptionController = TextEditingController(text: description);

        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  description = descriptionController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lingkaran untuk foto profil
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileImage), // Ganti dengan gambar profil
              backgroundColor: Colors.white, // Warna latar belakang lingkaran jika tidak ada gambar
            ),
            SizedBox(height: 20),
            // Nama pengguna
            Text(
              name, // Ganti dengan nama pengguna dinamis jika perlu
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Deskripsi singkat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                description, // Ganti deskripsi sesuai kebutuhan
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final String _videoUrl = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"; // URL video YouTube
  late YoutubePlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_videoUrl) ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("YouTube Video Player"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              print("Player is ready.");
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.white, size: 36),
                onPressed: () {
                  _controller.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause, color: Colors.white, size: 36),
                onPressed: () {
                  _controller.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop, color: Colors.white, size: 36),
                onPressed: () {
                  _controller.seekTo(Duration(seconds: 0));
                  _controller.pause();
                },
              ),
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: _toggleMute,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = ""; // Ekspresi matematika yang dimasukkan
  String _result = ""; // Hasil perhitungan

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "←") {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == "=") {
        _calculateResult();
      } else {
        _expression += value;
      }
    });
  }

  void _calculateResult() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(_expression.replaceAll('x', '*').replaceAll('÷', '/'));
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      _result = eval.toStringAsFixed(2);
    } catch (e) {
      _result = "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          // Tampilan ekspresi dan hasil
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.blueGrey[400],
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(color: Colors.blueGrey[700], fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tombol kalkulator
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blueGrey[700],
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 kolom dalam grid
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  final button = buttons[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(button),
                    child: Text(
                      button,
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tombol-tombol pada kalkulator
const List<String> buttons = [
  "C", "÷", "x", "←",
  "7", "8", "9", "-",
  "4", "5", "6", "+",
  "1", "2", "3", "=",
  "0", ".",
];

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // Controller untuk input
  final TextEditingController _inputController = TextEditingController();

  String _conversionResult = ""; // Hasil konversi
  String _selectedConversion = "Celsius to Fahrenheit"; // Konversi default

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0;

    setState(() {
      if (_selectedConversion == "Celsius to Fahrenheit") {
        double result = (input * 9 / 5) + 32;
        _conversionResult = "$input °C = ${result.toStringAsFixed(2)} °F";
      } else if (_selectedConversion == "Rupiah to USD") {
        double conversionRate = 0.000065; // Contoh kurs
        double result = input * conversionRate;
        _conversionResult = "Rp $input = \$${result.toStringAsFixed(2)}";
      } else if (_selectedConversion == "Kilogram to Pounds") {
        double result = input * 2.20462;
        _conversionResult = "$input kg = ${result.toStringAsFixed(2)} lbs";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Pilih Konversi:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            DropdownButton<String>(
              value: _selectedConversion,
              dropdownColor: Colors.blueAccent,
              style: TextStyle(color: Colors.white),
              items: <String>[
                "Celsius to Fahrenheit",
                "Rupiah to USD",
                "Kilogram to Pounds"
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Tuliskan nominal",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
              ),
              onPressed: _convert,
              child: Text("Convert"),
            ),
            SizedBox(height: 20),
            Text(
              _conversionResult,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Map<String, String>> contacts = [
    {"name": "Admin Pagi", "phone": "081234567899"},
    {"name": "Admin Siang", "phone": "08234567891"},
    {"name": "Admin Sore", "phone": "08345678912"},
    {"name": "Admin Malam", "phone": "08456789123"},
  ];

  void _addContact() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tambah Kontak Baru"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Nomor Telepon"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                setState(() {
                  contacts.add({
                    "name": nameController.text,
                    "phone": phoneController.text,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hapus Kontak"),
        content: Text("Apakah Anda yakin ingin menghapus kontak ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addContact,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            color: Colors.blue[600],
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue[600]),
              ),
              title: Text(
                contact['name'] ?? '',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              subtitle: Text(
                contact['phone'] ?? '',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _deleteContact(index),
              ),
            ),
          );
        },
      ),
    );
  }
}


class CustomerServicePage extends StatefulWidget {
  @override
  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Daftar pesan (pengguna dan CS)

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        // Tambahkan pesan pengguna
        _messages.add({"sender": "user", "message": _messageController.text.trim()});
        _messageController.clear();

        // Simulasi balasan CS setelah sedikit delay
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _messages.add({
              "sender": "cs",
              "message": "Thank you for contacting us! How can I assist you?"
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Customer Service"),
      ),
      body: Column(
        children: [
          // Daftar pesan
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueGrey[700] : Colors.blueGrey[400],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: isUser ? Radius.circular(12) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message['message'] ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input untuk mengetik pesan
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.blueGrey[700],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.blueGrey[400],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  onPressed: _sendMessage,
                  child: Icon(Icons.send, color: Colors.blueGrey[700]),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
