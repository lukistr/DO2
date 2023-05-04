docker:
  pkg.installed:
    - name: docker.io

modify.user:
  user.present:
    - name: vagrant
    - optional_groups:
      - docker

install.docker.py:
  pip.installed:
    - name: docker >= 5 , < 6
    - upgrade: True

nginx:
  docker_container.running:
    - name: nginx
    - image: nginx:latest
    - port_bindings:
        "80/tcp":
          - HostPort: "8080"
    - require:
      - pkg: docker.io