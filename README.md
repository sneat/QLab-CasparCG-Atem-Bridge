##QLab-CasparCG-Atem-Bridge

This Mac OSX app is designed to act as a Bridge between QLab, CasparCG and ATEM built specifically so that it can be triggered via Applescript (use the Accessibility Inspector to determine field/button references). Specifically it is being built for use with [XKeys](http://xkeys.com/XkeysKeyboards/index.php) programmable keyboards and [ControllerMate](http://www.orderedbytes.com/controllermate/)

Currently only CasparCG and QLab components are supported.

![screenshot](https://raw.githubusercontent.com/sneat/QLab-CasparCG-Atem-Bridge/master/Screenshot.png)

## Changelog v1.1
- added QLab connection

## Changelog v1.0
- added CasparCG connection
- initial release

## CasparCG

- Enter the CasparCG IP address and port, click Connect.
- Once it connects, it will display a Text Field and Send button at the bottom to allow for any command to be sent to CasparCG.
- You can enter any [AMCP](http://casparcg.com/wiki/CasparCG_2.0_AMCP_Protocol) command into the Text Field. The required "\r\n" will automatically be appended to the string.
- Near the top it will also display a section for trigging a countdown timer in CasparCG.
  - The Flash template is based heavily on the countdown timer provided by [tsipas](http://casparcg.com/forum/memberlist.php?mode=viewprofile&u=695) on the [CasparCG forums](http://casparcg.com/forum/viewtopic.php?t=1114&p=6225).

## QLab

- Enter the QLab IP address listed in the QLab settings page (note: it must be your 'external' IP address, not a 127.0.0.1 address), click Connect.
- Once it connects, it will display a Text Field and Send button at the bottom to allow for any command to be sent to QLab.
- You can enter and [OSC](http://figure53.com/qlab/docs/osc-api/) command supported by QLab.

## References
- [VVOSC](https://github.com/mrRay/vvopensource/) is used as OSC communications framework.
