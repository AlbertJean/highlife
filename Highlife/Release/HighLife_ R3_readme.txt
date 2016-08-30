HighLife R3 readme. 

This update greatly improves the sfz import in HighLife and brings it more 
in line with the official sfz specs. Most sfz files can now be used rightaway 
without the need to edit out any unsupported features or moving the soundfiles 
around on the computer.
The overall stability of the Program has been improved.

If you happen to find a bug in this software or anything objectionable then please take the time and send me a report.
Only then I will be able to fix it.

Please submit your comments, bug reports and suggestions: 

(1) to the HighLife R3 thread at kvraudio:
http://www.kvraudio.com/forum/viewtopic.php?t=245750
(2) via email to info@soundbytes.de
(3) or to the tracker at sourceforge.net
http://sourceforge.net/tracker2/?group_id=209777

Thanks!

CHANGES IN R3:

SFZ PARSER

(1) Sample path can be relative or absolute to any location on the storage media:
Examples:
sample=..\..\path\to\sample.wav
sample=D:\path\on\dvd\sample.wav

(2) Path names may contain blank spaces
Example:
sample=..\path to\sample.wav

(3) The key opcode is now recognized.

(4) Midi note names can now be used alternatively to midi note numbers.
Example:
lokey=F2 hikey=G#2 pitch_keycenter=G2

(3) The <group> header can now be used.
Example:
<group>
lovel=1 hivel=92
<region> sample=sample1.wav
<region> sample=sample2.wav

(4) Comments can be put on the same line with opcodes
Example:
hivel=29 lovel=17 // this is a comment

FURTHER FIXES AND CHANGES:

(1) A couple of wave files that were refused by the previous version will now load fine.
(2) Loopinfo will not be used if loopstart > loopend (workaround for some nonstandard wav editors)
(3) When creating loop crossfades Highlife now implements a equal power crossfade instead of the previously used equal gain (linear) crossfade
(4) Highlife won't crash anymore whenever a sample can't be opened. Instead an error message is displayed and the load process is reverted. 
(5) The panel color was modified to make the open source version better distinguishable from the commercial version of the plugin.
(6) about box added. (Click on the Highlife Logo to open)
(7) The following additional zone parameters can now be modified in the zone editor view:
	root key, low key, high key, low velocity, high velocity
   
HIGHLIFE SFZ IMPLEMENTATION:

Supported sfz Opcodes:
sample, lokey, hikey, key, lovel, hivel, offset, tune, pitch_keytrack, pitch_keycenter,
transpose, volume, pan, loop_start, loop_end, loop_mode, loccN, hiccN,
lobend, hibend, lochanaft, hichanaft, lopolyaft, hipolyaft, trigger, group, off_by

Supported Sfz Headers:
<region>, <group> (New!)

HighLife supports a subset of the sfz specification v1.0 opcodes.
Unsupported opcodes can be included in the file. These will be ignored
and should not cause any errors or misinterpretations.
unsupported headers (sfz v2.0 or third party) will be skipped.
The parser will jump the next header if it finds an unknown one and 
ignore all opcodes inbetween.

KNOWN ISSUES:

(1) A HighLife SFZ file may not include a sample reference to an .ogg file
Workaround:  Please use wav or mp3 sample references instead.
(2) Freezing a multichannel instrument patch (like sampletank or samplelord) will create multichannel and not stereo wav files. 
Recommended Workaround: when freezing a multi channel instrument please use a vsti chainer with a stereo output as Wrapper.

Mar-30-2009 - Andreas Sumerauer - contact:info@soundbytes.de
