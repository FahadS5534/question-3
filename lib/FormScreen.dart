import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _gender;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = ['USA', 'India', 'Canada'];
  final Map<String, List<String>> _states = {
    'USA': ['California', 'Texas', 'Florida'],
    'India': ['Maharashtra', 'Delhi', 'Karnataka'],
    'Canada': ['Ontario', 'Quebec', 'Alberta'],
  };
  final Map<String, List<String>> _cities = {
    'California': ['Los Angeles', 'San Francisco', 'San Diego'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Ontario': ['Toronto', 'Ottawa', 'Hamilton'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items: _genders.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                ),

                // Country Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: const InputDecoration(labelText: 'Country'),
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                      _selectedState = null;
                      _selectedCity = null;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a country';
                    }
                    return null;
                  },
                ),

                // State Dropdown
                if (_selectedCountry != null)
                  DropdownButtonFormField<String>(
                    value: _selectedState,
                    decoration: const InputDecoration(labelText: 'State'),
                    items: _states[_selectedCountry]!.map((state) {
                      return DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedState = value;
                        _selectedCity = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                  ),

                // City Dropdown
                if (_selectedState != null)
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: const InputDecoration(labelText: 'City'),
                    items: _cities[_selectedState]!.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                      print("Name: ${_nameController.text}");
                      print("Email: ${_emailController.text}");
                      print("Phone: ${_phoneController.text}");
                      print("Gender: $_gender");
                      print("Country: $_selectedCountry");
                      print("State: $_selectedState");
                      print("City: $_selectedCity");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
