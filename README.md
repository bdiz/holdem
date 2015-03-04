# Holdem

Takes 2 or more hands of cards, evaluates them and declares a winner.

## Installation

Just cd into the repo. Not something to install really.

## Usage

    $ bin/holdem "$(cat <<END
    ac 9s as ad 9d 3c 6d
    kc 9s ks Kd 9d 3c 6d
    Ac Qc Ks Kd 9d 3c
    9h 5s
    4d 2d Ks Kd 9d 3c 6d
    7s Ts Ks Kd 9d
    END
    )"

## Contributing

1. Fork it ( https://github.com/bdiz/holdem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
