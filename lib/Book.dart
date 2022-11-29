class Book {
  String _id;
  String _name;
  String _image_url;
  String _user_id;
  String _status;
  String _amount;
  String _about;

  Book(this._id, this._name, this._image_url, this._user_id, this._status,
      this._amount, this._about);

  get id => this._id;

  set id(value) => this._id = value;

  get name => this._name;

  set name(value) => this._name = value;

  get image_url => this._image_url;

  set image_url(value) => this._image_url = value;

  get user_id => this._user_id;

  set user_id(value) => this._user_id = value;

  get status => this._status;

  set status(value) => this._status = value;

  get amount => this._amount;

  set amount(value) => this._amount = value;

  get about => this._about;

  set about(value) => this._about = value;
}
