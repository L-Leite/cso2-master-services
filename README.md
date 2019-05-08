# cso2-master-services

This repository includes all the services required to run a master server for Nexon's Counter-Strike: Online 2.

You may use [```docker-compose```](https://docs.docker.com/compose/) to run these services all at once, or run separate services in separate servers.

You can also get [client launcher](https://github.com/Ochii/cso2-launcher/) to use with this.

## Communities

You can find other players in these.

If your community isn't listed here feel free to open pull request with it.

*Note: These communities are not run by the repository owner.*

- [Counter Strike Online Wiki's discord](https://discord.gg/GKPgrBG) (discuss at #cso2-project-discussion)
- [CSO2 Revive](https://discord.gg/3tydYTC) (in Korean)
- [Counter-Strike Online 2 - EU/RU Server](https://discord.gg/yue5Zaf) (in English)


## Running all the services with ```docker-compose```

You must have installed both [```docker```](https://docs.docker.com/) and [```docker-compose```](https://docs.docker.com/compose/) in order to run the services all at once.

### Preparation

The repository has two ```docker-compose``` configuration files, `docker-compose.development.yml` and `docker-compose.production.yml`.

`docker-compose.development.yml` can be used for development environments, where `docker-compose.production.yml` can be used for development production environments (such as a remote server).

Rename the configuration file you prefer to `docker-compose.yml` so you can use it with ```docker-compose```.

### Startup

If this is your first time running the services, use ```docker-compose up -d``` to start them. If not you can use ```docker-compose start -d```.

To stop the services, enter ```docker-compose down```.

## Services bundled

The following services bundled in this repository:

- [cso2-master-server](https://github.com/Ochii/cso2-master-server)
- [cso2-users-service](https://github.com/Ochii/cso2-users-service)
- [cso2-inventory-service](https://github.com/Ochii/cso2-inventory-service)
- [cso2-webapp](https://github.com/Ochii/cso2-webapp)

## Pull requests

Pull requests are very much welcome.

Before you create one, be sure you're in the right repository. See [Services bundled](##Services-bundled) for a list of repositores bundled here.

Also please read the [contributing guide](https://github.com/Ochii/cso2-master-services/blob/master/.github/PULL_REQUEST_TEMPLATE.md) before contributing.

## License

Read ```LICENSE``` for the project's license information.

This project is not affiliated with either Valve or Nexon. Counter-Strike: Online 2 is owned by these companies.
