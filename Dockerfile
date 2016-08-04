# add a base image
FROM lsucrc/crcbase
USER crcuser

# download funwave source code and extract it 
WORKDIR /model
RUN wget --secure-protocol=auto https://www1.udel.edu/kirby/programs/funwave/funwave-version2.1.zip && \
    unzip funwave-version2.1.zip

WORKDIR funwave-version2.1/src

# remove -C option to avoid generating C comments
RUN sed -i 's/DEF_FLAGS     = -P -C -traditional/            DEF_FLAGS     = -P -traditional/' Makefile
RUN sed -i '/^\smv/d' Makefile

# compile funwave
RUN make 

# set up enviroment variable of funwave
ENV PATH $PATH:/model/funwave-version2.1/src
RUN chmod +rx /model/funwave-version2.1/src/mytvd
