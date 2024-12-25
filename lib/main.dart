import 'package:flutter/material.dart';
import 'package:local_storage/model.dart';
import 'package:local_storage/storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profiles',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => UserListPageState();

}

class UserListPageState extends State<UserListPage> {
  
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();

    final StorageService _storageService =StorageService();
    List<User> _users = [];

    @override
    void initState(){
      super.initState();
      _loadUsers();
    }

  void _loadUsers()async{
    List<User> users = await _storageService.getUsers();
    setState(() {
      _users = users;
      
    });
    }  

    void _saveUser(){
      final user = User(
        email:_emailController.text,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
         );
         _users.add(user);
         _storageService.saveUsers(_users);
         _loadUsers();
         _clearInputFields();
    }
     // to clear anything in the controller
    void _clearInputFields(){
      _emailController.clear();
      _nameController.clear();
      _phoneController.clear();

    }
   // to delete a particular user
    void _deleteUser(String email){
      _storageService.removeUser(email);
      _loadUsers();
    }
    // to delete all users
    void _clearAllUsers(){
      _storageService.clearUsers();
      _loadUsers();
    }
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('User Profiles'),
        actions: [
          ElevatedButton(
            onPressed: _clearAllUsers,
             child: const Text("Clear All"),
             ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0) ,
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
             TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
             TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(onPressed:_saveUser, child: const Text('Sub')),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context,index){
                  final user = _users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text('${user.email} - ${user.phoneNumber}'),
                     trailing: IconButton(icon: const Icon(Icons.delete),
                     onPressed:()=> _deleteUser(user.email),),
                  );
                },))
            
          ],),),
    );
  }
}