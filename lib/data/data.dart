class Users {
  final String name;
  final String email;
  Users({
    required this.name,
    required this.email,
  });
}

class Payment {
  final String date;
  final String paid;
  final String ruppee;
  final String number;
  Payment({
    required this.date,
    required this.paid,
    required this.ruppee,
    required this.number,
  });
}

class Detail {
  final String date;
  final String milk;
  final String ruppee;
  final String months;
  Detail({
    required this.date,
    required this.milk,
    required this.ruppee,
    required this.months,
  });
}

List<Payment> payment = [
  Payment(date: "June 1", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 2", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 3", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 4", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 5", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 6", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 7", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 8", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(date: "June 9", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 10", paid: "PAID", ruppee: "Rs.10000A", number: "06/06/00"),
  Payment(
      date: "June 11", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 12", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 13", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 14", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 15", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 16", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 17", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 18", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 19", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 20", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 21", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 22", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 22", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 23", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 24", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 25", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 26", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 27", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 28", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 29", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
  Payment(
      date: "June 30", paid: "PAID", ruppee: "Rs.10000", number: "06/06/00"),
];
List<Detail> detail = [
  Detail(date: "06", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
  Detail(date: "07", milk: " Milk", ruppee: "${200}", months: "July"),
  Detail(
      date: "08",
      milk: " Dark Chocolate Milk",
      ruppee: "${200}",
      months: "July"),
  Detail(date: "09", milk: "Cow Milk", ruppee: "${200}", months: "July"),
  Detail(date: "10", milk: "Raw Milk", ruppee: "${200}", months: "July"),
  Detail(date: "11", milk: " Milk", ruppee: "${200}", months: "July"),
  Detail(date: "12", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
  Detail(date: "13", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
  Detail(date: "14", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
  Detail(date: "15", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
  Detail(date: "17", milk: "Chocolate Milk", ruppee: "${200}", months: "July"),
];
