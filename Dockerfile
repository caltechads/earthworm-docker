FROM centos:7
MAINTAINER joncon@uw.edu

ENV EW_VER 7.9
ENV EW_LOG /eworm/run/log/
ENV EW_PARAMS /eworm/run/params/
ENV EW_INSTALLATION INST_UNKNOWN
ENV PLATFORM LINUX

WORKDIR /etc
RUN rm -rf localtime && ln -s /usr/share/zoneinfo/America/Los_Angeles localtime
ENV LC_ALL en_US.UTF-8
ENV PYTHONUNBUFFERED 1

#install packages
RUN yum -y install epel-release && \
    yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y makecache fast && \
    yum update -y && \
    yum install -y \
        glibc-devel \
        glibc-headers \
        libgcc \
        libstdc++-devel \
        libgfortran \
        gcc \
        gcc-c++ \
        gcc-gfortran \
        libgfortran \
        make \
        wget \
        which \
        vim \
        less \
        file \
        mailx \
        sendmail \
        supervisor && \
    # Set up the UTF-8 locale so that shelling into the container won't spam you with locale errors.
    localedef -i en_US -f UTF-8 en_US.UTF-8
    
#stub out dirs
RUN mkdir -p /eworm/run/params \
             /eworm/run/log \
             /eworm/tankfiles && \
    ln -s /usr/bin/gfortran /usr/bin/f77

#get ew and unzipd
RUN cd /eworm \
    && wget http://folkworm.ceri.memphis.edu/ew-dist/v$EW_VER/earthworm_$EW_VER-src.tar.gz \
    && tar -xzvf earthworm_$EW_VER-src.tar.gz

# Patch the makefile for q2ew to actually work
# See: http://earthworm.isti.com/trac/earthworm/ticket/582
COPY src/makefile.unix-q2ew /eworm/earthworm_$EW_VER/src/data_sources/q2ew/makefile.unix

ENV EW_LINUX_FILE=/eworm/earthworm_$EW_VER/environment/ew_linux.bash

#edit environment
RUN sed -i -e s/run_working/run/g $EW_LINUX_FILE \
    && sed -i -e 's/^export GLOBALFLAGS.*/export GLOBALFLAGS="-fno-stack-protector -fPIC -Dlinux -D_LINUX -D_INTEL -D_USE_SCHED  -D_USE_PTHREADS -D_USE_TERMIOS -I${EW_HOME}\/${EW_VERSION}\/include"/' $EW_LINUX_FILE \
    && sed -i -e 's/^export EW_HOME=.*/export EW_HOME="${EW_INSTALL_HOME:-\/eworm}"/' $EW_LINUX_FILE \
    && sed -i -e 's/^export EWBITS=.*/export EWBITS=64/' $EW_LINUX_FILE \
    && cp $EW_LINUX_FILE /eworm/run/params
  
RUN echo "source $EW_LINUX_FILE" >> /root/.bashrc

RUN source /root/.bashrc

RUN source $EW_LINUX_FILE

#compile
WORKDIR /eworm/earthworm_$EW_VER/src
RUN source $EW_LINUX_FILE && make unix
  
#copy files
RUN cp /eworm/earthworm_$EW_VER/params/* /eworm/run/params && \
    cp /eworm/earthworm_$EW_VER/environment/earthworm.d /eworm/run/params && \
    cp /eworm/earthworm_$EW_VER/environment/earthworm_global.d /eworm/run/params && \
    cp /eworm/earthworm_$EW_VER/environment/earthworm_commonvars.d /eworm/run/params

COPY ./bin/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    adduser -r aqms && \
    chown -R aqms /eworm/run

WORKDIR /eworm/run/params

COPY etc/supervisord.conf /etc/supervisord.conf

ENV PATH /eworm/earthworm_$EW_VER/bin:$PATH
ENV EW_HOME /eworm
ENV EW_VERSION earthworm_$EW_VER

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
