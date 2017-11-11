# Install_Tomcat

This cookbook installs and tests a base install of Tomcat.

## Cookbook Info

This cookbook makes use of the following Chef Resources:

* [Directory](https://docs.chef.io/resource_directory.html)
* [Template](https://docs.chef.io/resource_template.html)
* [Package](https://docs.chef.io/resource_package.html)
* [Service](https://docs.chef.io/resource_service.html)
* [Group](https://docs.chef.io/resource_group.html)
* [User](https://docs.chef.io/resource_user.html)
* [Remote_file](https://docs.chef.io/resource_remote_file.html)
* [Execute](https://docs.chef.io/resource_execute.html)

>Since this cookbook uses the [Execute](https://docs.chef.io/resource_execute.html) resource, it also has [guards](https://docs.chef.io/resource_common.html#guards) or conditional statements to prevent the resource from continually executing and possibly breaking the system. This improves the [idempontency](https://en.wikipedia.org/wiki/Idempotence) of the cookbook

## Testing

This cookbook was tested using [Test Kitchen](http://kitchen.ci/), [VirtualBox](https://www.virtualbox.org/), and [Vagrant](https://www.vagrantup.com/).

You can find more information on this testing method by reviewing Kitchen's [Getting Started Guide](http://kitchen.ci/docs/getting-started) or by completing Chef's [Local Development and Testing](https://learn.chef.io/tracks/local-development-and-testing#/) module.

## Usage

Steps to test this cookbook:

* Clone this repo:
    ``` bash
    mkdir ubuntu_support
    cd ubuntu_support
    git clone -b ubuntu_support https://github.com/jmassardo/workshops.git
    ```
* Change directories to the cookbook directory:
    ``` bash
    cd ~/workshops/2_Tomcat/Install_Tomcat
    ```
* Run with Test Kitchen
    ``` bash
    kitchen test
    ```
