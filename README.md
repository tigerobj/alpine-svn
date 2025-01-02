

# alpine-svn
## 描述:
docker映像檔使用Alpine Linux安裝Subversion 並且使用WebDAV 來存取。這個映像檔版本有啟動'Auto-versioning'功能。2 tester
## 建構
```
git clone https://github.com/tigerobj/alpine-svn.git
cd alpine-svn
docker build -t tigerobj/alpine-svn .
```

## 執行
啟動容器的命令，並指定外部主機的port為8080，對應到容器的port80。設定啟動容器的名字為andy
請在瀏覽器打http://192.168.X.X:8080/svn:
```
docker run -p 8080:80 --name andy -d tigerobj/alpine-svn
```
啟動容器預設帳號: davsvn (密碼: davsvn)，並且預設儲存庫(repository): repo
```
docker run -p 8080:80 --name andy -d -e SVN_REPO=repo  tigerobj/alpine-svn
```
啟動容器指定帳號: user(密碼: pass)，並且預設儲存庫(repository): repo
```
docker run -p 8080:80 --name andy -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass tigerobj/alpine-svn
```
啟動容器指定帳號: user (密碼: pass)，並且指定儲存庫(repository): repo
```
docker run -p 8080:80 --name andy -d -e DAV_SVN_USER=user -e DAV_SVN_PASS=pass -e SVN_REPO=repo tigerobj/alpine-svn
```
## 主機的儲存容量
docker容器擴大分配儲存空間，預設容器為50GB。也就是說啟動一個容器預設就是50GB的大小。

## 使用
快速查詢容器的程序
```
docker ps
```

Then, in a new directory elsewhere:
在一個新的目錄做取出的動作
```
svn co --username davsvn --password davsvn http://192.168.X.X:8080/svn/repo
cd repo
# add/chg/commit as usual
```

And the magic (do in a new directory)
請注意要使用指定的帳號密碼 davsvn(davsvn)
-e DAV_SVN_USER=davsvn -e DAV_SVN_PASS=davsvn

```
echo "1. hello my svn test" > testsvn.txt
curl -u davsvn:davsvn -X PUT -T testsvn.txt http://192.168.X.X:8080/svn/repo/greeting.txt
```

Refer http://svnbook.red-bean.com/en/1.7/svn.webdav.autoversioning.html for canonical SVNAutoversioning info.
