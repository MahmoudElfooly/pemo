import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/core/baseRepo/bearer_token_repo.dart';

import '../../../../core/servicesLocator/services_locator.dart';
import '../../domain/entities/add_card_payload.dart';
import '../../domain/useCase/card_use_case.dart';
import '../cubit/card_cubit.dart';
import '../cubit/card_states.dart';

class CreateCardPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  String _selectedCardholder = 'User 1';
  String _selectedColor = '#FF0000';

  CreateCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(locator<CardUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Card'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ),
        body: BlocConsumer<CardCubit, CardStates>(
          listener: (context, state) {
            if (state is CardAddedSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green),
              );
              Navigator.pop(context, true);
            } else if (state is AddCardError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is AddCardLoading; // Check loading state

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Card Name'),
                    validator: (value) {
                      if (value == null || value.length < 3) {
                        return 'Card name must be at least 3 characters';
                      }
                      return null;
                    },
                    enabled: !isLoading, // Prevent editing during API call
                  ),
                  DropdownButtonFormField(
                    value: _selectedCardholder,
                    items: ['User 1', 'User 2'].map((user) {
                      return DropdownMenuItem(value: user, child: Text(user));
                    }).toList(),
                    onChanged: isLoading
                        ? null
                        : (value) {
                            _selectedCardholder = value.toString();
                          },
                    decoration: const InputDecoration(labelText: 'Cardholder'),
                  ),
                  TextFormField(
                    controller: _balanceController,
                    decoration: const InputDecoration(labelText: 'Balance'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final balance = int.tryParse(value ?? '');
                      if (balance == null || balance < 100 || balance > 1000) {
                        return 'Balance must be between 100 and 1000';
                      }
                      return null;
                    },
                    enabled: !isLoading, // Prevent editing during API call
                  ),
                  DropdownButtonFormField(
                    value: _selectedColor,
                    items: ['#FF0000', '#00FF00', '#0000FF'].map((color) {
                      return DropdownMenuItem(value: color, child: Text(color));
                    }).toList(),
                    onChanged: isLoading
                        ? null
                        : (value) {
                            _selectedColor = value.toString();
                          },
                    decoration: const InputDecoration(labelText: 'Card Color'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null // Disable button during API call
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final card = AddCardPayload(
                                id: DateTime.now().toString(),
                                name: _nameController.text,
                                cardholder: _selectedCardholder,
                                balance: int.parse(_balanceController.text),
                                color: _selectedColor,
                                owner: BearerTokenRepo.getBearerToken() ?? "",
                              );
                              context.read<CardCubit>().createCard(card);
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white) // 🔄 Show loader in button
                        : const Text('Create Card'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
