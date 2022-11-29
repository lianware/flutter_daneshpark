class Posts {
  String _link;
  String _name;
  String _image;
  String _author;

  Posts(this._name, this._image, this._author, this._link);

  String get image => _image;

  String get link => _link;

  String get name => _name;

  String get author => _author;

  set image(String value) {
    _image = value;
  }

  set link(String value) {
    _link = value;
  }

  set name(String value) {
    _name = value;
  }

  set author(String value) {
    _author = value;
  }
}
