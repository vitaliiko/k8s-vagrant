Literature:
 - https://kubernetes.io/docs/home/?path=browse
 - https://www.youtube.com/watch?v=CgCLPYJRxbU
 - https://www.youtube.com/watch?v=xFCGzGq3BjU&t=1134s
 - https://github.com/iMarcoGovea/books/blob/master/dev-ops/kubernetes/kubernetes-up-running.pdf
 - https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0
 - https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
 - https://metallb.universe.tf/
 - https://www.weave.works/blog/kubernetes-faq-how-can-i-route-traffic-for-kubernetes-on-bare-metal
 - https://www.weave.works/blog/kubernetes-faq-configure-storage-for-bare-metal-cluster

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