class BuyLogs {
  String _id;
  String _date;
  String _state;
  String _price;
  String _user_id;
  String _item_id;
  String _name;

  BuyLogs(this._id, this._date, this._state, this._price,
      this._item_id, this._user_id, this._name);

  get id => this._id;

  set id(value) => this._id = value;

  get date => this._date;

  set date(value) => this._date = value;

  get state => this._state;

  set state(value) => this._state = value;

  get price => this._price;

  set price(value) => this._price = value;

  get item_id => this._item_id;

  set item_id(value) => this._item_id = value;

  get user_id => this._user_id;

  set user_id(value) => this._user_id = value;

  get name => this._name;

  set name(value) => this._name = value;
}
