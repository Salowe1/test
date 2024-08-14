import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/screens/send/amount_to_send.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart' as contacts_service;
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart' as native_picker;
import 'package:lockre/constants/colors.dart';
import 'package:lockre/routes/route.dart'; // Import the MyRoutes class

class SenderNumberScreen extends StatefulWidget {
  @override
  _SenderNumberScreenState createState() => _SenderNumberScreenState();
}

class _SenderNumberScreenState extends State<SenderNumberScreen> {
  List<contacts_service.Contact> _contacts = [];
  List<contacts_service.Contact> _filteredContacts = [];
  bool _isLoading = true;
  final TextEditingController _controller = TextEditingController();
  String _selectedCountryCode = 'BF';
  final native_picker.FlutterContactPicker _contactPicker = native_picker.FlutterContactPicker();
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _askPermissions();
    _controller.addListener(_filterContacts);
    _getContacts();
  }

  @override
  void dispose() {
    _controller.removeListener(_filterContacts);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.request();
    if (!status.isGranted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getContacts() async {
    try {
      var contacts = await contacts_service.ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _filteredContacts = _contacts;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching contacts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterContacts() {
    String query = _controller.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        String contactName = contact.displayName?.toLowerCase() ?? '';
        var phoneNumbers = contact.phones?.map((e) => e.value ?? '').toList() ?? [];
        return phoneNumbers.any((phoneNumber) => phoneNumber.contains(query)) || contactName.contains(query);
      }).toList();
    });
  }

  String _normalizePhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }

  Widget _animatedButton({
    required VoidCallback onPressed,
    required String label,
    required bool isPressed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isPressed ? Colors.white : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: InkWell(
        onTap: onPressed,
        onHighlightChanged: (value) {
          setState(() {
            _isButtonPressed = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isPressed ? AppColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Numéro du récepteur', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberInput(),
            const SizedBox(height: 20),
            const Text('Choisir dans la liste de mes contacts ', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildContactList(),
            const Spacer(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Row(
      children: [
        Expanded(
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                _selectedCountryCode = number.isoCode ?? 'BF';
                _filterContacts();
              });
            },
            inputDecoration: const InputDecoration(
              labelText: 'Entrez le numéro du récepteur',
            ),
            initialValue: PhoneNumber(isoCode: _selectedCountryCode),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            ignoreBlank: false,
            selectorTextStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildContactList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_filteredContacts.isEmpty) {
      return const Center(child: Text('Aucun contact trouvé'));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredContacts.length,
        itemBuilder: (context, index) {
          var contact = _filteredContacts[index];
          var phoneNumbers = contact.phones?.map((e) => _normalizePhoneNumber(e.value ?? '')).toList() ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: phoneNumbers.map((phone) => ContactItem(
              name: contact.displayName ?? '',
              phone: phone,
              onContactSelected: (selectedPhone) {
                setState(() {
                  _controller.text = selectedPhone ?? '';
                });
              },
            )).toList(),
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return Center(
      child: _animatedButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            Get.to(() => AmountToSendScreen(selectedNumber: _controller.text));
          }
        },
        label: 'Continuer',
        isPressed: _isButtonPressed,
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String name;
  final String phone;
  final Function(String?) onContactSelected;

  ContactItem({required this.name, required this.phone, required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onContactSelected(phone),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 50),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(phone, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
