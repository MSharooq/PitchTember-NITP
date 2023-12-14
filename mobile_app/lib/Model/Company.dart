class Company{
  String userId;
  String companyName;
  String email;
  List<String> jobIds;
  List<Map<String, String>> applications;
  Company({required this.userId, required this.companyName, required this.email, required this.jobIds, required this.applications});
}