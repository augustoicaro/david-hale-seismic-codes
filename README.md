# Dave Hale's personal repository

__David Hale didn't provide the data folder, so try to understand how functions work and use your data.__

Folders descriptions:

* __bench/:__ Dave's workbench for research
If you know how to build and use the [Mines Java Toolkit](https://github.com/MinesJTK/jtk) then you may find this useful. 
It's sort of like my messy garage, with lots of junk that is old 
and should be discarded.
* __gp404:__ source code for classes used in one of Dave's courses at Mines.
* __www/:__ source code for Dave's web site: http://inside.mines.edu/~dhale

## Using this repo

This repository install all java dependencies that you need to use files of __bench__ folder.

Steps:

1. Check in `Dockerfile:15` if the JVM heap size it is ok: (Change 24 to the desired size)
    ``` docker
    ENV _JAVA_OPTIONS -Xmx24g
    ```

2. Build docker container:

    ``` bash
    docker build --build-arg USERNAME=$USER --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t hale/idh:latest .
    ```

3. Enter in container with compiled JTK and binded IDH folder

    ``` bash
    docker run -it --gpus all --name idh --rm --net host -v /home/$USER/idh:/home/$USER/idh -v /home/$USER/idh/data:/data -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/resolv.conf:/etc/resolv.conf -v /usr/lib/nvidia:/usr/lib/nvidia -e DISPLAY=$DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all hale/idh:latest bash
    ```

4. (Optional) Run JTK tests

    ``` bash
    cd jtk
    gradle run -P demo=mosaic.PlotFrameDemo
    gradle run -P demo=mosaic/PlotFrameDemo.py
    gradle run -P demo=ogl.HelloDemo
    ```

5. Build bench folder

    ``` bash
    cd 
    cd idh/bench
    gradle 
    ```

6. Run a code

    ``` bash
    gradle run -x processResources -P app=lcc.Warp1
    ```

To run another application just browse the folders in `bench/src/` and find a file with a `main()` function.