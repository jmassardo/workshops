# Middleman

This cookbook installs and tests the Middleman webapp.

## Cookbook Info

This cookbook makes use of the following Chef Resources:

* [File](https://docs.chef.io/resource_file.html)
* [Template](https://docs.chef.io/resource_template.html)
* [Package](https://docs.chef.io/resource_package.html)
* [Service](https://docs.chef.io/resource_service.html)
* [Script](https://docs.chef.io/resource_script.html)
* [Execute](https://docs.chef.io/resource_execute.html)
* [Whitespace Arrays](https://docs.chef.io/resource_examples.html#package)

>Since this cookbook uses the [Execute](https://docs.chef.io/resource_execute.html) resource, it also has [guards](https://docs.chef.io/resource_common.html#guards) or conditional statements to prevent the resource from continually executing and possibly breaking the system. This improves the [idempontency](https://en.wikipedia.org/wiki/Idempotence) of the cookbook

## Testing

This cookbook was tested using [Test Kitchen](http://kitchen.ci/), [Kitchen-AzureRM](https://github.com/test-kitchen/kitchen-azurerm), and [Microsoft Azure](https://portal.azure.com).

You can find more information on this testing method by reviewing Kitchen's [Getting Started Guide](http://kitchen.ci/docs/getting-started) or by completing Chef's [Local Development and Testing](https://learn.chef.io/tracks/local-development-and-testing#/) module.

The [Kitchen-AzureRM GitHub Page](https://github.com/test-kitchen/kitchen-azurerm) has detailed instructions on configuring Test Kitchen to use the Azure provider.

The simple steps are:

* Create a Service Principal
* Add the Service Principal, SubscriptionID, etc. to the `~/.azure/credentials` file.
  >Note: the .azure folder needs to be in your home directory
* Change the driver, driver config.
* Add the driver config and image_urn to the Platforms section

## Usage

Steps to test this cookbook:

* Clone this repo:
    ``` bash
    mkdir middleman
    cd middleman
    git clone -b middleman https://github.com/jmassardo/workshops.git
    ```
* Change directories to the cookbook directory:
    ``` bash
    cd workshops/3_Bonus/Middleman/middleman
    ```
* Run with Test Kitchen
    ``` bash
    kitchen test
    ```
