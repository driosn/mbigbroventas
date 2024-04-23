class PaqueteStock {
  final int duration;
  final int prime;
  final int primebs;
  final dynamic currency;
  final int idstock;

  PaqueteStock({
    required this.duration,
    required this.prime,
    required this.primebs,
    required this.currency,
    required this.idstock,
  });

  factory PaqueteStock.fromJson(Map<String, dynamic> json) => PaqueteStock(
        duration: json["duration"],
        prime: json["prime"],
        primebs: json["primebs"],
        currency: json["currency"],
        idstock: json["idstock"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "prime": prime,
        "primebs": primebs,
        "currency": currency,
        "idstock": idstock,
      };
}
