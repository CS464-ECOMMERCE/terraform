## Deployment

Deploying all applications with a list will cause Github API to throttle or rate limit. Read more about it here.
[Github: Avoiding Concurrent Request](https://docs.github.com/en/rest/using-the-rest-api/best-practices-for-using-the-rest-api?apiVersion=2022-11-28#avoid-concurrent-requests)

```bash
terraform init
terraform apply -parallelism=1 # Must apply option `-parallelism=1` to make it execute serially.
```
