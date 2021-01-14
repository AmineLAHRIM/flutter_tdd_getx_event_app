enum MessageType{
  danger,
  primary,
  warning,
  success,
}
class MessageError{
  String message;
  MessageType type;

  MessageError({this.message, this.type});
}