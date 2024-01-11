
import 'dart:io';

import 'book.dart';
import 'display.dart';
import 'user.dart';

class Library extends display {
  List<Books> books = [];
  List<User> users = [];

  int id = 0;
  void addBook(List<Books> books) {
    print("Enter book title");
    String? title = stdin.readLineSync();

    print("Enter book Author");
    String? author = stdin.readLineSync();

    id++;
    Books newBook = Books(id, title, author);
    books.add(newBook);

    displayBookInfo(books);

    print("Books addedd successfully \n");
  }

  @override
  void displayBookInfo(List<Books> books) {
    if (books.isEmpty) {
      print("No Book avialable");
    } else {
      print("Book available: \n");
      books.forEach((book) {
        book.displayInfo();
      });
    }
  }

  void addUser(List<User> users) {
    print("Enter User Id");
    String? s = stdin.readLineSync();
    if (s != null) {
      int? userId = int.parse(s);

      print("Enter User Name");
      String? name = stdin.readLineSync();

      User newuser = User(userId, name);
      users.add(newuser);
      print("User added successfully");
    }
  }

  @override
  void displayUserInfo(List<User> users) {
    if (users.isEmpty) {
      print("No user avialable");
    } else {
      print("User added successfully: \n");
      users.forEach((user) {
        user.displayInfo();
      });
    }
  }

  void searchBooks(List<Books> books) {
    if (books.isEmpty) {
      print("No Book available to search\n");
      return;
    }

    print("Enter the book or author name you want to search?\n");
    String? search = stdin.readLineSync()?.toLowerCase();

    List<Books> searchResult = books
        .where((book) =>
            book.title!.contains(search ?? 'null') ||
            book.author!.contains(search ?? 'null'))
        .toList();

    if (searchResult.isEmpty) {
      print("No Result found\n");
    } else {
      print("Matching Books:");
      searchResult.forEach((book) {
        book.displayInfo();
      });
    }
  }

  void BorrowBooks(List<Books> books, List<User> users) {
    if (books.isEmpty) {
      print("No Books available \n");
      return;
    }

    print("Enter the user Id to borrow books \n");

    String? s = stdin.readLineSync();
    int? userid = int.parse(s!);

    User? user = users.firstWhere((user) => user.userId == userid);

    if (user == null) {
      print(
          "User not found. Enter the correct ID and if not created the user, Please add as a user by pressing 2. \n");
      return;
    }

    print(
        "User Id is correct. Now choose the book number which you want to borrow");

    displayBookInfo(books);

    print("Enter book number to borrow: \n");

    String? s1 = stdin.readLineSync();
    int? bookindex = int.parse(s1!);

    Books bookid = books.firstWhere((book) => book.id == bookindex);

    if (bookid == null) {
      print("Invalid Book Number \n");
      return;
    }

    if (bookid.isBorrowed) {
      print("Book is already Borrowed by other user \n");
    } else {
      bookid.isBorrowed = true;
      user.BorrowedBooks.add(bookid);
      print("${user.name} has borrowed ${bookid.title}");
    }
  }

  void userdetails(List<User> users) {
    print("Enter the user Id to know your user details \n");

    String? s = stdin.readLineSync();
    int? userid = int.parse(s!);

    User? user = users.firstWhere((user) => user.userId == userid);

    if (user == null) {
      print(
          "User not found. Enter the correct ID and if not created the user, Please add as a user by pressing 2. \n");
    } else {
      user.displayInfo();
    }
  }

  void returnBook(List<Books> books, List<User> users) {
    if (books.isEmpty) {
      print("No Books to return \n");
      return;
    }

    print("Enter the user Id to return books \n");

    String? s = stdin.readLineSync();
    int? userid = int.parse(s!);

    User? user = users.firstWhere((user) => user.userId == userid);

    if (user == null) {
      print(
          "User not found. Enter the correct ID and if not created the user, Please add as a user by pressing 2. \n");
      return;
    }

    print(
        "User Id is correct. Now choose the book number which you want to return");

    user.displayInfo();

    print("Enter book number to returned: \n");

    String? s1 = stdin.readLineSync();
    int? bookindex = int.parse(s1!);

    Books bookid = books.firstWhere((book) => book.id == bookindex);

    if (bookid == null) {
      print("Invalid Book Number \n");
      return;
    }

    bookid.isBorrowed = false;
    user.BorrowedBooks.remove(bookid);
    print("${user.name} has returned ${bookid.title}");
  }

  void run() {
    while (true) {
      print(
          "\n1. Add a Book\n2. Add a user\n3. Search Books\n4. Borrow Book\n5. User Details\n6. return a Book\n7. Exit ");

      int choice = int.parse(stdin.readLineSync() ?? '-1');

      switch (choice) {
        case 1:
          addBook(books);
          break;

        case 2:
          addUser(users);
          break;

        case 3:
          searchBooks(books);
          break;

        case 4:
          BorrowBooks(books, users);
          break;

        case 5:
          userdetails(users);
          break;

        case 6:
          returnBook(books, users);
          break;

        case 7:
          exit(0);

        default:
          print("Invalid choice");
      }
    }
  }
}
