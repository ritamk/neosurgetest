import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _date;

  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'New transaction',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Creates border
              color: isExpense ? Colors.red.shade700 : Colors.green.shade700,
            ),
            splashFactory: NoSplash.splashFactory,
            onTap: (value) {
              setState(() => isExpense = value == 0);
            },
            labelColor: Colors.white,
            labelStyle: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily, fontSize: 16),
            tabs: const [
              Tab(text: 'Expense'),
              Tab(text: 'Income'),
            ],
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
                        label: 'Transaction name',
                        focus: _nameFocus,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validation: (val) {
                          if (val!.length < 2) {
                            return "Name must have atleast 2 characters";
                          }
                          return null;
                        },
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Amount',
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
                            firstDate: DateTime(now.year, now.month - 1),
                            lastDate: now,
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
                                  : 'Date',
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
                  color:
                      isExpense ? Colors.red.shade700 : Colors.green.shade700,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.2))
                  ]),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isExpense ? Icons.remove_rounded : Icons.add_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  const Text(
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
