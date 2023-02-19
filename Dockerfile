FROM ubuntu:18.04

WORKDIR "/workspace"
ADD Real-Time-Voice-Cloning /workspace/Real-Time-Voice-Cloning
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && apt-get install -y curl python3.7 python3.7-dev cmake git python3.7-distutils \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 \
    && update-alternatives --set python /usr/bin/python3.7 \
    && curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py --force-reinstall \
    && rm get-pip.py \
    && apt-get install -y ffmpeg libportaudio2 openssh-server python3-pyqt5 xauth \
    && apt-get -y autoremove \
    && pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu \
    && python3 -V \
    && pip install -r /workspace/Real-Time-Voice-Cloning/requirements.txt 
#RUN mkdir /var/run/sshd \
#        && mkdir /root/.ssh \
#        && chmod 700 /root/.ssh \
#        && ssh-keygen -A \
#        && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
#        && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
#        && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
#        && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
#RUN echo "<REPLACE THIS SENTENCE (INCLUDING ARROWS) WITH YOUR SSH PUBLIC KEY ON THE DOCKER HOST>" \ 
#    >> /root/.ssh/authorized_keys
RUN echo "export PATH=/opt/conda/bin:$PATH" >> /root/.profile
#ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && bash"]
ENTRYPOINT ["sh", "-c", " bash"]
CMD ["bash"]
