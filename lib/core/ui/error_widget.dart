import 'package:micropolis_test/core/Common/Utils.dart';
import 'package:micropolis_test/core/errors/bad_request_error.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/errors/connection_error.dart';
import 'package:micropolis_test/core/errors/custom_error.dart';
import 'package:micropolis_test/core/errors/forbidden_error.dart';
import 'package:micropolis_test/core/errors/internal_server_error.dart';
import 'package:micropolis_test/core/errors/not_found_error.dart';
import 'package:micropolis_test/core/errors/timeout_error.dart';
import 'package:micropolis_test/core/errors/unauthorized_error.dart';
import 'package:micropolis_test/core/localization/translations.dart';
import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  final BaseError? error;
  final dynamic state;
  final bool disableRetryButton;

  const ErrorScreenWidget(
      {Key? key, this.error, this.state, this.disableRetryButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final error = state.error;
    print(error.runtimeType);
    {
      if (error is TimeoutError) {
        return TimeOutErrorScreenWidget(
          callback: state.callback,
          disableRetryButton: this.disableRetryButton,
        );
      }
      // Connection Error
      if (error is ConnectionError) {
        return ConnectionErrorScreenWidget(
            callback: state.callback,
            disableRetryButton: this.disableRetryButton);
      }
      // Custom Error
      else if (error is CustomError) {
        return CustomErrorScreenWidget(
            message: error.message,
            disableRetryButton: this.disableRetryButton);
      }
      // Unauthorized Error
      else if (error is UnauthorizedError) {
        return UnauthorizedErrorScreenWidget();
      }
      // Not Found Error
      else if (error is NotFoundError) {
        return NotFoundErrorScreenWidget(
            callback: state.callback,
            disableRetryButton: this.disableRetryButton);
      }
      // Bad Request Error
      else if (error is BadRequestError) {
        return BadRequestErrorScreenWidget();
      }
      // Forbidden Error
      else if (error is ForbiddenError) {
        return ForbiddenErrorScreenWidget();
      }
      // Internal Server Error
      else if (error is InternalServerError) {
        return InternalServerErrorScreenWidget(
            callback: state.callback,
            disableRetryButton: this.disableRetryButton);
      } else if (error is TimeoutError) {
        return TimeoutErrorScreenWidget(
            callback: state.callback,
            disableRetryButton: this.disableRetryButton);
      }
    }
    return UnexpectedErrorScreenWidget(
        callback: state.callback, disableRetryButton: this.disableRetryButton);
  }
}

class ConnectionErrorScreenWidget extends StatelessWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const ConnectionErrorScreenWidget({
    Key? key,
    required this.callback,
    this.disableRetryButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_connection') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}

class TimeOutErrorScreenWidget extends StatelessWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const TimeOutErrorScreenWidget(
      {Key? key, required this.callback, this.disableRetryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_timeout') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}

class InternalServerErrorScreenWidget extends StatelessWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const InternalServerErrorScreenWidget(
      {Key? key, required this.callback, this.disableRetryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_internal_server') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}

class ForbiddenErrorScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(
        Translations.of(context)?.translate('error_forbidden_error') ?? "",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BadRequestErrorScreenWidget extends StatelessWidget {
  final String? message;
  const BadRequestErrorScreenWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? Translations.of(context)?.translate('error_BadRequest_Error') ?? "",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotFoundErrorScreenWidget extends StatelessWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const NotFoundErrorScreenWidget(
      {Key? key, required this.callback, this.disableRetryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_NotFound_Error') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}

class UnauthorizedErrorScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(
        Translations.of(context)?.translate('error_Unauthorized_Error') ?? "",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomErrorScreenWidget extends StatelessWidget {
  final String message;
  final VoidCallback? callback;
  final bool? disableRetryButton;
  const CustomErrorScreenWidget(
      {Key? key, required this.message, this.callback, this.disableRetryButton})
      : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          callback == null ||
                  (disableRetryButton != null && disableRetryButton == true)
              ? Container()
              : RaisedButton(
                  onPressed: callback,
                  child: Text(
                    Translations.of(context)?.translate('btn_Rty_title') ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                ),
        ],
      ),
    );
  }
}

class UnexpectedErrorScreenWidget extends StatelessWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const UnexpectedErrorScreenWidget(
      {Key? key, required this.callback, this.disableRetryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_general') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}

class TimeoutErrorScreenWidget extends StatelessWidget {
  final VoidCallback? callback;
  final bool? disableRetryButton;
  const TimeoutErrorScreenWidget(
      {Key? key, @required this.callback, this.disableRetryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context)?.translate('error_Timeout_Error') ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (disableRetryButton == null || disableRetryButton == false)
            RaisedButton(
              onPressed: callback,
              child: Text(
                Translations.of(context)?.translate('btn_Rty_title') ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            ),
        ],
      ),
    );
  }
}
