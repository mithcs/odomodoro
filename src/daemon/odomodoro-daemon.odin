package daemon

import "core:strings"
import "core:fmt"
import "core:os"
import "core:sys/linux"

INTERVAL :: 1500 // seconds
ODOMODORO :: "/usr/bin/odomodoro"

main :: proc() {
    // ref: http://web.archive.org/web/20060603181849/http://www.linuxprofilm.com/articles/linux-daemon-howto.html#s4
    // ref: https://github.com/pasce/daemon-skeleton-linux-c
    pid, sid: linux.Pid
    err: linux.Errno

    pid, err = linux.fork()

    // handle err here
    // ref: https://pkg.odin-lang.org/core/sys/linux/#Errno

    // An error occurred
    if pid < 0 {
        os.exit(1)
    }

    // Success: Let the parent terminate
    if pid > 0 {
        os.exit(0)
    }

    // Change file mode mask
    linux.umask(linux.Mode{.IXOTH})

    /*
     * Open syslog or any other log here
     */

    // On success: The child process becomes session leader
    sid, err = linux.setsid()
    if (sid < 0) {
        os.exit(1)
    }

    // Change cwd
    if (linux.chdir("/") < linux.Errno(0)) {
        // Log failure here
        os.exit(1)
    }

    // Close out standard file descriptors as they are useless
    // linux.close(linux.STDIN_FILENO)
    // linux.close(linux.STDOUT_FILENO)
    // linux.close(linux.STDERR_FILENO)

    // Setup up timer
    time := linux.Time_Spec { INTERVAL, 0 }

    vars: [^]cstring

    env_DISPLAY := strings.clone_to_cstring(fmt.aprintf("DISPLAY=%s", os.get_env("DISPLAY")))
    env_XAUTHORITY := strings.clone_to_cstring(fmt.aprintf("XAUTHORITY=%s", os.get_env("XAUTHORITY")))

    vars_crazyy := [?]cstring { env_DISPLAY, env_XAUTHORITY }
    vars = raw_data(vars_crazyy[:])

    // Call the program here
    for {
        linux.nanosleep(&time, &time)

        pid, err = linux.fork()

        // fork failed
        if pid < 0 {
            os.exit(1)
        }

        // child process
        if pid == 0 {
            linux.execve(ODOMODORO, nil, vars)
            os.exit(1) // if execve fails terminate child process
        }
    }
}
