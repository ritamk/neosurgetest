import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({super.key});

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New goal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Goal title',
                      focus: _nameFocus,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validation: (val) {
                        if (val!.length < 2) {
                          return "Title must have atleast 2 characters";
                        }
                        return null;
                      },
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Amount required',
                      focus: _amountFocus,
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validation: (val) {
                        if (val!.isEmpty) {
                          return "Please enter the amount";
                        } else if (int.parse(val) <= 0) {
                          return "Please enter a valid amount";
                        }
                        return null;
                      },
                      prefixText: '₹ ',
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final DateTime now = DateTime.now();

                        final DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: now,
                          lastDate: DateTime(now.year + 1, now.month),
                        );

                        date != null ? setState(() => _date = date) : null;
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.06)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _date != null
                                ? DateFormat('dd/MM/yy')
                                    .format(_date!)
                                    .toString()
                                : 'Target date',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (_date != null) {
              } else {
                customSnackbar(context,
                    content: 'Please select the date', isError: true);
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.green.shade700,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.2))
              ],
            ),
            height: 50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _nameController.dispose();
    _amountFocus.dispose();
    _amountFocus.dispose();
    super.dispose();
  }
}
