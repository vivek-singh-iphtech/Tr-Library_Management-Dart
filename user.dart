

import 'book.dart';

class User {
  int? userId;
  String? name;
  List<Books> BorrowedBooks = [];

  User(
    this.userId,
    this.name,
  );

  void displayInfo() {
    print('UserId:$userId,Name:$name');
    if (BorrowedBooks.isEmpty) {
      print('No Books Borrowed');
    } else {
      print("Borrowed Books: ");
      BorrowedBooks.forEach((book) {
        book.displayInfo();
      });
    }
  }
}
