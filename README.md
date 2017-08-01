# Description
Dockerfile for building tacacs+ container using source code of pro-bono-publico implementation.

## Usage
### How to build
```
git clone https://github.com/artgromov/tac_plus
cd tac_plus
docker build --rm -t <your_tag> ./
```
### How to pull from Docker Hub
```
docker pull artgromov/tac_plus
```
### How to run
```
docker run -d -p 49:49 -v <path_to_tac_plus.conf>:/usr/local/etc/tac_plus.conf tac_plus
```

# Reference links and project information

[Main page][1]  
[Manual][2]  
[Default sources link][3]  

[1]: http://www.pro-bono-publico.de/projects/
[2]: http://www.pro-bono-publico.de/projects/tac_plus.html
[3]: http://www.pro-bono-publico.de/projects/src/DEVEL.201706241310.tar.bz2
