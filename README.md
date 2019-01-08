Kubernetes lections (RUS):
  - https://www.youtube.com/watch?v=xFCGzGq3BjU
  - https://www.youtube.com/watch?v=oZxHieKKnHs
  - https://www.youtube.com/watch?v=x4M9qP8wdTU
  - https://www.youtube.com/watch?v=srBQOOpiAow

#### Dashboard access:

Run on master:

```bash
kubectl create -f /vagrant/examples/user/admin-user.yml
kubectl create -f /vagrant/examples/user/admin-role.yml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
kubectl proxy
```

Copy token from above `describe` command, run ssh port proxy and login to dashboard:

On host machine run (Password: vagrant):

```bash
ssh -L 8001:127.0.0.1:8001 vagrant@172.42.42.100
```

Open dashboard in browser and login with token:

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

Save token for future logins.