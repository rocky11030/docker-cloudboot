安装注意事项
========

先编辑group_vars/all里面的变量


第一步: 前期准备
--------------

* 填写hosts里面的cloudboot地址
* 先安装ubuntu和centos的docker17.05环境
* 注意: cloudboot的镜像仓库由于太大没有上传

第二步: 执行安装cloudboot
--------------

* 执行命令: ansible-playbook -i hosts setup-cloudboot.yml
* 注意:先要把cloudboot镜像导入到目标主机，暂时还没写从镜像仓库拉取主机

