# ----------------------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#
# Executes the deployment by pushing all necessary configurations and patches

define gateway::deploy ($security, $target, $owner, $group) {
  file { "/tmp/${gateway::deployment_code}":
    ensure       => present,
    owner        => $owner,
    group        => $group,
    sourceselect => all,
    ignore       => '.svn',
    recurse      => true,
    source       => [
      'puppet:///modules/gateway/configs/',
      'puppet:///modules/gateway/patches/']
  }

  file {
    "${gateway::carbon_home}/repository/components/lib/${gateway::mysql_connector_name}":
      ensure => present,
      source => ["puppet:///modules/gateway/${gateway::mysql_connector_name}"],
      mode    => '0755'
  }

  file {
    "${gateway::carbon_home}/repository/components/dropins/${gateway::svn_kit_file_name}":
      ensure => present,
      source => ["puppet:///modules/gateway/${gateway::svn_kit_file_name}"],
      mode    => '0755'
  }

  file {
    "${gateway::carbon_home}/repository/components/lib/${gateway::trilead_ssh_file_name}":
      ensure => present,
      source => ["puppet:///modules/gateway/${gateway::trilead_ssh_file_name}"],
      mode    => '0755'
  }

  exec {
    "Copy_${name}_modules_to_carbon_home":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      command => "cp -r /tmp/${gateway::deployment_code}/* ${target}/; chown -R ${owner}:${owner} ${target}/; chmod -R 755 ${target}/",
      require => File["/tmp/${gateway::deployment_code}"];

    "Remove_${name}_temporory_modules_directory":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      command => "rm -rf /tmp/${gateway::deployment_code}",
      require => Exec["Copy_${name}_modules_to_carbon_home"];
  }
}
