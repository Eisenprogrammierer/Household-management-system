// household-management-system/lib/core/widgets/app_widgets.dart

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final double? width;
  final double? height;
  final bool isLoading;

  const AppButton({
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.width,
    this.height = 48,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: type == ButtonType.primary ? Colors.blue : Colors.grey[600],
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(text),
      ),
    );
  }
}

enum ButtonType { primary, secondary }
