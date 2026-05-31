import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'pet_adopt_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainNavigation extends StatefulWidget {
  final File? selectedImage;
  final Uint8List? webImage;

  const MainNavigation({super.key, this.selectedImage, this.webImage});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
   
    _pages = [
      const PetAdoptScreen(),
      const MovieScreen(),   
      ProfileScreen(selectedImage: widget.selectedImage, webImage: widget.webImage), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1F2A38), 
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'Movie'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool _isDetailView = false; 
    
  Map<String, String>? _selectedPetData;

  final List<Map<String, String>> _petMovies = [
    {
      'name': 'Kucing Anggora',
      'image': 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Anjing Golden',
      'image': 'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Kelinci Putih',
      'image': 'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Burung Beo',
      'image': 'https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Kucing Persia',
      'image': 'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Anjing Husky',
      'image': 'https://images.dog.ceo/breeds/husky/n02110185_1469.jpg'
    },
    {
      'name': 'Sapi Perah',
      'image': 'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Domba Merino',
      'image': 'https://images.unsplash.com/photo-1484557985045-edf25e08da73?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Babi',
      'image': 'https://images.unsplash.com/photo-1516467508483-a7212febe31a?q=80&w=400&auto=format&fit=crop'
    },
    {
      'name': 'Kambing PE',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Hausziege_04.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'PRAKTIKUM PAB',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: _isDetailView ? _buildScreen2Detail() : _buildScreen1Grid(),
    );
  }

  Widget _buildScreen1Grid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemCount: _petMovies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedPetData = _petMovies[index]; 
              _isDetailView = true; 
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(_petMovies[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _petMovies[index]['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF2C3E50),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreen2Detail() {
    String petName = _selectedPetData?['name'] ?? 'Hewan Adopsi';
    String petImageUrl = _selectedPetData?['image'] ?? 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=300';

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 3))
                ],
                image: DecorationImage(
                  image: NetworkImage(petImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                  ),
                ),
                child: Text(
                  petName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isDetailView = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5E7EB),
                foregroundColor: Colors.black87,
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Play',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final File? selectedImage;
  final Uint8List? webImage;

  const ProfileScreen({super.key, this.selectedImage, this.webImage});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _localSelectedImage;
  Uint8List? _localWebImage;

  @override
  void initState() {
    super.initState();
    _localSelectedImage = widget.selectedImage;
    _localWebImage = widget.webImage;
  }

  Future<void> _updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _localWebImage = bytes;
          _localSelectedImage = File(image.path);
        });
      } else {
        setState(() => _localSelectedImage = File(image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
              ),
              child: Column(
                children: [
                  const Text('PROFIL MAHASISWA', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _updateProfileImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: kIsWeb
                              ? (_localWebImage == null
                                  ? const Icon(Icons.person, size: 60, color: Color(0xFF2C3E50))
                                  : Image.memory(_localWebImage!, fit: BoxFit.cover))
                              : (_localSelectedImage == null
                                  ? const Icon(Icons.person, size: 60, color: Color(0xFF2C3E50))
                                  : Image.file(_localSelectedImage!, fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('M.Rizal Ridwan Johran Ali Akbar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('NBI: 1462300070', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildModernInfoCard(Icons.school_outlined, 'Kelas Praktikum', 'PAB 2026 (PAB-4)'),
                  _buildModernInfoCard(Icons.mail_outline_rounded, 'Email Mahasiswa', 'masdwan07@gmail.com'),
                  _buildModernInfoCard(Icons.map_outlined, 'Asal Regional', 'Surabaya, Jawa Timur'),
                  _buildModernInfoCard(Icons.camera_alt_outlined, 'Instagram', '@dwan007'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInfoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x05000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF2C3E50), size: 22),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
            ],
          ),
        ],
      ),
    );
  }
}