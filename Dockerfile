FROM cocoon/python
MAINTAINER cocoon

# install uiautomator wrapper
RUN pip install uiautomator

# install adb tool

# Stop debconf from complaining about missing frontend
ENV DEBIAN_FRONTEND noninteractive

# 32-bit libraries and build deps for ADB
RUN dpkg --add-architecture i386 &amp;&amp; \
    apt-get update &amp;&amp; \
    apt-get -y install libc6:i386 libstdc++6:i386 &amp;&amp; \
    apt-get -y install wget unzip

# Install ADB
RUN wget --progress=dot:giga -O /opt/adt.zip \
      http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip &amp;&amp; \
    unzip /opt/adt.zip adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb -d /opt &amp;&amp; \
    mv /opt/adt-bundle-linux-x86_64-20140702 /opt/adt &amp;&amp; \
    rm /opt/adt.zip &amp;&amp; \
    ln -s /opt/adt/sdk/platform-tools/adb /usr/local/bin/adb

# Set up insecure default key
RUN mkdir -m 0750 /.android
ADD files/insecure_shared_adbkey /.android/adbkey
ADD files/insecure_shared_adbkey.pub /.android/adbkey.pub

# Clean up
RUN apt-get -y --purge remove wget unzip &amp;&amp; \
    apt-get -y autoremove &amp;&amp; \
    apt-get clean &amp;&amp; \
    rm -rf /var/cache/apt/*

# Expose default ADB port
EXPOSE 5037

# Start the server by default. This needs to run in a shell or Ctrl+C won&#39;t
# work.
CMD /usr/local/bin/adb -a -P 5037 fork-server server
