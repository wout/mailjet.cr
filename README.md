# Mailjet API client for Crystal

Mailjet is an email platform for teams to send transactional & marketing emails.
It is a GDPR compliant and ISO 27001 certified Email Service Provider.

[![Build Status](https://travis-ci.org/tilishop/mailjet.cr.svg?branch=master)](https://travis-ci.org/tilishop/mailjet.cr)
[![GitHub version](https://badge.fury.io/gh/tilishop%2Fmailjet.cr.svg)](https://badge.fury.io/gh/tilishop%2Fmailjet.cr)

## Disclaimer
This is the unofficial [Crystal](https://crystal-lang.org/) shard for Mailjet.
The majority of the API is covered, but some parts still need to be added.

## Requirements
To use the Mailjet API client, you will need a free
[Mailjet account](https://app.mailjet.com/signup).

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  mailjet:
    github: tilishop/mailjet.cr
```

2. Run `shards install`

## Usage

```crystal
require "mailjet"
```

### Send your first email

```crystal
response = Mailjet::Send.messages([
  {
    "From": {
      "Email": "from@email.com",
      "Name":  "Me",
    },
    "To": [
      {
        "Email": "to@email.com",
        "Name":  "You",
      },
    ],
    "Subject":  "My first Mailjet Email!",
    "TextPart": "Greetings from Mailjet!",
    "HTMLPart": <<-HTML
      <h3>
        Dear passenger 1, welcome to
        <a href='https://www.mailjet.com/'>Mailjet</a>!
      </h3>
      <br />
      May the delivery force be with you!
    HTML
  }
])

message = response.first
puts message.status
# => "success"
```

### Retrieve sent messages
Now, let’s view the status of the sent message and its configuration specifics.

```crystal
message = Mailjet::Message.find(576460754655154659)
puts message.status
# => "opened"
```

### View message history
You can track important events linked to the sent emails, for example whether 
the recipient opened the message, or clicked on a link within.

```crystal
events = Mailjet::Messagehistory.all(576460754655154659)
puts events.first.event_type
# => "sent"
puts events.last.event_type
# => "opened"
```

### Retrieve Statistics
The Mailjet API also has a variety of resources that help retrieve aggregated 
statistics for key performance indicators like opens, clicks, unsubscribes, etc.

Let's take a look at just one of those resources to give you a sample of the 
data you can read - we’ll retrieve total aggregated statistics for your API key.

```crystal
counters = Mailjet::Statcounters.by_api_key({
  counter_timing:     "event",
  counter_resolution: "hour",
  from_ts:            Time.local.at_beginning_of_day.to_unix,
  to_ts:              Time.local.to_unix,
})
puts counters.first.event_opened_count
# => 28
```

## Documentation

- [Shard API Docs](https://tilishop.github.io/mailjet.cr/)

## To-do
Most of the API is covered, but the following endpoints are not:
- [ ] All Message Events
- [ ] Bulk contact management and CSV import
- [ ] Parse
- [ ] Settings
- [ ] SMS
- [ ] Statistics (only statcounters is done)
- [ ] Webhook

## Contributing

1. Fork it (<https://github.com/tilishop/mailjet/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [wout](https://github.com/wout) - creator and maintainer
- [tilishop](https://github.com/tilishop) - owner and maintainer
