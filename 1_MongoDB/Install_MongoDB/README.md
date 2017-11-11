# Install_MongoDB

This cookbook installs and tests a base install of MongoDB.

## Cookbook Info

This cookbook makes use of the following Chef Resources:

* [Directory](https://docs.chef.io/resource_directory.html)
* [Template](https://docs.chef.io/resource_template.html)
* [Package](https://docs.chef.io/resource_package.html)
* [Service](https://docs.chef.io/resource_service.html)

## Testing

This cookbook was tested using [Test Kitchen](http://kitchen.ci/), [VirtualBox](https://www.virtualbox.org/), and [Vagrant](https://www.vagrantup.com/).

You can find more information on this testing method by reviewing Kitchen's [Getting Started Guide](http://kitchen.ci/docs/getting-started) or by completing Chef's [Local Development and Testing](https://learn.chef.io/tracks/local-development-and-testing#/) module.

## Usage

Steps to test this cookbook:

* Clone this repo:
    ``` bash
    mkdir community_cookbook
    cd community_cookbook
    git clone -b community_cookbook https://github.com/jmassardo/workshops.git
    ```
* Change directories to the cookbook directory:
    ``` bash
    cd workshops/1_MongoDB/Install_MongoDB
    ```
* Run with Test Kitchen
    ``` bash
    kitchen test
    ```