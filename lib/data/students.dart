class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String department;
  final bool isActive;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.department,
    required this.isActive,
  });

  Student copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? department,
    bool? isActive,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      department: department ?? this.department,
      isActive: isActive ?? this.isActive,
    );
  }
}

final students = <Student>[
  Student(
    id: 456,
    firstName: "Abu",
    lastName: "Rayhan",
    phone: "01317546595",
    email: "mdaburayhanmondal@gmail.com",
    department: "CSE",
    isActive: true,
  ),
  Student(
    id: 457,
    firstName: "Nusrat",
    lastName: "Jahan",
    phone: "01711223344",
    email: "nusrat.jahan@gmail.com",
    department: "CSE",
    isActive: true,
  ),

  Student(
    id: 458,
    firstName: "Sakib",
    lastName: "Hasan",
    phone: "01822334455",
    email: "sakib.hasan@gmail.com",
    department: "EEE",
    isActive: true,
  ),

  Student(
    id: 459,
    firstName: "Mehedi",
    lastName: "Hasan",
    phone: "01933445566",
    email: "mehedi.hasan@gmail.com",
    department: "BBA",
    isActive: false,
  ),

  Student(
    id: 460,
    firstName: "Farzana",
    lastName: "Akter",
    phone: "01644556677",
    email: "farzana.akter@gmail.com",
    department: "Civil",
    isActive: true,
  ),
];
