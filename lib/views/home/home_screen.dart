import 'package:flutter/material.dart';
import 'package:flutter_task_app/viewmodels/login_viewmodel.dart';
import 'package:flutter_task_app/viewmodels/servicelist_viewmode.dart';
import 'package:flutter_task_app/views/form/form_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget base64Image(String base64String) {
      Uint8List bytes = base64Decode(base64String.split(',')[1]);
      return Image.memory(bytes);
    }
    //final serviceListViewModel = Provider.of<ServiceListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Ranjith",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "ID: 44 | Department",
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Consumer<ServiceListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          return ListView.builder(
            itemCount: viewModel.services.length,
            itemBuilder: (context, index) {
              final service = viewModel.services[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: service.image != null
                      ? base64Image(service.image!)
                      : Icon(Icons.image), // Fallback icon if no image
                  title: Text(service.serviceName!),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(service: service),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            0, // This would typically be a variable that tracks the current index
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          if (index == 2) {
            // If "Logout" item is tapped, log the user out
            await _logout(context);
          } else {
            // Handle other tab navigation (Home or My Reports)
            // Navigate to the corresponding screen based on the index
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/my_reports');
            }
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'My Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Call the logout method from LoginViewModel
    await Provider.of<LoginViewModel>(context, listen: false).logout();

    // After logging out, navigate to the Login screen
    Navigator.pushReplacementNamed(context, '/');
  }
}
