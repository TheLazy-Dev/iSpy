///
/// I didin't get the time to add validation to user and list shows your own name and your own list.
/// So this class just helps me get ID to ignore the user and list.
///
/// I can always use MyID.ignore but is that really a good idea?
///

class GetUserID {
  GetUserID(this.id);
  late String id;

  getUserID() {
    return id;
  }

  setUserID(String id) {
    this.id = id;
  }
}
