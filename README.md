# web-server

## Terraform

### init

```console
$ terraform init -backend-config="bucket=<your bucket name>"
```

## Development

### Start server with hot-reload

```console
$ docker build -t web-server .
$ docker run -p 3000:3000 web-server 
```

```console
$ open http://localhost:3000 
```
