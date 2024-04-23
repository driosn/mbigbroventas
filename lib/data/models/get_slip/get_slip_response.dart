class GetSlipResponse {
  final String nameFileSlip;

  GetSlipResponse({
    required this.nameFileSlip,
  });

  factory GetSlipResponse.fromJson(Map<String, dynamic> json) =>
      GetSlipResponse(
        nameFileSlip: json["name_file_slip"],
      );

  Map<String, dynamic> toJson() => {
        "name_file_slip": nameFileSlip,
      };
}
