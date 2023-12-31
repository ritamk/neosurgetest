import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/feature/home/data/model/expense_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/expense/expense_bloc.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, this.expense});
  final ExpenseModel? expense;

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

  bool _isExpense = true;

  bool _submitting = false;

  @override
  void initState() {
    if (widget.expense != null) {
      _nameController.text = widget.expense!.txnName;
      _amountController.text = widget.expense!.txnAmount.toString();
      _date = widget.expense!.txnDate;
      _isExpense = widget.expense!.isExpense;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.expense != null ? 'Edit transaction' : 'New transaction',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Creates border
              color: _isExpense ? Colors.red.shade700 : Colors.green.shade700,
            ),
            splashFactory: NoSplash.splashFactory,
            onTap: (value) {
              setState(() => _isExpense = value == 0);
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
                          } else if (double.parse(val) <= 0) {
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
                            currentDate: widget.expense != null ? _date : null,
                            firstDate: now.subtract(const Duration(days: 30)),
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
        floatingActionButton: BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            switch (state) {
              case ExpenseSubmitting():
                setState(() => _submitting = true);
              case ExpenseSubmitError():
                setState(() => _submitting = false);
                customSnackbar(context,
                    content:
                        'Could not ${widget.expense != null ? 'edit' : 'add'} transation',
                    isError: true);
              case ExpenseSubmitSuccess():
                setState(() => _submitting = false);
                customSnackbar(context,
                    content:
                        'Transaction ${widget.expense != null ? 'edited' : 'added'}',
                    isError: false);
                Navigator.pop(context);
              default:
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (_date != null) {
                    context.read<ExpenseBloc>().add(widget.expense != null
                        ? EditingExpense(
                            oldExpenseModel: widget.expense!,
                            newExpenseModel: ExpenseModel(
                              txnName: _nameController.text.trim(),
                              txnDate: _date!,
                              txnAmount:
                                  double.parse(_amountController.text.trim()),
                              isExpense: _isExpense,
                            ),
                          )
                        : AddingExpense(
                            expenseModel: ExpenseModel(
                              txnName: _nameController.text.trim(),
                              txnDate: _date!,
                              txnAmount:
                                  double.parse(_amountController.text.trim()),
                              isExpense: _isExpense,
                            ),
                          ));
                  } else {
                    customSnackbar(context,
                        content: 'Please select the date', isError: true);
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: _isExpense
                        ? Colors.red.shade700
                        : Colors.green.shade700,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.2))
                    ]),
                height: 50,
                child: !_submitting
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isExpense
                                ? Icons.remove_rounded
                                : Icons.add_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Add',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : const Center(
                        child: CupertinoActivityIndicator(color: Colors.white)),
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
