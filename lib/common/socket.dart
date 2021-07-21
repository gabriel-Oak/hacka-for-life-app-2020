import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  static IO.Socket socket = IO.io('http://18.228.10.182:4000/', <String, dynamic>{
    'transports': ['websocket']
  });
}
