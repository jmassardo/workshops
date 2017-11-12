# Test Instructions

This page lists the instructions to test/validate each workshop section. Each cookbook contains a readme file that includes information about the specific resources that are used along with some simple steps to conduct a test. The clone/test information is also included below.

This page makes the following assumptions: 

* The tester is using a Mac or Linux system.
    >Note: If the tester is using a Windows system, there are a few changes. Please remember to reverse slashes (Mac/Linux uses forward slashes ( / ) while Windows uses backslashes ( \\ ). Also, the tester will need to ensure that [Git for Windows](https://git-scm.com/download/win) is installed.
* This also assumes that the tester has an updated and fully functional install of [ChefDK](https://downloads.chef.io/chefdk), [Test Kitchen](http://kitchen.ci/), [VirtualBox](https://www.virtualbox.org/), and [Vagrant](https://www.vagrantup.com/).
* To successfully test the Middleman branch, the tester will need access to Azure or will need to replace the `kitchen.yml` file. Additional information is included below.

>You can find more information on this testing method by reviewing Kitchen's [Getting Started Guide](http://kitchen.ci/docs/getting-started) or by completing Chef's [Local Development and Testing](https://learn.chef.io/tracks/local-development-and-testing#/) module.

## Branches

There are 6 branches in this project. Each branch has several demonstration items.

* [Master](#master)
* [Community Cookbooks](#community-cookbooks)
* [Ubuntu Support](#ubuntu-support)
* [AAR_V1](#aar_v1)
* [Middleman](#middleman)
* [Testing](#testing)

### Master

The [master branch](https://github.com/jmassardo/workshops) is a clone of the [Chef_SA_Workshop](https://github.com/chef-cft/workshops) repository. It also includes the solution for the first two workshop objectives.

1. The first objective is to create a cookbook that can install MongoDB.
    * Clone this repo:
        ``` text
        mkdir master
        cd master
        git clone -b master https://github.com/jmassardo/workshops.git
        ```
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/1_MongoDB/Install_MongoDB
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```
2. The second objective is to create a cookbook that can install Tomcat
    * Clone this repo:
        ``` text
        mkdir master
        cd master
        git clone -b master https://github.com/jmassardo/workshops.git
        ```
        >If the clone was completed in step 1, it isn't necessary to do it a second time for this branch.
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/2_Tomcat/Install_Tomcat/
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```

### Community Cookbooks

The [community_cookbook](https://github.com/jmassardo/workshops/tree/community_cookbook) is a branch of master. This branch includes modifications to the initial cookbooks that change from using native Chef resources to community cookbooks.

1. The MongoDB cookbook was reconfigured to use the [sc-mongodb](https://supermarket.chef.io/cookbooks/sc-mongodb) cookbook from the Chef [Supermarket](https://supermarket.chef.io/).
    * Clone this repo:
        ``` text
        mkdir community_cookbook
        cd community_cookbook
        git clone -b community_cookbook https://github.com/jmassardo/workshops.git
        ```
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/1_MongoDB/Install_MongoDB
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```
2. The Tomcat cookbook was reconfigured to use the [tomcat](https://supermarket.chef.io/cookbooks/tomcat) cookbook from the Chef [Supermarket](https://supermarket.chef.io/).
    * Clone this repo:
        ``` text
        mkdir community_cookbook
        cd community_cookbook
        git clone -b community_cookbook https://github.com/jmassardo/workshops.git
        ```
        >If the clone was completed in step 1, it isn't necessary to do it a second time for this branch.
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/2_Tomcat/Install_Tomcat/
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```

### Ubuntu Support

The [ubuntu_support](https://github.com/jmassardo/workshops/tree/ubuntu_support) is a branch of master. This branch includes modifications to the initial cookbooks to support both [CentOS](https://www.centos.org/) and [Ubuntu](https://www.ubuntu.com/).

1. The MongoDB cookbook was reconfigured as a [wrapper cookbook](https://blog.chef.io/2017/02/14/writing-wrapper-cookbooks/). This cookbook uses a single condition in the default recipe to select an OS specific recipe to complete the configuration.
    * Clone this repo:
        ``` text
        mkdir ubuntu_support
        cd ubuntu_support
        git clone -b ubuntu_support https://github.com/jmassardo/workshops.git
        ```
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/1_MongoDB/Install_MongoDB
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```
2. The Tomcat cookbook was reconfigured to use multiple [logic conditions](https://docs.chef.io/ruby.html#if) in a single recipe.
    * Clone this repo:
        ``` text
        mkdir ubuntu_support
        cd ubuntu_support
        git clone -b ubuntu_support https://github.com/jmassardo/workshops.git
        ```
        >If the clone was completed in step 1, it isn't necessary to do it a second time for this branch.
    * Change directories to the cookbook directory:
        ``` text
        cd workshops/2_Tomcat/Install_Tomcat/
        ```
    * Run with Test Kitchen
        ``` text
        kitchen test
        ```

### AAR_v1

This bonus workshop activity is to create a cookbook that installs the Awesome Appliance Repair application. This task includes translating the current python script to a Chef cookbook.

>Note: This cookbook is only for non-production or demonstration purposes. This cookbook will need additional features including additional [guards](https://docs.chef.io/resource_common.html#guards) along with secrets management - [Chef Vault](https://docs.chef.io/chef_vault.html) or [HashiCorp Vault](https://www.vaultproject.io/)

* Clone this repo:
    ``` text
    mkdir aar_v1
    cd aar_v1
    git clone -b aar_v1 https://github.com/jmassardo/workshops.git
    ```
* Change directories to the cookbook directory:
    ``` text
    cd workshops/3_Bonus/Awesome_Appliance_Repair/aar
    ```
* Run with Test Kitchen
    ``` text
    kitchen test
    ```
* View the test results
    * There are two Inspec tests to automatically. The results of these tests are part of the output of the `kitchen test` command.
        * The first checks to see if the server is listening on port 80
        * The second test executes a command and parses the output.

            ``` bash
            $ curl localhost | grep Awesome
            ```

    * The AAR kitchen.yml is configured to expose ports 80 to allow the tester to manually view the site in addition to the Inspec test.

        ``` yaml
        # Snippet from kitchen.yml
        platforms:
        - name: ubuntu-16.04
            driver_config:
            network:
            - ["forwarded_port", {guest: 80, host: 8080}]
            - ["private_network", {ip: "192.168.33.1"}]
        ```

### Middleman

Middleman is an additional bonus workshop exercise that installs a static site generator. This task requires automating the existing manual process.

This cookbook makes use of `each` loops since there are a number of packages that are required.

* Clone this repo:
    ``` text
    mkdir middleman
    cd middleman
    git clone -b middleman https://github.com/jmassardo/workshops.git
    ```
* Change directories to the cookbook directory:
    ``` text
    cd workshops/3_Bonus/Middleman/middleman
    ```
* Select preferred `kitchen.yml`. Azure is the default. Use the command below to swap over to Vagrant. The second command will swap back from Vagrant to Azure
    ``` bash
    # Use Vagrant
    mv .kitchen.yml .kitchen.azure.yml && mv .kitchen.vagrant.yml .kitchen.yml

    # Use Vagrant
    mv .kitchen.yml .kitchen.vagrant.yml && mv .kitchen.azure.yml .kitchen.yml
    ```
* Run with Test Kitchen
    ``` text
    kitchen test
    ```

### Testing

```
TODO
```