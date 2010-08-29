# DenonTool

A Mac OSX command line tool that demonstrates querying the status of a Denon AVR-4308CI receiver.

## Building DenonTool

1. Clone or download this repository.
2. Clone or download [DenonRemoteLib](http://github.com/jhh/DenonRemoteLib "jhh's DenonRemoteLib at master - GitHub") next to the "DenonTool" project directory. Xcode will find the DenonRemoteLib classes using a relative file path from the DenonTool project directory (`../DenonRemoteLib/Classes`).

## Using DenonTool

    $ DenonTool 10.0.1.2
    
       Receiver power: ON
                 Mute: OFF
         Input source: TV/CBL
        Master Volume: -27.5 dB
    Master Volume Max: 1.5 dB
  

## License

DenonTool is published under the Apache License, see the LICENSE file.