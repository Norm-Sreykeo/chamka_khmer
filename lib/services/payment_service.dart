class PaymentService {

  /// simulate payment processing
  Future<bool> processPayment({
    required double amount,
    required String method,
  }) async {

    await Future.delayed(const Duration(seconds: 2));

    print("Paid $amount using $method");

    return true; // success
  }
}
