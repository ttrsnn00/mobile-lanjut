import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: AppColors.sageLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 54,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.terracottaLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'TRANSAKSI BERHASIL',
                    style: TextStyle(
                      color: AppColors.terracotta,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pesanan Sedang Disiapkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Terima kasih telah berbelanja di Shiroine. Tanaman pilihanmu akan segera dikemas dengan aman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.MAIN),
                    child: const Text('Kembali ke Beranda'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
