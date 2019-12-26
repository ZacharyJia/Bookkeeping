import 'package:bookkeeping/util/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_record_response.g.dart';

@JsonSerializable()
class BillRecordResponse extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<BillRecordModel> data;

  @JsonKey(name: 'msg')
  String msg;

  BillRecordResponse(
    this.code,
    this.data,
    this.msg,
  );

  factory BillRecordResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$BillRecordResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BillRecordResponseToJson(this);
}

@JsonSerializable()
class BillRecordModel extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'originMoney')
  double originMoney;

  @JsonKey(name: 'money')
  double money;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'categoryName')
  String categoryName;

  @JsonKey(name: 'image')
  String image;

  /// 类型 1支出 2收入
  @JsonKey(name: 'type')
  int type;

  /// 是否已同步
  @JsonKey(name: 'isSync')
  int isSync;

  /// 是否已删除
  @JsonKey(name: 'isDelete')
  int isDelete;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createTimestamp')
  int createTimestamp;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateTimestamp')
  int updateTimestamp;

  BillRecordModel(
    this.id,
    this.currency,
    this.originMoney,
    this.money,
    this.remark,
    this.type,
    this.categoryName,
    this.image,
    this.createTime,
    this.createTimestamp,
    this.updateTime,
    this.updateTimestamp,
  );

  factory BillRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BillRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BillRecordModelToJson(this);

  String getCurrencyMoneyString() {
    var str = '${Utils.getCurrencyString(this.currency)} ${Utils.formatDouble(this.originMoney)}';
    if (this.currency != 'CNY') {
      str += '(${Utils.getCurrencyString("CNY")} ${Utils.formatDouble(this.money)})';
    }
    return str;
  }
}
