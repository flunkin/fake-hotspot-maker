#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    char *iface = "wlan0";
    char *ssid = "Flunkin-Ipod";

    // check if user has given interface if not defualt to wlan0
    if (argc > 1) {
        iface = argv[1];
    }

    // check to see if user has given ssid
    if (argc > 2) {
        ssid = argv[2];
    }

    char cmd[256];

    // make cmd to call shell script
    sprintf(cmd, "./start_hotspot.sh %s %s", iface, ssid);

    printf("starting hotspot with interface %s and ssid %s\n", iface, ssid);

    int result = system(cmd);

    if (result == -1) {
        printf("error: could not run the command\n");
        return 1;
    } else {
        // check if the cmd has even worked
        if (result != 0) {
            printf("hotspot script finished with error code %d\n", result);
            return 1;
        }
    }

    printf("hotspot started successfully.\n");

    return 0;
}
