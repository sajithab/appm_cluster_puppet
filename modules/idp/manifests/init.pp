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
# Class: idp
#
# This class installs WSO2 AppManager as a IDP
# Actions:
#   - Install WSO2 AppManager as a IDP
#
# Requires:
#
# Sample Usage:
#

class idp (

  $version            = undef,
  $sub_cluster_domain = undef,
  $members            = undef,
  $offset             = 0,
  $hazelcast_port     = 4000,
  $thrift_receive_port= undef,
  $config_db          = 'governance',
  $config_target_path = 'config/as',  
  $maintenance_mode   = true,
  $depsync            = false,
  $clustering         = false,
  $cloud              = false,
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",

) inherits params {

  $deployment_code = 'idp'
  $carbon_version  = $version
  $service_code    = 'appm'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"
  $service_templates = [
    'conf/app-manager.xml',
    'conf/carbon.xml',
    'conf/registry.xml',
    'conf/user-mgt.xml',
    'conf/sso-idp-config.xml',
    'conf/datasources/master-datasources.xml',
    #'conf/tomcat/catalina-server.xml',
  ]

  tag($service_code)

  idp::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  idp::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => Idp::Clean[$deployment_code],
  }

  idp::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => Idp::Initialize[$deployment_code],
  }

  idp::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => Idp::Deploy[$deployment_code];
  }

  file {
    "${carbon_home}/repository/components/lib/${idp::mysql_connector_name}":
      ensure => present,
      source => ["puppet:///modules/${deployment_code}/${idp::mysql_connector_name}"],
      mode    => '0755',
      require   => Idp::Push_templates[$service_templates];
  }

  file { "/etc/hosts":
      ensure  => present,
      owner   => $idp::owner,
      group   => $idp::group,
      mode    => '0755',
      content => template("${idp::deployment_code}/etc/hosts.erb"),
      require   => Idp::Push_templates[$service_templates];
  }



  idp::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      Idp::Initialize[$deployment_code],
      Idp::Deploy[$deployment_code],
      Idp::Push_templates[$service_templates],
      ],
  }
}
