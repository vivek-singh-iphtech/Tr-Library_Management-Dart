
class Books {
  int? id;
  String? title;
  String? author;
  bool isBorrowed =false;

  Books(
    this.id,
     this.title,
    this.author,
  );

  void displayInfo() {
    print(
        "index:$id,BookTitle:$title,Author:$author,status:${isBorrowed?'borrowed':'Available'}");
  }
}
