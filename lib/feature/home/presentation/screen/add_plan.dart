import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neosurgetest/feature/home/data/model/plan_model.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/goal/goal_bloc.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({super.key, this.goal});
  final GoalModel? goal;

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

  bool _submitting = false;

  @override
  void initState() {
    if (widget.goal != null) {
      _nameController.text = widget.goal!.planName;
      _amountController.text = widget.goal!.targetAmount.toString();
      _date = widget.goal!.targetDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.goal != null ? 'Edit goal' : 'New goal',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                          currentDate: widget.goal != null ? _date : null,
                          firstDate: now.add(const Duration(days: 1)),
                          lastDate: now.add(const Duration(days: 365)),
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
      floatingActionButton: BlocListener<GoalBloc, GoalState>(
        listener: (context, state) {
          switch (state) {
            case GoalSubmitting():
              setState(() => _submitting = true);
            case GoalSubmitError():
              setState(() => _submitting = false);
              customSnackbar(context,
                  content:
                      'Could not ${widget.goal != null ? 'edit' : 'add'} goal',
                  isError: true);
            case GoalSubmitSuccess():
              setState(() => _submitting = false);
              customSnackbar(context,
                  content: 'Goal ${widget.goal != null ? 'edited' : 'added'}',
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
                  context.read<GoalBloc>().add(widget.goal != null
                      ? EditingGoal(
                          oldGoalModel: widget.goal!,
                          newGoalModel: GoalModel(
                            planName: _nameController.text.trim(),
                            targetDate: _date!,
                            targetAmount:
                                double.parse(_amountController.text.trim()),
                          ),
                        )
                      : AddingGoal(
                          goalModel: GoalModel(
                            planName: _nameController.text.trim(),
                            targetDate: _date!,
                            targetAmount:
                                double.parse(_amountController.text.trim()),
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
                color: Colors.green.shade700,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2))
                ],
              ),
              height: 50,
              child: !_submitting
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12),
                        Text(
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
