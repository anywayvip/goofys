Рабочая схема https://github.com/kahing/goofys/issues/527#issuecomment-673909445

```
134  sudo curl -O https://storage.googleapis.com/golang/go1.11.8.linux-amd64.tar.gz
  135  tar --help
  136  tar -xvf go1.11.8.linux-amd64.tar.gz 
  137  sl -l 
  138  ls -l
  139  mv go /usr/local/
  140  ls -l /usr/local/
  141  ln -s /usr/local/go/bin/go /usr/bin/go
  142  go version
  143  export GOPATH=$HOME/work
  144  go get github.com/kahing/goofys
  145  git --version
  146  go get github.com/kahing/goofys
  147  git clone github.com/kahing/goofys
  148  git clone https://github.com/kahing/goofys
  149  go install github.com/kahing/goofys
  150  ls -l 
  151  rm -rf goofys/
  152  go get github.com/kahing/goofys
  153  go install github.com/kahing/goofys
  154  echo $PATH
  155  export GOPATH=$HOME/work
  156  go get github.com/kahing/goofys
  157  pwd
  158  cd /root/
  159  mkdir -p go/src/github.com/kahing
  160  cd go/src/github.com/kahing/
  161  git clone https://github.com/kahing/goofys.git
  162  ls -l
  163  export GOPATH=/root/go
  164  export GOOFYS_HOME=/root/go/src/github.com/kahing/goofys/
  165  cd /root/go/src/github.com
  166  go get github.com/Azure/azure-pipeline-go
  167  cd /root/go/src/github.com/kahing/goofys
  168  git submodule init
  169  git submodule update
  170  go install /root/go/src/github.com/kahing/goofys/
  171  PATH=$PATH:/root/go/bin; export PATH
  172  goofys --version
  173  cat ~/.aws/credentials
  174  vim /root/.aws/credentials
  175  sudo vim /root/.aws/credentials
  176  mkdir /root/.aws
  177  sudo vim /root/.aws/credentials
  178  cat /root/.aws/credentials
  179  mkdir -p /mnt/s3fs/backup
  180  goofys --endpoint=https://storage.yandexcloud.net yc-gitlab.npcmr.ru /mnt/s3fs/backup
  181  cat /var/log/syslog
  182  su - root
  183  df -hT
  184  cd /mnt/s3fs/backup/
  185  sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
  186  ды -дф
  187  ls -l
  188  rm -f tempfile 
  189  cd /
  190  ls -l
  191  sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
  192  lsblk 
  193  cat /root/.aws/credentials 
  194  umount /mnt/s3fs/backup 
  195  df -hT
  196  vim /etc/fstab 
  197  mount -a
  198  vim /etc/fstab 
  199  mount -a
```

Разовое мантирование.

goofys --endpoint=https://storage.yandexcloud.net <имя бакета> <точка монтирования> --uid=998,--gid=998,--file-mode=0777,--dir-mode=0777

fstab

/root/go/bin/goofys#yc-gitlab.npcmr.ru   /mnt/s3fs/backup        fuse     _netdev,allow_other,--uid=998,--gid=998,--file-mode=0777,--dir-mode=0777,--endpoint=https://storage.yandexcloud.net    0       0


docker run -v ./