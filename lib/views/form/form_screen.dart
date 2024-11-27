import 'package:flutter/material.dart';
import 'package:flutter_task_app/models/service_model.dart';

class FormScreen extends StatefulWidget {
  final ServiceData service;

  FormScreen({required this.service});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.serviceName ?? 'Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Service: ${widget.service.serviceName}'),
            // Dynamically generate fields based on the formFields
            // widget.service.formFields?.isNotEmpty ?? false
            widget.service.formFields != null &&
                    widget.service.formFields!.isNotEmpty
                ? Column(
                    children: widget.service.formFields!.map((field) {
                      switch (field.fieldType) {
                        case 'text':
                          return _buildTextField(field);
                        case 'dropdown':
                          return _buildDropdown(field);
                        case 'date':
                          return _buildDatePicker(field);
                        case 'checkbox':
                          return _buildCheckbox(field);
                        default:
                          return SizedBox.shrink();
                      }
                    }).toList(),
                  )
                : _buildStaticForm(),
            SizedBox(
              height: 50,
            ), // Fallback static form
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey, // Text color (white)
                minimumSize: Size(double.infinity,
                    50), // Makes the button take up the remaining width
              ),
              onPressed: () {
                // Handle form submission
              },
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white), // Ensure text color is white
              ),
            )
          ],
        ),
      ),
    );
  }

  // Method to build a text field
  Widget _buildTextField(FormFieldData field) {
    return TextField(
      decoration: InputDecoration(
        labelText: field.fieldName,
        hintText: field.defaultValue,
      ),
      keyboardType: TextInputType.text,
    );
  }

  // Method to build a dropdown
  Widget _buildDropdown(FormFieldData field) {
    return DropdownButtonFormField<String>(
      items: field.options!.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: field.fieldName,
      ),
    );
  }

  // Method to build a date picker
  Widget _buildDatePicker(FormFieldData field) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: field.fieldName,
        hintText: field.defaultValue ?? 'Select Date',
      ),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        // Handle selected date if necessary
      },
    );
  }

  // Method to build a checkbox
  Widget _buildCheckbox(FormFieldData field) {
    bool isChecked = false;
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              isChecked = newValue!;
            });
          },
        ),
        Text(field.fieldName),
      ],
    );
  }

  // Static fallback form
  Widget _buildStaticForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Aadhar Number',
            hintText: 'Enter Aadhar number',
          ),
        ),
        SizedBox(height: 10), // Spacing between fields
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Application Name',
            hintText: 'Enter application name',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Mobile Number',
            hintText: 'Enter mobile number',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Email',
            hintText: 'Enter email address',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Residential Details',
            hintText: 'Enter residential details',
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          items: ['Option 1', 'Option 2', 'Option 3'].map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: 'Select Pension Category',
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                items:
                    ['Option 1', 'Option 2', 'Option 3'].map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Select Pension Category',
                ),
              ),
            ),
            SizedBox(width: 10), // Spacing between the fields in the row
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Age',
                  hintText: 'Enter email address',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
