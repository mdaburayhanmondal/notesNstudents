class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String department;
  final bool isActive;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.department,
    required this.isActive,
  });
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
    id: 026,
    firstName: "Zinnatun",
    lastName: "Nesa",
    phone: "01768003624",
    email: "2023100000026",
    department: "CSE",
    isActive: true,
  ),
  Student(
    id: 440,
    firstName: "Rupa Akther",
    lastName: "Rubina",
    phone: "01734856962",
    email: "2023200000440",
    department: "CSE",
    isActive: true,
  ),
];
