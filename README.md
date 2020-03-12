# Space Invaders

Application takes a radar sample as an argument and reveal possible locations of those pesky invaders.

## Notes
Scan algorithm could be better: currently it does not reveal possible invaders if they partially appeared in radar. For example, there is a possible invader and very bottom of radar sample.

Result of scan is optimized radar sample with revealed invaders.

## Setup

Run this command to install dependencies:

    $ ./bin/setup

## Usage

Run ruby console:

    $ ./bin/console

And then execute:
```ruby
radar_sample = File.read('spec/fixtures/radar_sample.txt')
invader_1 = File.read('spec/fixtures/invader_1.txt')
invader_2 = File.read('spec/fixtures/invader_2.txt')

result = SpaceInvaders::Scanner.call(radar_sample: radar_sample, invaders: [invader_1, invader_2])
puts result
```

## Testing

Run rspec:

    $ bundle exec rake spec