class UpdateLocale {
  const UpdateLocale({
    required this.title,
    required this.description,
    required this.updateButtonTitle,
    this.remindButtonTitle,
  });

  final String title;
  final String description;
  final String updateButtonTitle;
  final String? remindButtonTitle;
}
