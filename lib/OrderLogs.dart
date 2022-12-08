class OrderLogs {
  String _order_date;
  String _amount;
  String _state;
  String _authority;
  String _ref_id;
  String _description;

  OrderLogs(this._order_date, this._amount, this._state, this._authority,
      this._ref_id, this._description);

  get order_date => this._order_date;

  set order_date(value) => this._order_date = value;

  get amount => this._amount;

  set amount(value) => this._amount = value;

  get state => this._state;

  set state(value) => this._state = value;

  get authority => this._authority;

  set authority(value) => this._authority = value;

  get ref_id => this._ref_id;

  set ref_id(value) => this._ref_id = value;

  get description => this._description;

  set description(value) => this._description = value;
}
