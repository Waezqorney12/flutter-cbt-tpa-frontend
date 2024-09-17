import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient {
  late WebSocketChannel _webSocketChannel;
  late StreamController<UserModel> _controller;
  final String url = dotenv.env['WebSocket_URL']!;
  final int id = 52;

  Stream<UserModel> get userStream => _controller.stream;

  Future getWebSocket({required String authToken}) async {
    _controller = StreamController<UserModel>.broadcast();

    _webSocketChannel = WebSocketChannel.connect(Uri.parse(url));
    Log.loggerInformation('WebSocket connected: $url/App.Models.User.$id \n with token: $authToken');

    try {
      await _webSocketChannel.ready;

      _webSocketChannel.stream.listen(
        (data) {
          Log.loggerInformation('Received data from WebSocket: $data');
          Map<String, dynamic> json = jsonDecode(data);
          final user = UserModel.fromJson(json);
          _webSocketChannel.sink.add(user);
          _controller.sink.add(user);
        },
        onError: (err) => error(err),
        onDone: () => disconnect(),
      );
    } on SocketException catch (e) {
      Log.loggerFatal("This is SocketException: ${e.message}, ${e.address}, ${e.port}");
      rethrow;
    } on WebSocketChannelException catch (e) {
      Log.loggerFatal("This is WebsocketException: ${e.message}, ${e.inner}");
      rethrow;
    } catch (e) {
      Log.loggerFatal("This is Exception: $e");
      rethrow;
    }
  }

  void error(dynamic error) {
    Log.loggerFatal('This is Error function connecting to WebSocket: $error');
    _controller.sink.addError(error);
  }

  Future disconnect() async {
    Log.loggerFatal('WebSocket connection closed');
    await _webSocketChannel.sink.close();
    _controller.sink.close();
  }
}
