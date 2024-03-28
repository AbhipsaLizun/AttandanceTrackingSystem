class FinancialYear {
  final int financialYearId;
  final String fYear;


  FinancialYear({required this.financialYearId, required this.fYear});

  factory FinancialYear.fromJson(Map<String, dynamic> json) {
    return FinancialYear(
      financialYearId: json['financialYearId'],
      fYear: json['fYear'],

    );
  }
}