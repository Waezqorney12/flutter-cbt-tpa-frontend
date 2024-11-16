import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  late WebSocketChannel webSocketChannel;
  final String url = dotenv.env['WebSocket_URL']!;

  Future<WebSocketChannel> getWebSocket({required String authToken}) async {
    final Completer<WebSocketChannel> completer = Completer<WebSocketChannel>();
    webSocketChannel = IOWebSocketChannel.connect(
      Uri.parse('$url/app/bb0da739e4917b7fe49e?protocol=7&client=js&version=4.4.0&flash=false').replace(
        scheme: 'ws',
      ),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    try {
      await webSocketChannel.ready.then((_) {
        completer.complete(webSocketChannel);
      }).catchError((error) {
        completer.completeError(error);
      });
      webSocketChannel.stream.listen(
        (data) {
          Log.loggerInformation('Received data from WebSocket: $data');
          Map<String, dynamic> json = jsonDecode(data);
          final user = UserModel.fromJson(json);

          webSocketChannel.sink.add(user);
        },
        onError: (err) => error(err),
        onDone: () => disconnect(),
      );
      return completer.future;
    } on SocketException catch (e) {
      throw ServerException(message: 'SocketException: ${e.message}, ${e.address}, ${e.port}');
    } on WebSocketChannelException catch (e) {
      throw ServerException(message: 'WebSocketChannelException: ${e.message}, ${e.inner}');
    } catch (e) {
      throw ServerException(message: 'Exception: $e');
    }
  }

  void error(dynamic error) => webSocketChannel.sink.addError(error);

  Future disconnect() async => await webSocketChannel.sink.close();
}
