import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/common/widgets/custom_text_field.dart';
import 'package:agni_pariksha/features/location/presentation/cubit/location_cubit.dart';
import 'package:agni_pariksha/features/location/presentation/cubit/location_state.dart' as LocationCubitState;
import 'package:agni_pariksha/features/location/domain/entities/state.dart' as LocationEntity;
import 'package:agni_pariksha/features/location/domain/entities/city.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  LocationEntity.State? _selectedState;
  City? _selectedCity;


  @override
  void initState() {
    super.initState();
    debugPrint('RegisterPage: initState called');

    // safe call (no async gap problem)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        debugPrint('RegisterPage: Widget not mounted, skipping initialization');
        return;
      } else {
        debugPrint('RegisterPage: Widget mounted, initializing India states');
        context.read<LocationCubit>().initializeIndia();
      }
    });
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Additional validation for state and city
      if (_selectedState == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a state'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      
      if (_selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a city'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      
      debugPrint('state: ${_selectedState?.id}');
      debugPrint('city: ${_selectedCity?.id}');
      
      context.read<AuthCubit>().register(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            phone: _phoneController.text.trim().isEmpty
                ? null
                : _phoneController.text.trim(),
            state: _selectedState!.id,
            city: _selectedCity!.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
        backgroundColor: AppColors.background,
        body:  BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            // Registration successful, show snackbar and redirect to OTP verification page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
                duration: const Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.go('/otp-verification', extra: state.email);
              }
            });
          }
          //Registration failed, show snackbar
          else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Register heading
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign up to get started',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.secondaryText,
                            ),
                      ),
                      const SizedBox(height: 32),
                      // First Name field
                      CustomTextField(
                        controller: _firstNameController,
                        hintText: 'First Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Last Name field
                      CustomTextField(
                        controller: _lastNameController,
                        hintText: 'Last Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email field
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Phone field
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'Phone (Optional)',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      // State dropdown
                      BlocBuilder<LocationCubit, LocationCubitState.LocationState>(
                        builder: (context, locationState) {
                          List<LocationEntity.State> states = [];
                          bool isLoadingStates = false;
                          
                          if (locationState is LocationCubitState.StatesLoaded) {
                            states = locationState.states;
                            isLoadingStates = false;

                          } else if (locationState is LocationCubitState.LocationLoading) {
                            isLoadingStates = true;
                          }
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: DropdownSearch<LocationEntity.State>(
                              key: const ValueKey('state_dropdown'),
                              mode: Mode.form,
                              items: (filter, loadProps) => isLoadingStates ? [] : states,

                              compareFn: (item, value) => item.id == value.id,
                              itemAsString: (item) => item.name,
                              // enabled: !isLoadingStates,
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  hintText: 'Select State',
                                  hintStyle: const TextStyle(color: AppColors.hintText),
                                  
                                  prefixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.primary,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              selectedItem: _selectedState,
                              popupProps: PopupProps.modalBottomSheet(


                                
                                showSelectedItems: true,
                                fit: FlexFit.tight,
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(color: AppColors.hintText),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, item, isDisabled, isSelected) => Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(item.name, style: const TextStyle(color: AppColors.primary,fontSize: 15),),
                                ),
                                modalBottomSheetProps: ModalBottomSheetProps(


                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: AppColors.white,
                                  barrierColor: AppColors.black.withOpacity(0.5),


                                ),
                              ),
                              onChanged: (state) {
                                debugPrint('State changed: ${state?.name}, id: ${state?.id}');
                                setState(() {
                                  _selectedState = state;
                                  _selectedCity = null; // Reset city when state changes
                                });
                                if (state != null) {
                                  context.read<LocationCubit>().loadCitiesByState(state.id);
                                }
                                debugPrint('_selectedState after update: ${_selectedState?.id}');
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a state';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // City dropdown
                      if (_selectedState != null)
                        BlocBuilder<LocationCubit, LocationCubitState.LocationState>(
                          builder: (context, locationState) {
                            List<City> cities = [];
                            bool isLoadingCities = false;
                            
                            if (locationState is LocationCubitState.CitiesLoaded) {
                              cities = locationState.cities;
                            } else if (locationState is LocationCubitState.LocationLoading && _selectedState != null) {
                              isLoadingCities = true;
                            }
                            
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: DropdownSearch<City>(
                                key: const ValueKey('city_dropdown'),
                                mode: Mode.form,

                                items: (filter, loadProps) => isLoadingCities ? [] : cities,
                                compareFn: (item, value) => item.id == value.id,

                                itemAsString: (item) => item.name,
                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    hintText: 'Select City',
                                    hintStyle: const TextStyle(color: AppColors.hintText),
                                    prefixIcon: Icon(
                                      Icons.location_city_outlined,
                                      color: AppColors.primary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                                selectedItem: _selectedCity,
                                filterFn: (item, query) => item.name.toLowerCase().contains(query.toLowerCase()),
                                popupProps: PopupProps.modalBottomSheet(
                                  // containerBuilder: (context, popupWidget) => 
                                  // Container(
                                  //   constraints: BoxConstraints(
                                  //     maxHeight: MediaQuery.of(context).size.height * 0.8,
                                  //   ),
                                  //   child: popupWidget,
                                  // ),

                                  showSelectedItems: true,
                                  
                                  
                                  fit: FlexFit.tight,
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(

                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      hintStyle: const TextStyle(color: AppColors.hintText),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 16,
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isDisabled, isSelected) => Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  modalBottomSheetProps: ModalBottomSheetProps(
                                    // enableDrag: false,
                                    // anchorPoint: Offset(0, 0),

                                
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: AppColors.white,
                                    barrierColor: AppColors.black.withOpacity(0.5),
                                  ),
                                ),
                                onChanged: (city) {
                                  debugPrint('City changed: ${city?.name}, id: ${city?.id}');
                                  setState(() {
                                    _selectedCity = city;
                                  });
                                  debugPrint('_selectedCity after update: ${_selectedCity?.id}');
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a city';
                                  }
                                  return null;
                                },
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 16),
                      // Password field
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        showPasswordToggle: true,
                        onPasswordToggle: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password field
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        showPasswordToggle: true,
                        onPasswordToggle: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Register button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: AppColors.secondaryText),
                          ),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.pushReplacement('/login');
                                  },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        ),
      );
  }
}

