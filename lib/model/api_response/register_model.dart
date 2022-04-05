class RegisterModel {
  RegisterModel({
    this.greeting,
    this.instructions,
  });

  String? greeting;
  List<String>? instructions;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    greeting: json["greeting"],
    instructions: List<String>.from(json["instructions"].map((x) => x)),

  );

  Map<String, dynamic> toJson() => {
    "greeting": greeting,
    "instructions": List<dynamic>.from(instructions!.map((x) => x)),
  };
}
