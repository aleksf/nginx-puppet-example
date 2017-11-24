nginx-puppet-example
====================


#Description

Repository contains Vagrantfile and Puppet modules to setup nginx to serve content on port 8000

Solution is designed following **Puppet Roles and Profiles** pattern and contains rspec-puppet unit tests under nginx module
At the current stage solution is applicable to **RedHat** osfamily only, however it is easy to extend it to use osfamily hiera overrides or OS specific params.pp

##Dependencies

S0lution depends on Puppetlabs firewall module that comes by default in PE. 
It is also available from the Forge. Install puppetlabs-firewall module if it is not present.

 <code># puppet module install puppetabs-firewall</code>
 
If using Vagrant, solution depends on vagrant-serverspec plugin

 <code># vagrant plugin install vagrant-serverspec</code>

##Modules layout

| Module        | Description   |
| ------------- |:-------------:|
| role    | module that contains role::webserver class that applies to the node in site.pp |
| profile | lower level abstraction module that icludes 2 classes
| profile::base | base OS resources, that contains EPEL yumrepo and git package resources |
| profile::nginx | nginx profile that includes lower level nginx module and also uses Puppetlabs firewall resource to enable INCOMING traffic on port 8000 |
| nginx | low level abstraction class that defines nginx package/file/service resources in init.pp |
| nginx::vhost | defined type that takes vhost_name and vhost_port arguments and passes them to nginx vhost ERB template and git_content_url (optional) |

##Workflow

  1. base profile resources are applied first - epel yum repo and git package
  2. nginx resources are applied - package, file, service
  3. vhost define is applied that passes variable values from profile::nginx to ERB template that assembles vhost config file
  4. nginx config is reloaded
  5. INCOMING allow iptables firewall rule added for port 8000
  6. git clone is invoked to fetch https://github.com/puppetlabs/exercise-webpage content under vhost root

##Usage
  
  1. Copy modules from puppet/modules in your modulepath
  2. Make sure puppetlabs firewall module is installed - look in your modulepath or execute command
     <code># puppet module list<code>
  3. In your ENC or site.pp assign following class to the node - **role::webserver**

##Unit testing

  Rspec-puppet testing covers nginx resources in main class and vhost config file contents in defined type
  
  1. Install required gems - cd to nginx module and execute **bundle install**
  2. Run **rake spec** from nginx module directory

##Integration testing

  Serverspec test nginx_spec.rb is integrated with vagrant provisioning and verifies TCP port, nginx service and package as well as OS process name.
