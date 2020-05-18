AB Messenger

Run project:
1. add DB credentials to environment
2. add credentials for third services (SendGrid, Nexmo). It uses .env file in development environment

Add users from rails console:
```ruby
CreateUserService.new(
  email: "text@exmple.com",
  phone: "380501234567",
  first_name: "Vasya",
  last_name: "Pupkin"
)
```

Add message templates from rails console:
```ruby
CreateMessageTemplateService.new(
  name: "confirmation",
  text: "Hello, %first_name%!\nYour phone number is %phone%"
)
```

Send *email* from rails console:
```ruby
SendMessageService.new(
  User.first,
  MessageTemplate.first
)
```

Send *SMS* from rails console:
```ruby
SendMessageService.new(
  User.first,
  MessageTemplate.first,
  :sms
)
```
