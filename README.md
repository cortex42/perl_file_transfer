# perl_file_transfer
Little perl script I used in a CTF to transfer files to a machine

Usage:

Receiver:
$ perl transfer.pl 1.2.3.4 31337 > file_to_transfer

Sender:
$ perl transfer.pl -l 31337 file_to_transfer
