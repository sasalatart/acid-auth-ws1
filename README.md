# Web Service 1: Proxy

[![Code Climate](https://codeclimate.com/github/sasalatart/acid-auth-ws1/badges/gpa.svg)](https://codeclimate.com/github/sasalatart/acid-auth-ws1)

> https://acid-auth-ws1.herokuapp.com/

## About

This application acts as a proxy for [another biometric authentication service (WS2)](https://github.com/sasalatart/acid-auth-ws2). Given a user's **email** and **base64 encoded image**, the application will forward the parameters to WS2, which will grant (or not) access to it.

## Framework Used

The [Sinatra](http://www.sinatrarb.com/) framework was used, because this application only serves one single view and has only one `POST` handler.

In this case, given the simplicity of the application, developing it in Sinatra rather than [Ruby on Rails](http://rubyonrails.org/) provided a lighter, faster and more efficient solution (less hardware requirements, consuming less resources).

## API

#### Login

Forwards the user's login request to **WS2**.

- **URL:** `POST /login`

- **Data Params**
  - **email**: The user's email.
  - **image**: The user's base64 encoded image.

- **Success Response:**
  - **Status:** 200
  - **Example content:**
  ```javascript
    {
      message: 'OK'
    }
  ```

- **Error Response:**
  - **Status:** 401
  - **Content:**
  ```javascript
    {
      message: 'No Autorizado'
    }
  ```

- **Sample Call:**

  ```javascript
    $.post({
      url: 'application-host/login',
      data: { email: 'an-email', image: 'base64-image' }
    }).done(function(response) {
      console.log(response);
    }).fail(function(response) {
      console.log(response);
    });
  ```

#### Other requests

Any other `GET` request will respond with the view through which users can log in.

## Development Setup

1. Clone and cd into this repository.
2. Make sure to have the `WS2_URL` environment variable set up with WS2's domain. For example:

  ```sh
  $ export WS2_URL=https://acid-auth-ws2.herokuapp.com
  ```

3. Run `bundle install`
4. Run `rackup`
5. The application should now be listening on `localhost:9292`.

## Testing

As stated before, the application only has one relevant `POST` request, which will depend on WS2's response, which is non-deterministic, and thus makes it unsuitable for testing.

On the other hand, this application has no models (because it acts as a proxy with no database).
